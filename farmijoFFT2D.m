function f=farmijoFFT2D(x,y,params,reg_par)
% f=farmijoH(x,y,params,reg_par)
% function to be MINIMIZED
% L2 norm of residual
% JE and hence integral of -p log(p)

x = x(:);
y = y(:);

% Data fit
r = y - fwdprojFFT2D(x,params);
f1=0.5*(r'*r);

% Prior
if reg_par==0,
    f=f1;
else
    %compute JE
    f2 = computeJE(x,params);
    f = f1 + reg_par*f2;

end






