%clear all



load blurinterp;
load('FDGsample.mat');
load('MRIsample.mat');

I=double(fdg);
J=double(mri_mapped);
% addpath(genpath('C:\Users\BellaChenhui\Desktop\ADNI\002_S_2010'));
% mri = load_nii('ADNI_002_S_2010_MR_MT1__N3m_Br_20110307135549246_S98069_I222695.nii'); 
% I = mri.img;
% fdg = load_nii('ADNI_002_S_2010_PT_Co-registered,_Averaged_Br_20100727110314555_54_S89021_I187070-LinearBMRegistration.nii'); 
% J = fdg.img; 
%% Mask
close all
params.mask=zeros(size(I));
params.mask(I>=380)=1;
islice=51;
% Set a threshold on the PET to generate a mask
% Only the voxels within the mask will be used for JE computation
% The PET and MRs need to be rigidly co-registered first
% Once they are registered the PET mask should apply to the MR image as
% well
% In the following we visualize the Mask, the masked PET, and the masked MR
myfigure; myimagesc(params.mask(:,:,islice))
myfigure; myimagesc(I(:,:,islice).*params.mask(:,:,islice))
myfigure; myimagesc(J(:,:,islice).*params.mask(:,:,islice))


%% Prepare MR stuff
% close all

% Comments on parameter selection:
% The parameters you are setting in this part are 1. sig_y and 2. sig_x
% These are parzen window widths. Please refer to the ISBI manuscript I
% shared with you.
% I have using the sigscale variable and the max intensities of the images
% to set a value for the two params. But this is not a good rule of thumb.
% You can set any value. You need to make sure that the 1D and 2D
% histograms before have the right number of cluster peaks. For example, if
% the true PET image had values of 1, 2, and 3 in three ROIs, the blurred
% PET would have a range of values near, between, and around 1, 2, and 3. 
% But the marginal and joint pdfs should have clear peaks/clusters centered
% at 1,2,3. In this part you adjust sig_x and sig_y to get the right
% histogram.
sigscale=8; % USED 50 with 25 iterations
EPS = 1e-8;
params.EPS=EPS;
sig_y=max(I(:))/sigscale;
params.sig_x=max(I(:))/sigscale;
M = max(size(I))*3+1;%pdf sample number
params.M=M;
params.imy = initanat(J*max(I(:))/max(J(:)),M,sig_y,EPS,params.mask);
myfigure; plot(params.imy.pv) % This is the marginal pdf for MR
params.imx = initanat(I,M,params.sig_x,EPS,params.mask);
myfigure; plot(params.imx.pv) % This is the marginal pdf for PET
[puv0 U0 V0 puv U V]=computePxy(I(:),params);
myfigure;  myimagesc(puv0); % This is the joint pdf which is 2D

%% Parameters
params.sizex=size(I);
params.H=H;
params.D=D;
% params.sig_x=1e3;

%% Check gradients

close all
tic
g1 = reshape(bckprojH(fwdprojH(I,params),params) - bckprojH(I,params),params.sizex);
toc
% g2=reshape(gradlap(I,params),params.sizex);
tic
g2=reshape(gradanat(I,params),params.sizex);
toc
% g4 = reshape(gradlap_only(I, params),params.sizex);

%%

% In this part you are just computing the datafit and prior gradients and comparing the relative values
% The relative weight (1e15) below is used for guessing a good range for
% the regularization parameter.
% Looking at the gradient is important. It lets you understand if the
% datafit or the prior will influence your result more. Overweighting the prior
% could generate a severely biased image. This is where you try to avoid
% it. The prior may not always be perfect, with some valudes of sig_x and
% sig_y, it might try to steer the solution in the wrong direction. Based
% on the gradient images, you can also adjust those variables. YOu want the
% combined gradient to show some features from both the datafit and prior images. 


zz=36;
close all
myfigure; 
subplot 221
myimagesc(g1(:,:,zz)),colorbar % Datafit gradient image
subplot 222
myimagesc(g2(:,:,zz)),colorbar % Prior gradient image
subplot 223
myimagesc(J(:,:,zz)), colorbar % True MR image
subplot 224
myimagesc(g1(:,:,zz)+1e15*g2(:,:,zz)), colorbar % Combined gradient image using weighting factor

%% GP with prior **** USE!!

