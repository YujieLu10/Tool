function [step_size fi]= Armijo(xk,dk,gk,y,farmijo,params,reg_par,s)

if nargin<8,
    s=2;
end
N=10000;
beta_armijo=0.5;
sigma_armijo=1e-1;
fk = feval(farmijo,xk,y,params,reg_par);
NoConverge=1;
ii=0;


while NoConverge==1 && ii<N,
%     iarmijo=ii
    ii=ii+1;
    s=s*beta_armijo;
    xi=xk+s*dk;
    xi=double(xi);
    fi = feval(farmijo,xi,y,params,reg_par);   
    
    if fk-fi>=-sigma_armijo*s*gk'*dk,
        NoConverge=0;
    end   
    
end

if NoConverge==1,
    display(['Armijo did not converge in ' num2str(ii),' iterations.'])
else
    display([num2str(ii),' Armijo iterations done.'])
end

% figure, plot(f_all(1:ii))

step_size=s;

