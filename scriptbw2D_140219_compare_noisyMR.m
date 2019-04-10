%% Differences
% Noisy MR
% Middle PSF used for deblurring

%% Load files

clear all
close all

load imsimI0J0 
load blurinterp2D

%% Generate Data

nx=128;
ny=128;

H0=H(:,:,3); % Different from scriptbw2D_140218
D0=ones(size(H0));


params.H=H;
params.D=D;
params.sizex=[nx ny];

In=I0/20.*randn(size(I0));
I = I0 + In;
I = fwdprojFFT2D(I,params);
I = reshape(I,params.sizex);

myfigure; 
myimagesc(I)
colorbar


J2=J0;
J2(P0==4)=0;

close all
temp=zeros(size(I));
temp(I0>0)=1;
temp=imfill(temp);
temp=reshape(fwdprojFFT2D(temp,params),params.sizex);
params.mask=zeros(nx,ny);
params.mask(temp>0.02)=1;
myfigure; myimagesc(params.mask)

J2=J2.*params.mask;

%%
close all
Jnew=zeros(nx,ny);
Jnew(P0==3)=200;
Jnew(P0==2)=100;
Jnew=Jnew+(Jnew/10).*randn(nx,ny); % Different from scriptbw2D_140218
myfigure; 
myimagesc(Jnew), colormap gray

%% Prepare MR stuff
close all
% params.mask=zeros(size(I));
% params.mask(P0>0)=1;
% params.mask=imfill(params.mask);
myfigure; myimagesc(params.mask)
myfigure; myimagesc(I)

close all
sigscale=10; % USED 15/50 with 60/25 iterations
EPS = 1e-8;
params.EPS=EPS;
sig_y=max(I(:))/sigscale;
params.sig_x=max(I(:))/sigscale;
M = max(size(I))*3+1;%pdf sample number
params.M=M;
params.imy = initanat(Jnew*max(I(:))/max(Jnew(:)),M,sig_y,EPS,params.mask);
myfigure; plot(params.imy.v,params.imy.pv)
grid on
title('MR')
params.imx = initanat(I,M,params.sig_x,EPS,params.mask);
myfigure; plot(params.imx.v,params.imx.pv)
grid on
title('PET')
[puv0 U0 V0 puv U V]=computePxy(I(:),params);
myfigure;  myimagesc(puv0);
%%
close all
myfigure;
subplot 221
myimagesc(Jnew*max(I(:))/max(Jnew(:))), colorbar
subplot 222
myimagesc(I), colorbar
subplot 223
plot(params.imy.v,params.imy.pv)
axis tight
grid on
title('MR')
subplot 224
plot(params.imx.v,params.imx.pv)
axis tight
grid on
title('PET')
%%
close all
g1 = reshape(bckprojFFT2D(fwdprojFFT2D(I,params),params) - bckprojFFT2D(I,params),params.sizex);
myfigure; myimagesc(-g1),colorbar

g2=reshape(gradanat(I,params),params.sizex);
myfigure; myimagesc(-g2),colorbar

myfigure; myimagesc(-g1-2e7*g2),colorbar




%% 1. SUPSF-No Prior
close all

params.H=H0;
params.D=D0;

reg_par=0;
num_iter=60;
step_size=1;
tic
[xsu0 fsu0] = gp_gen(I,I,params,reg_par,num_iter, @fwdprojFFT2D, @bckprojFFT2D, 'no', @gradanat, @farmijoFFT2D, 'con', 'on',1,step_size);
toc
% myfigure;
% plot(fsu0,'ro-','linewidth',4,'markerfacecolor','r')

%% 3. SVPSF-No Prior
close all

params.H=H;
params.D=D;

reg_par=0;
num_iter=60;
step_size=1;
tic
[xsv0 fsv0] = gp_gen(I,I,params,reg_par,num_iter, @fwdprojFFT2D, @bckprojFFT2D, 'no', @gradanat, @farmijoFFT2D, 'con', 'on',1,step_size);
toc
% myfigure;
% plot(fsv0,'ro-','linewidth',4,'markerfacecolor','r')

%% 3. SUPSF-JE Prior
close all

params.H=H0;
params.D=D0;

reg_par=2e7;
num_iter=60;
step_size=10;
tic
[xsup fsup] = gp_gen2(I,I,params,reg_par,num_iter, @fwdprojFFT2D, @bckprojFFT2D, 'no', @gradanat, @farmijoFFT2D, 'con', 'on',1,step_size);
toc
% myfigure;
% plot(fsup,'ro-','linewidth',4,'markerfacecolor','r')
[puv0u U0 V0 puv U V]=computePxy(xsup(:,:,1),params);
myfigure; myimagesc(puv0u)
myfigure; myimagesc(xsup(:,:,end)), colorbar
% myfigure; myimagesc(xsup(:,:,end)-xsup(:,:,1)), colorbar
%% 4. SVPSF-JE Prior **********************
%******************************************
close all

params.H=H;
params.D=D;

reg_par=2e7; % changed from 4e7
num_iter=60;
step_size=2;
tic
[xsvp fsvp] = gp_gen(I,I,params,reg_par,num_iter, @fwdprojFFT2D, @bckprojFFT2D, 'no', @gradanat, @farmijoFFT2D, 'con', 'on',1,step_size);
toc
% myfigure;
% plot(fsvp,'ro-','linewidth',4,'markerfacecolor','r')

[puv0 U0 V0 puv U V]=computePxy(xsvp(:,:,end),params);
myfigure; myimagesc(puv0)
%% 
imax=210;
nit=60;
close all
myfigure;
subplot 321
myimagesc(I0,[0 imax])
subplot 322
myimagesc(I,[0 imax])
subplot 323
myimagesc(xsu0(:,:,nit),[0 imax])
subplot 324
myimagesc(xsv0(:,:,nit),[0 imax])
subplot 325
myimagesc(xsup(:,:,nit),[0 imax])
subplot 326
myimagesc(xsvp(:,:,nit),[0 imax])

%%
save results0219 xsu0 xsup xsv0 xsvp fsu0 fsv0 fsup fsvp Jnew I I0 P0










