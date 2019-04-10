function  Histogram_show( PET,MRI,sigscale_x,sigscale_y,axes1 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
EPS = 1e-8;
params.EPS=EPS;
sig_y=max(PET(:))/sigscale_y;
params.sig_x=max(PET(:))/sigscale_x;
M = max(size(PET))*3+1;%pdf sample number
params.M=M; 
temp=zeros(size(PET));
temp(PET>0)=1;
temp=imfill(temp);
params.mask=zeros(size(PET));
params.mask(temp>0.02)=1;  
params.imy = initanat(MRI*max(PET(:))/max(MRI(:)),M,sig_y,EPS,params.mask);
params.imx = initanat(PET,M,params.sig_x,EPS,params.mask);
[puv0 U0 V0 , ~, U V]=computePxy(PET(:),params);
axis (axes1);  
myimagesc(flipud(puv0)); 
colorbar;

end

