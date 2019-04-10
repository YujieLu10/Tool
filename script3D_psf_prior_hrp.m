clear all



load blurinterp;
load PETMRHoffman;

I=double(I);
J=double(J);
%% Mask
%close all
params.mask=zeros(size(I));
params.mask(I>=380)=1;
islice=51;
myfigure; myimagesc(params.mask(:,:,islice))
myfigure; myimagesc(I(:,:,islice).*params.mask(:,:,islice))
myfigure; myimagesc(J(:,:,islice).*params.mask(:,:,islice))


%% Prepare MR stuff
% %close all

sigscale=8; % USED 50 with 25 iterations
EPS = 1e-8;
params.EPS=EPS;
sig_y=max(I(:))/sigscale;
params.sig_x=max(I(:))/sigscale;
M = max(size(I))*3+1;%pdf sample number
params.M=M;
params.imy = initanat(J*max(I(:))/max(J(:)),M,sig_y,EPS,params.mask);
myfigure; plot(params.imy.pv)
params.imx = initanat(I,M,params.sig_x,EPS,params.mask);
myfigure; plot(params.imx.pv)
[puv0 U0 V0 puv U V]=computePxy(I(:),params);
myfigure;  myimagesc(puv0);
%%

% myfigure; pcolor(U0,V0,puv0), axis equal 
% shading interp
% datacursormode on


%% Parameters
params.sizex=size(I);
params.H=H;
params.D=D;
% params.sig_x=1e3;

%%

%close all
tic
g1 = reshape(bckprojH(fwdprojH(I,params),params) - bckprojH(I,params),params.sizex);
toc
% g2=reshape(gradlap(I,params),params.sizex);
tic
g2=reshape(gradanat(I,params),params.sizex);
toc
% g4 = reshape(gradlap_only(I, params),params.sizex);

%%

zz=36;
%close all
myfigure; 
subplot 221
myimagesc(g1(:,:,zz)),colorbar
subplot 222
myimagesc(g2(:,:,zz)),colorbar
subplot 223
myimagesc(J(:,:,zz)), colorbar
subplot 224
myimagesc(g1(:,:,zz)+1e15*g2(:,:,zz)), colorbar

%% GP with prior **** USE!!

%close all
xinit=I;
step_size=2; %1 and 2
reg_par=4e15;
num_iter=10;
tic
[xsa fsa] = gp_gen_nq(xinit,I,params,reg_par,num_iter, @fwdprojH, @bckprojH, 'no', @gradanat, @farmijoH, 'con', 'on',1,step_size); % xsa is the corrected PET image
toc
Iana=xsa(:,:,:,end);
myfigure;
plot(fsa,'ro-','linewidth',4,'markerfacecolor','r')

%%
%close all
islice=36;
myfigure;
myimagesc(xsa(:,:,islice,1)), colorbar
% myfigure;
% myimagesc(xs(:,:,32,end-5)), colorbar
myfigure;
myimagesc(xsa(:,:,islice,end)), colorbar
myfigure;
myimagesc(J(:,:,islice)), colormap gray, colorbar
% myfigure;
% myimagesc(I(:,:,32)), colorbar

%% SAVE ANA RESULTS
% save t807_1_ana Iana I reg_par step_size num_iter sigscale fsa
save('PDS_ana', 'Iana', 'fsa', 'I', 'reg_par', 'step_size', 'num_iter', 'sigscale'); 

%% GP with PSF only

%close all
xinit=I;
step_size=5;
num_iter=20;
tic
[xsp fsp] = gp_gen(xinit,I,params,0,num_iter, @fwdprojH, @bckprojH, 'no', @gradanat, @farmijoH, 'con', 'on',1,step_size);
toc
Ipsf=xsp(:,:,:,end);
myfigure;
plot(fsp,'ro-','linewidth',4,'markerfacecolor','r')
%%
%close all
islice=30;
myfigure;
myimagesc(xsp(:,:,islice,1)), colorbar
% myfigure;
% myimagesc(xs(:,:,32,end-5)), colorbar
myfigure;
myimagesc(xsp(:,:,islice,end)), colorbar
myfigure;
myimagesc(xsa(:,:,islice,end)), colorbar

%%
%%
%close all
islice=36;
myfigure;
subplot 221
myimagesc(I(:,:,islice)), colorbar
subplot 222
myimagesc(J(:,:,islice)), colorbar
subplot 223
myimagesc(Ipsf(:,:,islice)), colorbar
subplot 224
myimagesc(Iana(:,:,islice)), colorbar
colormap gray


%% SAVE ANA and PSF RESULTS the same file
save('PDS_ana','J','ivox','Ipsf', 'Iana', 'fsp', 'fsa', 'I', 'reg_par', 'step_size', 'num_iter', 'sigscale');

%%