close all
xinit=I;
step_size=2; %1 and 2
reg_par=4e15; % This is the only other key parameter you pick. Pick it based on the gradients.
num_iter=10; % Can sel to any value. Plot fsa and if the curve is flat toward teh end, then the result is convergent.
tic
[xsa fsa] = gp_gen_nq(xinit,I,params,reg_par,num_iter, @fwdprojH, @bckprojH, 'no', @gradanat, @farmijoH, 'con', 'on',1,step_size);
toc
Iana=xsa(:,:,:,end);
myfigure;
plot(fsa,'ro-','linewidth',4,'markerfacecolor','r') % this is just the cost function (datafit + je) plotted against iteration number.

%%
close all
islice=36;
myfigure;
myimagesc(xsa(:,:,islice,1)), colorbar % this is the initial image, usually the original blurry PET
% myfigure;
% myimagesc(xs(:,:,32,end-5)), colorbar
myfigure;
myimagesc(xsa(:,:,islice,end)), colorbar % this is the final image. this is the image you are interested in. 
myfigure;
myimagesc(J(:,:,islice)), colormap gray, colorbar % this is the MR image for added anatomical reference. 
% myfigure;
% myimagesc(I(:,:,32)), colorbar

%% SAVE ANA RESULTS
% save t807_1_ana Iana I reg_par step_size num_iter sigscale fsa
save('PDS_ana', 'Iana', 'fsa', 'I', 'reg_par', 'step_size', 'num_iter', 'sigscale'); 

