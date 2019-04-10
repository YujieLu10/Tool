function  myfuse( current_axes, Matrix1, Matrix2,length1, length2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
size1=size(Matrix1);
size2=size(Matrix2);

R1 = imref2d(size1);
R2 = imref2d(size2);
R1.XWorldLimits = R2.XWorldLimits;
R1.YWorldLimits = R2.YWorldLimits;

% Fuse = imfuse(Matrix2,R2,Matrix1,R1,'falsecolor','Scaling','joint','ColorChannels','red-cyan');
Fuse=zeros(size(Matrix1));
size3=size(Fuse);
if (size3(1)==size1(1))
    y_unit=length1(1);
else
    y_unit=length2(1);
end

if (size3(2)==size1(2))
    x_unit=length1(2);
else
    x_unit=length2(2);
end

axes(current_axes);

imagesc(0:x_unit*(size(Fuse,2)-1),0:y_unit*(size(Fuse,1)-1),Fuse); 
axis equal;
axis off;
        
end

