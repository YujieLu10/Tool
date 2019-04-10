function f=farmijoH(x,y,params,reg_par)

x = x(:);
y = y(:);

% Data fit
r = y - fwdprojH(x,params);
f1=0.5*(r'*r);

% Prior
if reg_par==0,
    f=f1;
else
    x=x(params.mask==1);
    sig_x = params.sig_x;
    M = params.M;
    imy = params.imy;
    Ns = length(x);
    TH = max(abs(x(:))) + 3*sig_x;
    dx = TH*2/(M-1);%
    xx = linspace(-TH,TH,M); %bins, symmetric for gaussian kernal
    xx = xx';
    
    xmap = zeros(M,1);
    xymap = zeros(M,M);
    xind1 = floor((x-xx(1))/dx)+1; % x location index on xx grid
    xind2 = xind1+1;
    xdis1 = x - xx(xind1);% x distance from nearby bins
    xdis2 = xx(xind2) - x;
    
    for i = 1:Ns
        xmap(xind1(i)) = xmap(xind1(i)) + xdis2(i)/dx;
        xmap(xind2(i)) = xmap(xind2(i)) + xdis1(i)/dx;
        
        xymap(xind1(i),imy.yind1(i)) = xymap(xind1(i),imy.yind1(i))+...
            xdis2(i)/dx*imy.ydis2(i)/imy.dy;
        xymap(xind1(i),imy.yind2(i)) = xymap(xind1(i),imy.yind2(i))+...
            xdis2(i)/dx*imy.ydis1(i)/imy.dy;
        xymap(xind2(i),imy.yind1(i)) = xymap(xind2(i),imy.yind1(i))+...
            xdis1(i)/dx*imy.ydis2(i)/imy.dy;
        xymap(xind2(i),imy.yind2(i)) = xymap(xind2(i),imy.yind2(i))+...
            xdis1(i)/dx*imy.ydis1(i)/imy.dy;
    end
    xymap = xymap/Ns;
    
    M1 = M + M -1;
    ncoef1 = 1/sqrt(2*pi)/sig_x;
    ncoef2 = -1/2/sig_x^2;
    phi_x = zeros(M1,1);
    phi_x(1:M) = ncoef1*exp(ncoef2*xx.^2);
    phi_xy = zeros(M1,M1);
    phi_xy(1:M,1:M) = phi_x(1:M)*(imy.phi_y(1:M)');
    xymap_pad = zeros(M1,M1);
    xymap_pad(1:M,1:M) = xymap;
    tmp = ifft2(fft2(phi_xy).*fft2(xymap_pad));
    pxy = tmp(imy.origin:M+imy.origin-1,imy.origin:M+imy.origin-1);
    pxy = pxy/sum(sum(pxy*dx*imy.dy));%normalization
    
    %compute JE
    f2 = -sum(sum((pxy).*log(pxy+imy.EPS)))*dx*imy.dy;
    f = f1 + reg_par*f2;

end






