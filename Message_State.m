function  Message_State(handles)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    files=dir('*.mat');
    fileNames={files.name};
    String='';
    flag1=0;flag2=0;flag3=0;flag4=0;
    for ii=1:length(fileNames)
        if(strcmp('PET_DATA.mat',fileNames{ii}))
            flag1=1;
        end
        
        if(strcmp('PET_DATA_After_R.mat',fileNames{ii}))
            flag2=1;
        end
        
        if(strcmp('MRI_MIP.mat',fileNames{ii}))
            flag3=1;
        end
        
        if(strcmp('PET_PVC_DATA.mat',fileNames{ii}))
            flag4=1;
        end
    end
    if(~flag1)
        String=['Please first load the MRI/PET data!'];
    elseif(~flag2&&~flag4)
        String=['MRI/PET data load finished. Please Press the ''compute the MIP'' button to get the MIP OR/AND press ''run'' button to do the partical volumn correction!.'];
    elseif(~flag2)
        String=['MRI/PET data load finished, PVC finished. Please Press the ''compute the MIP'' button to get the MIP.'];
    elseif(~flag4)
        String=['MRI/PET data load finished, MIP generated. Please press ''run'' button to do the partical volumn correction! '];
    else
        String=['MRI/PET data load finished, PVC finished, MIP generated.'];
    end
    set(handles.Message,'string',String);
end

