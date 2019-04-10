function JE=computeJE(x,params)

if isfield(params,'mask')
    x=x(params.mask==1);
else
    x=x(:);
end



sig_x = params.sig_x;
% sig_y = params.imy.sig_y;
M = params.M; % pxy will be M x M
imy = params.imy;
Gv = imy.Gv;
dv = imy.dv;
Ns = length(x);

if mod(M,2)==0,
    M=M+1;
    display(['M changed to odd value of ',num2str(M)]);
end

umax = max(abs(x(:))) + 3*sig_x;
du = umax*2/(M-1);%

u = linspace(-umax,umax,M)'; %bins, symmetric for gaussian kernal

Gu=(exp(-(u.^2)/sig_x^2/2))/sqrt(2*pi)/sig_x;
Guv=Gu*Gv';
P=zeros(M,M);

xidxl=floor(x/du)+1+(M-1)/2;
xidxh=xidxl+1;
xwl=(u(xidxh)-x)/du;
xwh=(x-u(xidxl))/du;

yidxl=imy.yidxl;
yidxh=imy.yidxh;
ywl=imy.ywl;
ywh=imy.ywh;

for k=1:Ns,
    P(xidxl(k),yidxl(k)) = P(xidxl(k),yidxl(k)) + xwl(k)*ywl(k);
    P(xidxl(k),yidxh(k)) = P(xidxl(k),yidxh(k)) + xwl(k)*ywh(k);
    P(xidxh(k),yidxl(k)) = P(xidxh(k),yidxl(k)) + xwh(k)*ywl(k);
    P(xidxh(k),yidxh(k)) = P(xidxh(k),yidxh(k)) + xwh(k)*ywh(k);
end

P=P/Ns;

puv=(ifftn(fftn(Guv,[2*M-1, 2*M-1]).*fftn(P,[2*M-1, 2*M-1])));
puv=puv(floor(M-M/2+1:M+M/2),floor(M-M/2+1:M+M/2));
puv=puv/sum(sum(puv*du*dv));


JE=-sum(sum((puv).*log(puv+params.EPS)))*du*dv;






