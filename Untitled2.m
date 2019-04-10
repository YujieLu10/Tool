clear all
clc
load PET_DATA_After_R;
load MRI_DATA;
m=(MRI.Matrix(:,:,30));
p=(PET.Matrix(:,:,30));
% f=wfusimg(p,m,'db2',2,'mean','mean');
f=wfusimg(p,m,'db2',2,'max','min');
imshow(f)