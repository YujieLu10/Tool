function  MIP_save( Matrix,label_string )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    N=360;
    sizeIn = size(Matrix);
    sizeOut(1)=ceil(sqrt(2)*sizeIn(1));
    sizeOut(2)=ceil(sqrt(2)*sizeIn(2));
    if mod(sizeOut(1),2)
        sizeOut(1)=sizeOut(1)+1;
        sizeOut(2)=sizeOut(2)+1;
    end
    sizeOut(3)=sizeIn(3);
    image_mip=zeros(sizeOut(3),sizeOut(1),360);
    ii=1;
    for theta=0:2*pi/N:pi*2-eps(1)
         t = [cos(theta)   -sin(theta)      0        0;
             sin(theta)    cos(theta)       0        0;
             0                  0           1        0;
             0                  0           0        1];

        tform = affine3d(t);
        VolumeRotated = imwarp(Matrix,tform);
        size_temp=size(VolumeRotated);
        VolumeRotated_full=zeros(sizeOut);
        if ~mod(size_temp(1),2)
            VolumeRotated_full(sizeOut(1)/2-floor(size_temp(1)/2)+1:sizeOut(1)/2+floor(size_temp(1)/2),...
                sizeOut(1)/2-floor(size_temp(1)/2)+1:sizeOut(1)/2+floor(size_temp(1)/2),:)=VolumeRotated;
        else
            VolumeRotated_full(sizeOut(1)/2-(size_temp(1)-1)/2+1:sizeOut(1)/2+(size_temp(1)+1)/2,...
                sizeOut(1)/2-(size_temp(1)-1)/2+1:sizeOut(1)/2+(size_temp(1)+1)/2,:)=VolumeRotated;
        end
        image_mip(:,:,ii)=imrotate(squeeze(max(VolumeRotated_full,[],2)),90);
        ii=ii+1; 
    end 
save([label_string,'_MIP'],'image_mip');
end

