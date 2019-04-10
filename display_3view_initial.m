function  display_3view_initial( X_Value, Y_Value, Z_Value, Matrix, axes1, axes2, axes3, voxel_size, ColorMap,cross_tag, MIP_tag)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%%get the Region of Interest
    try
        ca_temp=gca;
    catch
    end
    
    %%display the figure; axes 1 to 3 for MRI
    
    %set a criterion for all the figure;
    if(~MIP_tag)
        axes(axes1);
        transaxial=(squeeze(Matrix(:,:,Z_Value)));
        imagesc(0:voxel_size(2)*(size(Matrix,2)-1),0:voxel_size(1)*(size(Matrix,1)-1),...
            squeeze(transaxial),[0 max(Matrix(:))]); 
        axis equal;colormap(char(ColorMap));
        axis off; 

        axes(axes2);
        coronal=(squeeze(Matrix(X_Value,:,:)));
        imagesc(0:voxel_size(2)*(size(Matrix,2)-1),0:voxel_size(3)*(size(Matrix,3)-1),...
            imrotate(squeeze(coronal),90),[0 max(Matrix(:))]); 
        axis equal;colormap(char(ColorMap)); 
        axis off; 


        axes(axes3);
        sagittal=(squeeze(Matrix(:,Y_Value,:)));
        imagesc(0:voxel_size(1)*(size(Matrix,1)-1),0:voxel_size(3)*(size(Matrix,3)-1),...
            imrotate(squeeze(sagittal),90),[0 max(Matrix(:))]); 
        axis equal;colormap(char(ColorMap)); 
        axis off;

        if(cross_tag)
            circle_radius=0;
            Z_Value_revise=size(Matrix,3)-Z_Value+1;
            My_CrossLine(axes1,axes2,axes3, X_Value, Y_Value,...
                    Z_Value_revise,voxel_size, ColorMap,circle_radius);
        end
    else
        axes(axes1);
        transaxial=max(Matrix,[],3);
        imagesc(0:voxel_size(2)*(size(Matrix,2)-1),0:voxel_size(1)*(size(Matrix,1)-1),...
            squeeze(transaxial),[0 max(Matrix(:))]); 
        axis equal;colormap(char(ColorMap));
        axis off;

        axes(axes2);
        coronal=max(Matrix,[],1);
        imagesc(0:voxel_size(2)*(size(Matrix,2)-1),0:voxel_size(3)*(size(Matrix,3)-1),...
            imrotate(squeeze(coronal),90),[0 max(Matrix(:))]); 
        axis equal;colormap(char(ColorMap)); 
        axis off;


        axes(axes3);Ylim=get(gca,'YLim');
        sagittal=max(Matrix,[],2);
        imagesc(0:voxel_size(1)*(size(Matrix,1)-1),0:voxel_size(3)*(size(Matrix,3)-1),...
            imrotate(squeeze(sagittal),90),[0 max(Matrix(:))]); 
        axis equal;colormap(char(ColorMap)); 
        axis off;
    end
    
    try
        axes(ca_temp);
    catch
    end
end

