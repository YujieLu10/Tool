function Iout = bckprojH1(Iin,params)
% H,D,Iin,sizex)
% function Iout = varconvT(H,D,Iin,sizex)
% Inputs: 
% Iin is (n x 1), 3D image passed as vector
% H is (nx x ny x nz x k), k blur kernels
% D is (nx x ny x nz x k), interpolation weights for the blur kernels
% Output:
% Iout = \sum_i conv3DTranspose(H(:,i) , Iin.*D(:,i) ))


Iin =reshape(Iin,params.sizex);
k=size(params.H,4);
sizex=params.sizex;
Iout=zeros(sizex);
for ii=1:k,
%     hi=reshape(H(:,ii),sizex);
%     di=reshape(D(:,ii),sizex);
    gi=circshift(params.H(end:-1:1,end:-1:1,end:-1:1,ii),[1 1 1]);
    di=params.D(:,:,:,ii);
    Iini=di.*Iin; % intermediate image
    
    Iouti=ifftshift(ifftn(fftn(gi).*fftn(Iini)));
%     Iouti=ifftn(fftn(gi,2*sizex-1).*fftn(Iini,2*sizex-1));
%     idx1=floor((sizex(1)-sizex(1)/2+1):(sizex(1)+sizex(1)/2));
%     idx2=floor((sizex(2)-sizex(2)/2+1):(sizex(2)+sizex(2)/2));
%     idx3=floor((sizex(3)-sizex(3)/2+1):(sizex(3)+sizex(3)/2));
%     Iouti=Iouti(idx1,idx2,idx3);
    
    Iout=Iout+Iouti;
end

Iout=Iout(:);