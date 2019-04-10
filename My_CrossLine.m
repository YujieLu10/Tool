function [ h ] = My_CrossLine(axes1,axes2,axes3, X_Value, Y_Value,...
            Z_Value,Voxel_Size, ColorMap_choice,circle_radius)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
h=[];
axes(axes1);
CP_1(1)=(Y_Value-1)*Voxel_Size(1);
CP_1(2)=(X_Value-1)*Voxel_Size(2);
h=[h, My_CrossLine_oneaxes( axes1, CP_1, ColorMap_choice,circle_radius )];

axes(axes2);
CP_2(1)=(Y_Value-1)*Voxel_Size(2);
CP_2(2)=(Z_Value-1)*Voxel_Size(3);
h=[h, My_CrossLine_oneaxes( axes2, CP_2, ColorMap_choice,circle_radius )];

axes(axes3);
CP_3(1)=(X_Value-1)*Voxel_Size(1);
CP_3(2)=(Z_Value-1)*Voxel_Size(3);
h=[h, My_CrossLine_oneaxes( axes3, CP_3, ColorMap_choice,circle_radius )];
end

