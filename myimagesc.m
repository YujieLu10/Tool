function myimagesc(I,lims,stropt)
% function myimagesc(I,l,stropt)
% squeezes I
% lims: min and max limits for imagesc
% stropt: 'equal' or '~equal'

I=squeeze(I);
imagesc(I), axis equal off
if nargin==1,
    imagesc(I), axis equal off
else   
    if isempty(lims),
        imagesc(I)
    else
        imagesc(I,[lims(1) lims(2)])
    end
    
    if nargin>2,
        if ~ischar(stropt),
            error('MYIMAGESC options should be character arrays')
        else
            if strcmp(stropt,'~equal'), axis off
            else axis equal off
            end
        end
        
    else
        axis equal off           
    end
end
