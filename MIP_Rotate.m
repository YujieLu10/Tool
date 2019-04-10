function  MIP_Rotate( Matrix, voxel_size,ColorMap_choice )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    pause_t=0.01;
    figure('Name','MIP','toolbar','none','menu','none','numbertitle','off');
   
    for ii=1:size(Matrix,3)
        imagesc(0:voxel_size(1)*(size(Matrix,2)-1),0:voxel_size(3)*(size(Matrix,1)-1),...
            Matrix(:,:,ii));
        axis off;axis equal;colormap(char(ColorMap_choice));
        pause(pause_t);
    end
end

