clear;
close all;
load PETMRHoffman;
T=[1 1 1];
location_base=0;
for ii=1:size(I,3)
    filename=[cd,'\PET_Hoffman\PET_Hoffman',num2str(ii),'.dcm'];
    I_temp=I(:,:,ii); 
    dicomwrite(uint16(I_temp), filename,...
        'SliceThickness', T(3), ...
        'PixelSpacing', [T(1); T(2)], ...
        'SliceLocation', location_base - (ii-1)*T(3), ...
        'ImageOrientationPatient', [1 0 0 0 1 0], ...
        'CreateMode', 'Copy', ...
        'SOPClassUID', '1.2.840.10008.5.1.4.1.1.2');
end 

for ii=1:size(J,3)
    filename=[cd,'\MRI_Hoffman\MRI_Hoffman',num2str(ii),'.dcm'];
    J_temp=J(:,:,ii);
    dicomwrite(uint16(J_temp), filename,...
        'SliceThickness', T(3), ...
        'PixelSpacing', [T(1); T(2)], ...
        'SliceLocation', location_base - (ii-1)*T(3), ...
        'ImageOrientationPatient', [1 0 0 0 1 0], ...
        'CreateMode', 'Copy', ...
        'SOPClassUID', '1.2.840.10008.5.1.4.1.1.2');
end
