function  Slider_Visible( handle1,handle2,handle3,handle4,handle5,handle6,handle7,handle8,handle9,visible_tag )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    if(visible_tag)
        set(handle1,'visible','on');set(handle2,'visible','on');set(handle3,'visible','on');
        set(handle4,'visible','on');set(handle5,'visible','on');set(handle6,'visible','on');
        set(handle7,'visible','on');set(handle8,'visible','on');set(handle9,'visible','on');
    else
        set(handle1,'visible','off');set(handle2,'visible','off');set(handle3,'visible','off');
        set(handle4,'visible','off');set(handle5,'visible','off');set(handle6,'visible','off');
        set(handle7,'visible','off');set(handle8,'visible','off');set(handle9,'visible','off');
    end
end

