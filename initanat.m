function imy = initanat(y,M,sig_y,EPS,mask)
% computes joint histogram
if exist('mask','var')
    y=y(mask==1);
else
    y=y(:);
end

if mod(M,2)==0,
    M=M+1;
    display(['M changed to odd value of ',num2str(M)]);
    error('Bin number should be odd');
end

Ns = length(y);
vmax = max(abs(y(:))) + 3*sig_y;
dv = vmax*2/(M-1);%keep this symmetric for gaussian kernal
v = linspace(-vmax,vmax,M)';%bins    
% v = v';

yidxl=floor(y/dv)+1+(M-1)/2;
yidxh=yidxl+1;
ywl=(v(yidxh)-y)/dv;
ywh=(y-v(yidxl))/dv;

p=zeros(M,1);

for k=1:Ns
    p(yidxl(k)) = p(yidxl(k)) + ywl(k);
    p(yidxh(k)) = p(yidxh(k)) + ywh(k);
end

Gv=(exp(-(v.^2)/sig_y^2/2))/(sqrt(2*pi))/sig_y;

p=p/Ns;

pv=(ifft(fft(Gv,2*M-1).*fft(p,2*M-1)));
pv=pv(floor(M-M/2+1:M+M/2));
Hy=-sum((pv).*log(pv+EPS))*dv;

imy.y=y;
imy.Ns=Ns;
imy.sig_y=sig_y;
imy.vmax=vmax;
imy.v=v;
imy.dv=dv;
imy.yidxl=yidxl;
imy.yidxh=yidxh;
imy.ywl=ywl;
imy.ywh=ywh;
imy.pv=pv;
imy.Hy=Hy;
imy.v0=v((M-1)/2+1:M);
imy.Gv=Gv;

