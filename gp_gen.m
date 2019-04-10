function [xs fs] = gp_gen(xinit,y,params,reg_par,niter, fwdproj, bckproj, precond, gradreg, farmijo, con_flag, chat_flag, mask_flag,s0)
% function [xs fs] = gp_gen_mask(xinit,y,params,reg_par,niter, fwdproj, bckproj, precond, gradreg, farmijo, con_flag, chat_flag)
% By Joyita Dutta
% MGH
%
%   Gradient Projection Method
%   Matrix-free version
%
%   Input
%       xinit:      initial image nx x ny x nz or (nx*ny*nz) x 1
%       y:          data
%       params:     includes system matrix
%                   should be compatible with fwdproj,bckproj,precond,
%                   gradreg, and farmijo
%       reg_par:    regularization parameter (scalar)
%       niter:      total iteration number
%       fwdproj:    forward projection function handle
%       bckproj:    backprojection function handle
%       precond:    preconditioner 
%                   if function handle, then passed
%                   if string, options are:
%                   'no'->  no preconditioner (default)
%                   'em'->  EM-type preconditioner
%                   'dd'->  Hessian diagonal - option not available currently
%                   if numeric, should be the diagaonal preconditioner
%                   vector
%       gradreg:    regularizaton gradient function handle
%       farmijo:    function handle evaluating cost function
%       con_flag:   'con'-> positivity constrained (default)
%                   'unc'-> unconstrained
%       chat_flag:  'on'->  displays iteration number (default)
%                   'off'-> no display 
%   Output
%       xs: reconstructed image sequence ((nx*ny*nz) x niter+1)
%       fs: cost function sequence (niter+1 x 1)
%
% By Joyita Dutta

if nargin < 8, precond = 'no'; end
if nargin < 11, con_flag = 'con'; end
if nargin < 12, chat_flag = 'on'; end
if nargin < 13, mask_flag = 0; end
if nargin < 14, s0=1; end

if ~strcmp(con_flag, 'con') && ~strcmp(con_flag, 'unc')
    error('unknown con_flag')
end

if ~strcmp(chat_flag, 'on') && ~strcmp(chat_flag, 'off')
    error('unknown chat_flag')
end

%%%%%%%%%%%%%%%%%%%% Initialize %%%%%%%%%%%%%%%%%%%%
if isfield(params,'mask') && mask_flag==1,
    xinit = xinit(:).*params.mask(:);
    y = y(:).*params.mask(:);
else
    xinit=xinit(:);
    y=y(:);
end

xs = zeros(length(xinit), niter+1);
xs(:,1) = xinit;
fs=zeros(niter + 1,1);
fs(1) = feval(farmijo,xs(:,1),y,params,reg_par);


%%%% Compute diagonal preconditioner vector dpre %%%% 
if isa(precond,'function_handle'),
    dpre =feval(precond,params);
elseif isnumeric(precond)
    dpre = precond;
elseif isa(precond,'char'),
    if strcmp(precond, 'no'),
        dpre=ones(size(xinit));
    elseif strcmp(precond, 'em'),
        colsum=feval(bckproj,params,ones(size(y)));
        dpre = 1 ./  colsum;
    end
else
    error('Incorrect preconditioner input');
end


Aty = feval(bckproj,y,params);

%%%%%%%%%%%%%%%%%% Start iterating %%%%%%%%%%%%%%%%%%
for it = 1:niter,
    if strcmp(chat_flag, 'on')
        display(['GP iteration # ',num2str(it)]);
    end
    
    Ax=feval(fwdproj,xs(:,it),params);
    g1 = feval(bckproj,Ax,params) - Aty; % AtAx - Aty, data fit gradient
    if reg_par==0,
        g2=zeros(size(g1)); % regularizer gradient
    else
        g2 = feval(gradreg,xs(:,it),params); % regularizer gradient
    end
    
    if isfield(params,'mask') && mask_flag==1, 
        g = (g1 + reg_par*g2).*params.mask(:); % combined gradient
    else
        g = (g1 + reg_par*g2); % combined gradient
    end
    % %   Left intact for debugging
    %     temp=reshape(g1,params.sizex); myfigure; myimagesc(temp(:,:,32)); colorbar
    %     temp=reshape(g2,params.sizex); myfigure; myimagesc(temp(:,:,32)); colorbar
    %     temp=reshape(g,params.sizex); myfigure; myimagesc(temp(:,:,32)); colorbar
    
    r = dpre .* g; % scale gradient by preconditioner
    
    d = - r; % search direction
    
    
    % initialize Armijo with gradratic stepsize    
    if isfield(params,'mask') && mask_flag==1,
        Ad=feval(fwdproj,d,params).*params.mask(:); % compute to determine quadratic step size
    else
        Ad=feval(fwdproj,d,params); % compute to determine quadratic step size
    end
    sinit= - d'*g1/(Ad'*Ad)/it*s0;
    
    if reg_par==0,
        % Quadratic cost only: compute step size in closed form
        alpha= -d'*g1/(Ad'*Ad);
        fs(it+1)=feval(farmijo, xs(:,it)+alpha*d, y, params, reg_par);
    else
        % Non-quadratic: Compute step size with an Armijo line search
        [alpha fs(it+1)]= Armijo(xs(:,it),d,g,y,farmijo,params,reg_par,sinit);
    end
    
    % Non-negativity constraint: determine feasible direction
    if strcmp(con_flag, 'con')       
        z = xs(:,it) + alpha*d;
        
        if any(min(z, 0)),
            d = max(z, 0) - xs(:,it); % feasible direction
            
            % New step size
            if reg_par==0,
                if isfield(params,'mask') && mask_flag==1,
                    Ad=feval(fwdproj,d,params).*params.mask(:); % compute to determine quadratic step size
                else
                    Ad=feval(fwdproj,d,params); % compute to determine quadratic step size
                end
                alpha=-d'*g1/(Ad'*Ad);
            else
                alpha = Armijo(xs(:,it),d,g,y,farmijo,params,reg_par);
            end
            % Constrain step size between 0 and 1
            alpha = max(alpha, 0);
            alpha = min(alpha, 1);
            % Evaluate function
            fs(it+1)=feval(farmijo,xs(:,it)+alpha*d,y,params,reg_par);
            
%             if it==3,
%                 it
%             end
        end
    end
    
    xs(:,it+1) = xs(:,it) + alpha*d;
    
    save dump_interim_gp xs fs it
    
end

if isfield(params,'sizex'),
    xs=reshape(xs,[params.sizex, niter+1]);
end