% %% GP with PSF only
% 
% close all
% xinit=I;
% step_size=5;
% num_iter=20;
% tic
% [xsp fsp] = gp_gen(xinit,I,params,0,num_iter, @fwdprojH, @bckprojH, 'no', @gradanat, @farmijoH, 'con', 'on',1,step_size);
% toc
% Ipsf=xsp(:,:,:,end);
% myfigure;
% plot(fsp,'ro-','linewidth',4,'markerfacecolor','r')
% %%
% close all
% islice=30;
% myfigure;
% myimagesc(xsp(:,:,islice,1)), colorbar
% % myfigure;
% % myimagesc(xs(:,:,32,end-5)), colorbar
% myfigure;
% myimagesc(xsp(:,:,islice,end)), colorbar
% myfigure;
% myimagesc(xsa(:,:,islice,end)), colorbar
% 
% %%
% %%
% close all
% islice=36;
% myfigure;
% subplot 221
% myimagesc(I(:,:,islice)), colorbar
% subplot 222
% myimagesc(J(:,:,islice)), colorbar
% subplot 223
% myimagesc(Ipsf(:,:,islice)), colorbar
% subplot 224
% myimagesc(Iana(:,:,islice)), colorbar
% colormap gray
% 
% 
% %% SAVE ANA and PSF RESULTS the same file
% save('PDS_ana','J','ivox','Ipsf', 'Iana', 'fsp', 'fsa', 'I', 'reg_par', 'step_size', 'num_iter', 'sigscale');
% 
% %%
% 
% [puv0 U0 V0 puv U V]=computePxy(I(:),params);
% close; myfigure; pcolor(U0,V0,puv0), axis equal 
% shading interp
% datacursormode on
% [puv0 U0 V0 puv U V]=computePxy(Ipsf(:),params);
% close; myfigure; pcolor(U0,V0,puv0), axis equal 
% shading interp
% datacursormode on
% [puv0 U0 V0 puv U V]=computePxy(Iana(:),params);
% close; myfigure; pcolor(U0,V0,puv0), axis equal 
% shading interp
% datacursormode on
% 
% 
% 
% 
% 
% %% Quadratic ONLY - real data
% 
% tic
% [xs fs] = pcg_gen_mask(ones(size(I)),I,params,0,20, @fwdprojH, @bacprojH, 'no', @gradanat, @farmijoH, 'con', 'on');
% toc
% myfigure;
% plot(fs,'ro-','linewidth',4,'markerfacecolor','r')
% 
% 
% %% Quadratic ONLY - real data - GP
% 
% tic
% [xs fs] = gp_gen_mask(ones(size(I)),I,params,0,20, @fwdprojH, @bacprojH, 'no', @gradanat, @farmijoH, 'con', 'on');
% toc
% myfigure;
% plot(fs,'ro-','linewidth',4,'markerfacecolor','r')
% 
% close all
% 
% if ndims(xs)<4,
%     xs=reshape(xs,[params.sizex size(xs,2)]);
% end
% myfigure;
% myimagesc(xs(:,:,32,1)), colorbar
% myfigure;
% myimagesc(xs(:,:,32,end-5)), colorbar
% myfigure;
% myimagesc(xs(:,:,32,end)), colorbar
% myfigure;
% myimagesc(I(:,:,32)), colorbar
% 
% % myfigure;
% % plot(fs,'ro-','linewidth',4,'markerfacecolor','r')
% 
% %% GP with prior **** USE!!
% 
% tic
% [xs fs] = gp_gen(I,I,params,1e14,25, @fwdprojH, @bacprojH, 'no', @gradanat, @farmijoH, 'con', 'on',1);
% toc
% myfigure;
% plot(fs,'ro-','linewidth',4,'markerfacecolor','r')
% 
% 
% 
% 
% 
% 
% 
% 
% 
% %%
% g=gradanat(I(:),params);
% 
% %%
% % y=forwardProjMC(G,I0,params); 
% % close all
% % % xs = pcg_mc(zeros(size(I0)),G,y,params,1e-10,20, 'em', 'con', 'on',51);
% % xs = pcg_mc(I0,G,y,params,1e-10,20, 'em', 'con', 'on',51);
% % 
% 
% % xs = pcg_gen(x,y,params,reg_par,niter, fwdproj, bacproj, precond, gradreg, farmijo, con_flag, chat_flag,N)
% tic
% xs = pcg_gen(ones(size(I)),I,params,1e9,10, @fwdprojH, @bacprojH, @precondH, @gradanat, @farmijoH, 'con', 'on');
% toc
% 
% %%
% tic
% [xs fs] = pcg_gen_mask(ones(size(I)),I,params,5e13,20, @fwdprojH, @bacprojH, 'no', @gradanat, @farmijoH, 'con', 'on');
% toc
% 
% 
% 
% %% Quadratic ONLY - simulated data
% 
% temp=phantom3d(64);
% temp(temp<0)=0;
% Isl=zeros(params.sizex);
% Isl(32:95,32:95,:)=temp(:,:,2:end);
% Isl=permute(Isl,[2 1 3]);
% myfigure; myimagesc(Isl(:,:,32)),colorbar
% paramssl.sizex=params.sizex;
% paramssl.H=params.H(:,:,:,4);
% paramssl.D=ones(size(Isl));
% % paramssl.sig_x=max(I(:))/sigscale;
% % paramssl.M=M;
% 
% 
% ysl=reshape(fwdprojH(Isl(:),paramssl),paramssl.sizex);
% ysl2=convn(paramssl.H,Isl,'same');
% ysl2=convolution3D_FFTdomain(Isl,paramssl.H);
% myfigure; myimagesc(ysl(:,:,32)),colorbar
% myfigure; myimagesc(ysl2(:,:,32)),colorbar
% tic
% [xs fs] = pcg_gen_mask(ones(size(I)),I,params,0,20, @fwdprojH, @bacprojH, 'no', @gradanat, @farmijoH, 'con', 'on');
% toc
% myfigure;
% plot(fs,'ro-','linewidth',4,'markerfacecolor','r')
% 
% %%
% a=rand(4,3);
% u=rand(3,1);
% b=a*u;
% params1.a=a;
% params1.sizex=size(u);
% tic
% [xs fs] = pcg_gen(zeros(3,1),b,params1,0,10, @(x,params1)((params1.a)*x), @(x,params1)((params1.a)'*x), 'no', @gradanat, @(x,y,params1,reg_par)(0.5*((params1.a)*x-y)'*((params1.a)*x-y)), 'con', 'on');
% toc
% 
% norm(u-xs(:,end))
% temp=fs(2:end)-fs(1:end-1)
% 
% %%
% 
% 
% 
% %%
% 
% 
% close all
% 
% if ndims(xs)<4,
%     xs=reshape(xs,[params.sizex size(xs(2))]);
% end
% myfigure;
% myimagesc(xs(:,:,32,1)), colorbar
% myfigure;
% myimagesc(xs(:,:,32,end-5)), colorbar
% myfigure;
% myimagesc(xs(:,:,32,end)), colorbar
% myfigure;
% myimagesc(I(:,:,32)), colorbar

% myfigure;
% plot(fs,'ro-','linewidth',4,'markerfacecolor','r')








