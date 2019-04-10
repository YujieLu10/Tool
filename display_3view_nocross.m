function  display_3view_nocross( X_Value, Y_Value, Z_Value, Matrix, axes1, axes2, axes3, voxel_size, ColorMap)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%%get the Region of Interest
    try
        ca_temp=gca;
    catch
    end
%     if (X_Value<1||X_Value>size(Matrix,1)||Y_Value<1||Y_Value>size(Matrix,2)||Z_Value<1||Z_Value>size(Matrix,3))
%         errordlg('please reallocate the position');
%     end
    
    %%display the figure; axes 1 to 3 for MRI
    
    %set a criterion for all the figure;
    
    axes(axes1);Ylim=get(gca,'YLim');Xlim=get(gca,'XLim');Clim=get(gca,'CLim');
    transaxial=(squeeze(Matrix(:,:,Z_Value)));
    imagesc(0:voxel_size(2)*(size(Matrix,2)-1),0:voxel_size(1)*(size(Matrix,1)-1),...
        squeeze(transaxial),Clim); 
    axis equal;colormap(char(ColorMap));
    axis off;axis([Xlim,Ylim]);
    
    axes(axes2);Ylim=get(gca,'YLim');Xlim=get(gca,'XLim');Clim=get(gca,'CLim');
    coronal=(squeeze(Matrix(X_Value,:,:)));
    imagesc(0:voxel_size(2)*(size(Matrix,2)-1),0:voxel_size(3)*(size(Matrix,3)-1),...
        imrotate(squeeze(coronal),90),Clim); 
    axis equal;colormap(char(ColorMap)); 
    axis off; axis([Xlim,Ylim]);
         
     
    axes(axes3);Ylim=get(gca,'YLim');Xlim=get(gca,'XLim');Clim=get(gca,'CLim');
    sagittal=(squeeze(Matrix(:,Y_Value,:)));
    imagesc(0:voxel_size(1)*(size(Matrix,1)-1),0:voxel_size(3)*(size(Matrix,3)-1),...
        imrotate(squeeze(sagittal),90),Clim); 
    axis equal;colormap(char(ColorMap)); 
    axis off;axis([Xlim,Ylim]);
    
    try
        axes(ca_temp);
    catch
    end
end