[puv0 U0 V0 puv U V]=computePxy(I(:),params);
close; myfigure; pcolor(U0,V0,puv0), axis equal 
shading interp
datacursormode on
[puv0 U0 V0 puv U V]=computePxy(Ipsf(:),params);
close; myfigure; pcolor(U0,V0,puv0), axis equal 
shading interp
datacursormode on
[puv0 U0 V0 puv U V]=computePxy(Iana(:),params);
close; myfigure; pcolor(U0,V0,puv0), axis equal 
shading interp
datacursormode on





%% Quadratic ONLY - real data

tic
[xs fs] = pcg_gen_mask(ones(size(I)),I,params,0,20, @fwdprojH, @bacprojH, 'no', @gradanat, @farmijoH, 'con', 'on');
toc
myfigure;
plot(fs,'ro-','linewidth',4,'markerfacecolor','r')


%% Quadratic ONLY - real data - GP

tic
[xs fs] = gp_gen_mask(ones(size(I)),I,params,0,20, @fwdprojH, @bacprojH, 'no', @gradanat, @farmijoH, 'con', 'on');
toc
myfigure;
plot(fs,'ro-','linewidth',4,'markerfacecolor','r')

%close all

if ndims(xs)<4,
    xs=reshape(xs,[params.sizex size(xs,2)]);
end
myfigure;
myimagesc(xs(:,:,32,1)), colorbar
myfigure;
myimagesc(xs(:,:,32,end-5)), colorbar
myfigure;
myimagesc(xs(:,:,32,end)), colorbar
myfigure;
myimagesc(I(:,:,32)), colorbar

% myfigure;
% plot(fs,'ro-','linewidth',4,'markerfacecolor','r')

%% GP with prior **** USE!!

tic
[xs fs] = gp_gen(I,I,params,1e14,25, @fwdprojH, @bacprojH, 'no', @gradanat, @farmijoH, 'con', 'on',1);
toc
myfigure;
plot(fs,'ro-','linewidth',4,'markerfacecolor','r')









%%
g=gradanat(I(:),params);

%%
% y=forwardProjMC(G,I0,params); 
% %close all
% % xs = pcg_mc(zeros(size(I0)),G,y,params,1e-10,20, 'em', 'con', 'on',51);
% xs = pcg_mc(I0,G,y,params,1e-10,20, 'em', 'con', 'on',51);
% 

% xs = pcg_gen(x,y,params,reg_par,niter, fwdproj, bacproj, precond, gradreg, farmijo, con_flag, chat_flag,N)
tic
xs = pcg_gen(ones(size(I)),I,params,1e9,10, @fwdprojH, @bacprojH, @precondH, @gradanat, @farmijoH, 'con', 'on');
toc

%%
tic
[xs fs] = pcg_gen_mask(ones(size(I)),I,params,5e13,20, @fwdprojH, @bacprojH, 'no', @gradanat, @farmijoH, 'con', 'on');
toc



%% Quadratic ONLY - simulated data

temp=phantom3d(64);
temp(temp<0)=0;
Isl=zeros(params.sizex);
Isl(32:95,32:95,:)=temp(:,:,2:end);
Isl=permute(Isl,[2 1 3]);
myfigure; myimagesc(Isl(:,:,32)),colorbar
paramssl.sizex=params.sizex;
paramssl.H=params.H(:,:,:,4);
paramssl.D=ones(size(Isl));
% paramssl.sig_x=max(I(:))/sigscale;
% paramssl.M=M;


ysl=reshape(fwdprojH(Isl(:),paramssl),paramssl.sizex);
ysl2=convn(paramssl.H,Isl,'same');
ysl2=convolution3D_FFTdomain(Isl,paramssl.H);
myfigure; myimagesc(ysl(:,:,32)),colorbar
myfigure; myimagesc(ysl2(:,:,32)),colorbar
tic
[xs fs] = pcg_gen_mask(ones(size(I)),I,params,0,20, @fwdprojH, @bacprojH, 'no', @gradanat, @farmijoH, 'con', 'on');
toc
myfigure;
plot(fs,'ro-','linewidth',4,'markerfacecolor','r')

%%
a=rand(4,3);
u=rand(3,1);
b=a*u;
params1.a=a;
params1.sizex=size(u);
tic
[xs fs] = pcg_gen(zeros(3,1),b,params1,0,10, @(x,params1)((params1.a)*x), @(x,params1)((params1.a)'*x), 'no', @gradanat, @(x,y,params1,reg_par)(0.5*((params1.a)*x-y)'*((params1.a)*x-y)), 'con', 'on');
toc

norm(u-xs(:,end))
temp=fs(2:end)-fs(1:end-1)

%%



%%


%close all

if ndims(xs)<4,
    xs=reshape(xs,[params.sizex size(xs(2))]);
end
myfigure;
myimagesc(xs(:,:,32,1)), colorbar
myfigure;
myimagesc(xs(:,:,32,end-5)), colorbar
myfigure;
myimagesc(xs(:,:,32,end)), colorbar
myfigure;
myimagesc(I(:,:,32)), colorbar

% myfigure;
% plot(fs,'ro-','linewidth',4,'markerfacecolor','r')








