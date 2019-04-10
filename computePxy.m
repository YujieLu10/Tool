function [puv0 U0 V0 P puv U V] =  computePxy(x,params)
% computes joint histogram
if isfield(params,'mask')
    x=x(params.mask==1);
else
    x=x(:);
end

% x = x(:);
sig_x = params.sig_x;
sig_y = params.imy.sig_y;
M = params.M; % pxy will be M x M
imy = params.imy;
Ns = length(x);
if mod(M,2)==0,
    M=M+1;
    display(['M changed to odd value of ',num2str(M)]);
end

umax = max(abs(x(:))) + 3*sig_x;
du = umax*2/(M-1);%

u = linspace(-umax,umax,M)'; %bins, symmetric for gaussian kernal
% xx = xx';
% u=u-umax/2;

[U V]=ndgrid(u,u);
Guv=(exp(-(U.^2)/sig_x^2/2)).*(exp(-(V.^2)/sig_y^2/2))/(2*pi)/sig_x/sig_y;
P=zeros(M,M);

xidxl=floor(x/du)+1+(M-1)/2;
xidxh=xidxl+1;
xwl=(u(xidxh)-x)/du;
xwh=(x-u(xidxl))/du;


for k=1:Ns,
    P(xidxl(k),imy.yidxl(k)) = P(xidxl(k),imy.yidxl(k)) + xwl(k)*imy.ywl(k);
    P(xidxl(k),imy.yidxh(k)) = P(xidxl(k),imy.yidxh(k)) + xwl(k)*imy.ywh(k);
    P(xidxh(k),imy.yidxl(k)) = P(xidxh(k),imy.yidxl(k)) + xwh(k)*imy.ywl(k);
    P(xidxh(k),imy.yidxh(k)) = P(xidxh(k),imy.yidxh(k)) + xwh(k)*imy.ywh(k);
end

P=P/Ns;

puv=(ifftn(fftn(Guv,[2*M-1, 2*M-1]).*fftn(P,[2*M-1, 2*M-1])));
puv=puv(floor(M-M/2+1:M+M/2),floor(M-M/2+1:M+M/2));

puv0=double(puv((M-1)/2+1:M,(M-1)/2+1:M));
[U0 V0]=ndgrid(u((M-1)/2+1:M),imy.v((M-1)/2+1:M));

% myfigure;
pcolor(U0,V0,puv0);
shading interp
axis equal tight

