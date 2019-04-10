function [ h ] = My_CrossLine_oneaxes( cuaxes, CP, ColorMap_choice,circle_radius )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
xlim=get(cuaxes,'Xlim');
ylim=get(cuaxes,'Ylim');

x_1=xlim(1):(CP(1)-circle_radius);
y_1=ones(size(x_1))*CP(2);
h(1)=line(x_1,y_1,'color','r');

x_2=(CP(1)+circle_radius):xlim(2);
y_2=ones(size(x_2))*CP(2);
h(2)=line(x_2,y_2,'color','r');

y_3=(CP(2)+circle_radius):ylim(2);
x_3=ones(size(y_3))*CP(1);
h(3)=line(x_3,y_3,'color','r');

y_4=ylim(1):(CP(2)-circle_radius);
x_4=ones(size(y_4))*CP(1);
h(4)=line(x_4,y_4,'color','r');

% h(5)=viscircles(CP(1:2),circle_radius);
end

