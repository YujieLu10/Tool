function [result status] = python(varargin)

cmdString='python';
for i = 1:nargin
    thisArg = varargin{i};
    if isempty(thisArg) | ~ischar(thisArg)
        error(['All input arguments must be valid strings.']);
    elseif exist(thisArg)==2
        if isempty(dir(thisArg))
            thisArg = which(thisArg);
        end
    elseif i==1
        error(['Unable to find Python file: ', thisArg]);
    end
    if any(thisArg == ' ')
          thisArg = ['"', thisArg, '"'];
    end
    cmdString = [cmdString, ' ', thisArg]
end
[status,result]=system(cmdString);
end