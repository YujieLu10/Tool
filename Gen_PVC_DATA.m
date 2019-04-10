function Iana  = Gen_PVC_DATA( PET, MRI, H, D, SV_flag, JE_flag, sigscale_x,sigscale_y,reg_par,step_size,num_iter  )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
EPS = 1e-8;params.EPS=EPS;
H0=H(:,:,:,3); % Different from scriptbw2D_140218
D0=ones(size(H0));
params.H=H;
params.D=D;
params.sizex=size(PET);
temp=zeros(size(PET));
temp(PET>0)=1;
temp=imfill(temp);
params.mask=zeros(size(PET));
params.mask(temp>0.02)=1;    

sig_y=max(PET(:))/sigscale_y; 
params.sig_x=max(PET(:))/sigscale_x;
M = max(size(PET))*3+1;%pdf sample number
params.M=M;    
params.imy = initanat(MRI*max(PET(:))/max(MRI(:)),M,sig_y,EPS,params.mask);
params.imx = initanat(PET,M,params.sig_x,EPS,params.mask); 





if (~SV_flag)
    reg_par=0;
    if (~JE_flag)
        params.H=H0;
        params.D=D0;
        tic
            [xsa fsa] = gp_gen_nq(PET,PET,params,reg_par,num_iter, @fwdprojH, @bckprojH, 'no', @gradanat, @farmijoH, 'con', 'on',1,step_size); % xsa is the corrected PET image
        toc
        Iana=xsa(:,:,:,end);
    elseif(JE_flag)
        params.H=H;
        params.D=D;
        tic
            [xsa fsa] = gp_gen_nq(PET,PET,params,reg_par,num_iter, @fwdprojH, @bckprojH, 'no', @gradanat, @farmijoH, 'con', 'on',1,step_size); % xsa is the corrected PET image
        toc
        Iana=xsa(:,:,:,end);
    end
elseif(SV_flag)
    if (~JE_flag)
        params.H=H0;
        params.D=D0; 
        tic
            [xsa fsa] = gp_gen_nq(PET,PET,params,reg_par,num_iter, @fwdprojH, @bckprojH, 'no', @gradanat, @farmijoH, 'con', 'on',1,step_size); % xsa is the corrected PET image
        toc
        Iana=xsa(:,:,:,end);
    elseif(JE_flag)
        params.H=H;
        params.D=D;
        tic
            [xsa fsa] = gp_gen_nq(PET,PET,params,reg_par,num_iter, @fwdprojH, @bckprojH, 'no', @gradanat, @farmijoH, 'con', 'on',1,step_size); % xsa is the corrected PET image
        toc
        Iana=xsa(:,:,:,end);
    end
end

end

