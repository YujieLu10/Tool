clear;close all;
load PET_DATA;
load MRI_DATA;
[optimizer, metric] = imregconfig('multimodal');
registration_temp = imregister(PET.Matrix, MRI.Matrix, 'affine', optimizer, metric);
% fixed  = dicomread('knee1.dcm');
% moving = dicomread('knee2.dcm');
% imshowpair(fixed, moving,'Scaling','joint');
% [optimizer, metric] = imregconfig('multimodal');
% movingRegistered = imregister(moving, fixed, 'affine', optimizer, metric);
% figure
% imshowpair(fixed, movingRegistered,'Scaling','joint');