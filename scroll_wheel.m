function scroll_wheel
% Illustrates how to use WindowScrollWheelFcn property
%
   f = figure('WindowScrollWheelFcn',@figScroll,'Name','Scroll Wheel Demo');
   x = [0:.1:40];
   y = 4.*cos(x)./(x+2);
   a = axes; 
   h = plot(x,y);
   title('Rotate the scroll wheel')
   function figScroll(src,callbackdata)
      if callbackdata.VerticalScrollCount > 0 
         xd = h.XData;
         inc = xd(end)/20;
         x = [0:.1:xd(end)+inc];
         re_eval(x)
      elseif callbackdata.VerticalScrollCount < 0 
         xd = h.XData;
         inc = xd(end)/20;
         x = [0:.1:xd(end)-inc+.1]; % Don't let xd = 0;
         re_eval(x)
      end
   end % figScroll

   function re_eval(x)
      y = 4.*cos(x)./(x+2);
      h.YData = y;
      h.XData = x;
      a.XLim = [0 x(end)];
      drawnow
   end % re_eval
end % scroll_wheel