function Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

ColorMap_choice = get(handles.MRI_Colormap,'String');
ColorMap_choice = ColorMap_choice(get(handles.MRI_Colormap,'value'),:); 

MRI_V_Value=MRI.Matrix(MRI_X_Value,MRI_Y_Value,MRI_Z_Value)*...
    (MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)...
    +MRI.info.SmallestImagePixelValue;
set(handles.MRI_X,'string',num2str(MRI_X_Value));
set(handles.MRI_Y,'string',num2str(MRI_Y_Value));
set(handles.MRI_Z,'string',num2str(MRI_Z_Value));
set(handles.MRI_V,'string',num2str(MRI_V_Value));

display_3view_initial( MRI_X_Value, MRI_Y_Value, MRI_Z_Value, MRI.Matrix, ...
    handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size, ColorMap_choice,1, 0)

% freezeColors(handles.axes1); 
% freezeColors(handles.axes2);
% freezeColors(handles.axes3); 

ColorMap_choice = get(handles.PET_Colormap,'String');
ColorMap_choice = ColorMap_choice(get(handles.PET_Colormap,'value'),:); 
PET_V_Value=PET.Matrix(PET_X_Value,PET_Y_Value,PET_Z_Value)*...
    (PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)...
    +PET.info.SmallestImagePixelValue;
set(handles.PET_X,'string',num2str(PET_X_Value));
set(handles.PET_Y,'string',num2str(PET_Y_Value));
set(handles.PET_Z,'string',num2str(PET_Z_Value));
set(handles.PET_V,'string',num2str(PET_V_Value));


display_3view_initial( PET_X_Value, PET_Y_Value, PET_Z_Value, PET.Matrix, ...
    handles.axes4, handles.axes5, handles.axes6, PET.voxel_size, ColorMap_choice,1, 0)

% freezeColors(handles.axes4);
% freezeColors(handles.axes5);
% freezeColors(handles.axes6);



myfuse( handles.axes7, squeeze(MRI.Matrix(:,:,MRI_Z_Value)),...
    squeeze(PET.Matrix(:,:,PET_Z_Value)),...
    MRI.voxel_size(1:2), PET.voxel_size(1:2) )


myfuse( handles.axes8, imrotate(squeeze(MRI.Matrix(MRI_X_Value,:,:)),90),...
    imrotate(squeeze(PET.Matrix(PET_X_Value,:,:)),90),...
    MRI.voxel_size(3:-1:2), PET.voxel_size(3:-1:2))

myfuse( handles.axes9, imrotate(squeeze(MRI.Matrix(:,MRI_Y_Value,:)),90),...
    imrotate(squeeze(PET.Matrix(:,PET_X_Value,:)),90),...
    MRI.voxel_size(3:-2:1), PET.voxel_size(3:-2:1))



end

