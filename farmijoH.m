function f=farmijoH(x,y,params,reg_par)
% f=farmijoH(x,y,params,reg_par)
% function to be MINIMIZED
% L2 norm of residual
% JE and hence integral of -p log(p)

x = x(:);
y = y(:);

% Data fit
r = y - fwdprojH1(x,params);
f1=0.5*(r'*r); % L2 norm of residual to be MINIMIZED

% Prior
if reg_par==0,
    f=f1;
else
    %compute JE
    f2 = computeJE(x,params);
    f = f1 + reg_par*f2; % joint entropy to be MINIMIZED

end
