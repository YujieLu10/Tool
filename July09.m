function varargout = July09(varargin)
% JULY09 MATLAB code for July09.fig
%      JULY09, by itself, creates a new JULY09 or raises the existing
%      singleton*.
%
%      H = JULY09 returns the handle to a new JULY09 or the handle to
%      the existing singleton*.
%
%      JULY09('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in JULY09.M with the given input arguments.
%
%      JULY09('Property','Value',...) creates a new JULY09 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before July09_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to July09_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help July09

% Last Modified by GUIDE v2.5 13-Aug-2015 15:13:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @July09_OpeningFcn, ...
                   'gui_OutputFcn',  @July09_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
%    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before July09 is made visible.
function July09_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to July09 (see VARARGIN)

% Choose default command line output for July09
addpath D:\MGH_project\From_joyita\MClust-3.5\Utilities
handles.output = hObject;
%%delete the previous .mat data.
try
    delete('MRI_DATA.mat');
    delete('PET_DATA.mat');
    delete('PET_DATA_After_R.mat');
    try
        
        delete('PET_PVC_DATA.mat');
        delete('MRI_MIP.mat');
        delete('PET_MIP.mat');
        delete('PET_PVC_MIP.mat');
        
    catch
    end
catch 
end 
%%make the axes tick off
axis(handles.axes1,'off');
axis(handles.axes2,'off');
axis(handles.axes3,'off');
axis(handles.axes4,'off');
axis(handles.axes5,'off');
axis(handles.axes6,'off');
axis(handles.axes7,'off');
axis(handles.axes8,'off');
axis(handles.axes9,'off');

%%set the defalut value of the togglebutton
set(handles.MRI_togglebutton,'value',0);
set(handles.PET_togglebutton,'value',0);
set(handles.MRI_togglebutton,'value',0);



%%set the defalut value of the PET_Input, MRI_Input and scaner Input
set(handles.PET_Input,'string','');
set(handles.MRI_Input,'string','');
set(handles.Scaner_Input,'value',1);

%%clear all the axes
cla(handles.axes1);
cla(handles.axes2);
cla(handles.axes3);
cla(handles.axes4);
cla(handles.axes5);
cla(handles.axes6);
cla(handles.axes7);
cla(handles.axes8);
cla(handles.axes9);

%%make the axes and sliders unvisible
set(handles.slider1,'visible','off');set(handles.slider2,'visible','off');set(handles.slider3,'visible','off');
set(handles.slider4,'visible','off');set(handles.slider5,'visible','off');set(handles.slider6,'visible','off');
set(handles.slider7,'visible','off');set(handles.slider8,'visible','off');set(handles.slider9,'visible','off');
set(handles.axes1,'visible','off');set(handles.axes2,'visible','off');set(handles.axes3,'visible','off');
set(handles.axes4,'visible','off');set(handles.axes5,'visible','off');set(handles.axes6,'visible','off');
set(handles.axes7,'visible','off');set(handles.axes8,'visible','off');set(handles.axes9,'visible','off');
  
%%set the defalut value of the background color
set(handles.MRI_togglebutton,'backgroundcolor',[0,0,0]);
set(handles.PET_togglebutton,'backgroundcolor',[0,0,0]);
set(handles.PET_PVC_togglebutton,'backgroundcolor',[0,0,0]);

%%set the default value of PVC parameters
set(handles.Sig_PET,'string','');
set(handles.Sig_MRI,'string','');
set(handles.Reg_Par,'string','');
set(handles.Step_Size,'string','');
set(handles.Num_Iter,'string','');
set(handles.SVPSF,'Value',0);set(handles.JE_Perior,'value',0);

%%set the defalut value of the X,Y,Z,and voxel Value, Colormap and gray
%%scales
set(handles.X_Value,'string','');
set(handles.Y_Value,'string','');
set(handles.Z_Value,'string','');
set(handles.Voxel_Value,'string','');
set(handles.Color_Map,'value',1);
slider_step(1) = 1/50;
slider_step(2) = 1/50;
set(handles.Gray_Scale1,'sliderstep',slider_step,...
      'max',1,'min',0,...
      'Value',0,'visible','on');
set(handles.Gray_Scale2,'sliderstep',slider_step,...
      'max',1,'min',0,...
      'Value',1,'visible','on');

%%set the default value of the tools
set(handles.Zoom_In,'state','off'); 
set(handles.Zoom_Out,'state','off');
set(handles.Pan,'state','off'); 
set(handles.Data_Cursor,'state','off');  

%%set the default value of the pointer
set(gcf,'pointer','arrow');

%%add the orientation inoformation:
% Update handles structure
Message_State(handles);
guidata(hObject, handles);

% UIWAIT makes July09 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = July09_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in Load.
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%load the PET file and folder

set(handles.figure1, 'pointer', 'watch');

%%clear all the axes
cla(handles.axes1);
cla(handles.axes2);
cla(handles.axes3);
cla(handles.axes4);
cla(handles.axes5);
cla(handles.axes6);
cla(handles.axes7);
cla(handles.axes8);
cla(handles.axes9);

%%delete the previous .mat data.
% try
%     delete('MRI_DATA.mat');
%     delete('PET_DATA.mat');
%     delete('PET_DATA_After_R.mat');
%     try
%         
%         delete('PET_PVC_DATA.mat');
%         delete('MRI_MIP.mat');
%         delete('PET_MIP.mat');
%         delete('PET_PVC_MIP.mat');
%         
%     catch
%     end
% catch 
% end 


%%load the MRI file and folder
% try
%     MRI.dir=get(handles.MRI_Input,'string');%'2DBrainntuh001','CTAC2D001_PT002_PT','IRNAC2D001_PT','LOWDOSECT_H_1001_CT','WBLOWDOSECT_H_1001_CT','WHOLEBODYCTAC3D_4000001_PT'
%     files=dir(fullfile(MRI.dir,'*.dcm'));
%     MRI.fileNames={files.name};
%     MRI.info=dicominfo(fullfile(MRI.dir,MRI.fileNames{1}));
%     MRI.voxel_size=[MRI.info.PixelSpacing; MRI.info.SliceThickness]';
% 
%     numImages=length(MRI.fileNames); 
%     hWaitBar=waitbar(0,'Reading MRI DICOM files');
% 
%     MRI.Matrix=zeros(MRI.info.Rows, MRI.info.Columns, numImages);
%     order=zeros(1,length(MRI.fileNames));
%     for ii=1:length(MRI.fileNames)
%         fname=fullfile(MRI.dir,MRI.fileNames{ii});
%         info=dicominfo(fname);
%         try
%             order(ii)=info.SliceLocation;
%             MRI.Matrix(:,:,ii)=(dicomread(fname)); 
%         catch
%             MRI.Matrix(:,:,ii)=(dicomread(fname));
%         end
%         waitbar((length(MRI.fileNames)-ii+1)/length(MRI.fileNames));
%     end
%     delete(hWaitBar);
% catch
%     errordlg('could not find the file');
% end
% %MRI innitialize finish: has the filed: dir, info, voxel_size, Matrix, fileNames
% [A,I]=sort(order);
% MRI.Matrix=MRI.Matrix(:,:,I);
% 
% %%load the PET data
% try
%     PET.dir=get(handles.PET_Input,'string');%'2DBrainntuh001','CTAC2D001_PT002_PT','IRNAC2D001_PT','LOWDOSECT_H_1001_CT','WBLOWDOSECT_H_1001_CT','WHOLEBODYCTAC3D_4000001_PT'
%     files=dir(fullfile(PET.dir,'*.dcm'));
%     PET.fileNames={files.name};
%     PET.info=dicominfo(fullfile(PET.dir,PET.fileNames{1}));
%     PET.voxel_size=[PET.info.PixelSpacing; PET.info.SliceThickness]';
% 
%     numImages=length(PET.fileNames); 
%     hWaitBar=waitbar(0,'Reading PET DICOM files');
% 
%     PET.Matrix=zeros(PET.info.Rows, PET.info.Columns, numImages);
%     order=zeros(1,length(PET.fileNames));
%     for ii=1:length(PET.fileNames)
%         fname=fullfile(PET.dir,PET.fileNames{ii});
%         info=dicominfo(fname);
%         try
%         order(ii)=info.SliceLocation; 
%         PET.Matrix(:,:,ii)=(dicomread(fname));   
%         catch
%             PET.Matrix(:,:,ii)=(dicomread(fname)); 
%         end
%         waitbar((length(PET.fileNames)-ii+1)/length(PET.fileNames));         
%     end
%     delete(hWaitBar);
% catch
%     errordlg('could not find the file');
% end
% [A,I]=sort(order);
% PET.Matrix=PET.Matrix(:,:,I);
% %%PET innitialize finish: has the filed: dir, info, voxel_size, Matrix, fileNames
% 
% %%save the MRI, PET data
% MRI.Matrix=mat2gray(MRI.Matrix); %scale the value to 0~1
% PET.Matrix=mat2gray(PET.Matrix); %scale the value to 0~1
load('MRI_DATA');
load('PET_DATA');
set(handles.X_Value,'string',num2str(round(size(MRI.Matrix,1)/2)));
set(handles.Y_Value,'string',num2str(round(size(MRI.Matrix,2)/2)));
set(handles.Z_Value,'string',num2str(round(size(MRI.Matrix,3)/2)));

set(handles.slider1,'value',str2double(get(handles.Z_Value,'string')));
set(handles.slider2,'value',str2double(get(handles.X_Value,'string')));
set(handles.slider3,'value',str2double(get(handles.Y_Value,'string')));

set(handles.slider4,'value',str2double(get(handles.Z_Value,'string')));
set(handles.slider5,'value',str2double(get(handles.X_Value,'string')));
set(handles.slider6,'value',str2double(get(handles.Y_Value,'string')));

set(handles.slider7,'value',str2double(get(handles.Z_Value,'string')));
set(handles.slider8,'value',str2double(get(handles.X_Value,'string')));
set(handles.slider9,'value',str2double(get(handles.Y_Value,'string')));
%%which part need the registration code!!!
Registration_Popout; 
Message_State(handles);


    


% --- Executes on button press in Runbtn.
function Runbtn_Callback(hObject, eventdata, handles)
% hObject    handle to Runbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    %check which sacner is used, RIGHT now, only use scaner 1.
    Scaner_choice = get(handles.Scaner_Input,'String');
    Scaner_choice = Scaner_choice(get(handles.Scaner_Input,'value'),:); 
    if (strcmp(Scaner_choice,'Scaner 1'))
        load blurinterp.mat%%need the dataset
    else 
        errordlg('wrong input fro PSF');
    end%%%need add more scaners
    
    %%Load the data
    try
        load('PET_DATA_After_R');
        load('MRI_DATA');
        if(size(MRI.Matrix)~=size(PET.Matrix))
            errordlg('size of two set of images does not match, please first do registration!');
            return
        end
        
        %%%get PVC parameters
        SV_flag=get(handles.SVPSF,'value');
        JE_flag=get(handles.JE_Perior,'value');
        sigscale_x=str2double(get(handles.Sig_PET,'string'));
        sigscale_y=str2double(get(handles.Sig_MRI,'string'));
        reg_par=str2double(get(handles.Reg_Par,'string'));
        step_size=str2double(get(handles.Step_Size,'string'));
        num_iter=str2double(get(handles.Num_Iter,'string'));
        
        
        
        PET_PVC.voxel_size=PET.voxel_size;
        PET_PVC.Matrix=zeros(size(PET.Matrix));
        tic
        try
            set(handles.figure1, 'pointer', 'watch');
            PVC_4D= Gen_PVC_DATA( PET.Matrix, MRI.Matrix, H, D, SV_flag, JE_flag, sigscale_x,sigscale_y,reg_par,step_size,num_iter );    
            PET_PVC.Matrix=PVC_4D(:,:,:,end);
            set(handles.figure1, 'pointer', 'arrow');
        catch
            errordlg('Scaner/Data Error.');
        end
        toc
        PET_PVC.info=PET.info;
        PET_PVC.info.LargestImagePixelValue=PET.info.LargestImagePixelValue*max(PET_PVC.Matrix(:));
        PET_PVC.Matrix=mat2gray(PET_PVC.Matrix);
        save('PET_PVC_DATA','PET_PVC');
        
        
        %%display the 7,8,9
        X_Value=round(str2double(get(handles.X_Value,'string')));set(handles.X_Value,'string',num2str(X_Value));
        Y_Value=round(str2double(get(handles.Y_Value,'string')));set(handles.Y_Value,'string',num2str(Y_Value));
        Z_Value=round(str2double(get(handles.Z_Value,'string')));set(handles.Z_Value,'string',num2str(Z_Value));
        if(get(handles.MRI_togglebutton,'value'))
            set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
        elseif(get(handles.PET_togglebutton,'value'))
            set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
        else
            try
                set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
            catch
            end
        end
        ColorMap_choice = get(handles.Color_Map,'String');
        ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:); 
        cross_tag=strcmp(get(handles.Data_Cursor,'state'),'off');cross_tag=1;
        try
            display_3view_initial(X_Value, Y_Value, Z_Value, PET_PVC.Matrix, handles.axes7, handles.axes8, handles.axes9, PET_PVC.voxel_size, ColorMap_choice,cross_tag ,get(handles.MIP,'value'));
            Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
        catch
            keyboard;
            errordlg('unknow_error!');
        end

        %%chenck the toggle button
        if(get(handles.MRI_togglebutton,'value')==1)
            set(handles.MRI_panel,'visible','on');
            set(handles.PET_panel,'visible','off');
            set(handles.PET_PVC_panel,'visible','off');
        elseif(get(handles.PET_togglebutton,'value')==1)
            set(handles.MRI_panel,'visible','off');
            set(handles.PET_panel,'visible','on');
            set(handles.PET_PVC_panel,'visible','off');
        elseif(get(handles.PET_PVC_togglebutton,'value')==1)
            set(handles.MRI_panel,'visible','off');
            set(handles.PET_panel,'visible','off');
            set(handles.PET_PVC_panel,'visible','on');
        else
        end
    catch
        errordlg('please first load the MRI/PET data!');
    end
   Message_State(handles); 



% --------------------------------------------------------------------
function Information_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Information_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in MRI_Dir.
function MRI_Dir_Callback(hObject, eventdata, handles)
% hObject    handle to MRI_Dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[folder_Name]=uigetdir(pwd,'Please select a file');
set(handles.MRI_Input,'string',folder_Name);
%%load the MRI file and folder
try
    MRI.dir=get(handles.MRI_Input,'string');%'2DBrainntuh001','CTAC2D001_PT002_PT','IRNAC2D001_PT','LOWDOSECT_H_1001_CT','WBLOWDOSECT_H_1001_CT','WHOLEBODYCTAC3D_4000001_PT'
    files=dir(fullfile(MRI.dir,'*.dcm'));
    MRI.fileNames={files.name};
    MRI.info=dicominfo(fullfile(MRI.dir,MRI.fileNames{1}));
    MRI.voxel_size=[MRI.info.PixelSpacing; MRI.info.SliceThickness]';

    numImages=length(MRI.fileNames); 
    hWaitBar=waitbar(0,'Reading MRI DICOM files');

    MRI.Matrix=zeros(MRI.info.Rows, MRI.info.Columns, numImages);
    order=zeros(1,length(MRI.fileNames));
    for ii=1:length(MRI.fileNames)
        fname=fullfile(MRI.dir,MRI.fileNames{ii});
        info=dicominfo(fname);
        try
            order(ii)=info.SliceLocation;
            MRI.info=dicominfo(fullfile(MRI.dir,MRI.fileNames{ii}));
            MRI.Matrix(:,:,ii)=(dicomread(fname)*MRI.info.RescaleSlope+MRI.info.RescaleIntercept);   
        catch
            order(ii)=info.SliceLocation;
            MRI.Matrix(:,:,ii)=(dicomread(fname));
        end
        waitbar((length(MRI.fileNames)-ii+1)/length(MRI.fileNames));
    end
    delete(hWaitBar);
catch
    errordlg('could not find the file');
end
%MRI innitialize finish: has the filed: dir, info, voxel_size, Matrix, fileNames
[A,I]=sort(order);
MRI.Matrix=MRI.Matrix(:,:,I);
MRI.info.LargestImagePixelValue=max(MRI.Matrix(:));
MRI.info.SmallestImagePixelValue=min(MRI.Matrix(:));
MRI.Matrix=mat2gray(MRI.Matrix); %scale the value to 0~1

MRI.voxel_size(3)=(max(order)-min(order))/(length(MRI.fileNames)-1);
save('MRI_DATA','MRI');

set(handles.X_Value,'string',num2str(round(size(MRI.Matrix,1)/2)));
set(handles.Y_Value,'string',num2str(round(size(MRI.Matrix,2)/2)));
set(handles.Z_Value,'string',num2str(round(size(MRI.Matrix,3)/2)));
guidata(hObject, handles);

% --- Executes on button press in PET_Dir.
function PET_Dir_Callback(hObject, eventdata, handles)
% hObject    handle to PET_Dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[folder_Name]=uigetdir(pwd,'Please select a file');
set(handles.PET_Input,'string',folder_Name);

%%load the PET data
try
    PET.dir=get(handles.PET_Input,'string');%'2DBrainntuh001','CTAC2D001_PT002_PT','IRNAC2D001_PT','LOWDOSECT_H_1001_CT','WBLOWDOSECT_H_1001_CT','WHOLEBODYCTAC3D_4000001_PT'
    files=dir(fullfile(PET.dir,'*.dcm'));
    PET.fileNames={files.name};
    PET.info=dicominfo(fullfile(PET.dir,PET.fileNames{1}));
    PET.voxel_size=[PET.info.PixelSpacing; PET.info.SliceThickness]';

    numImages=length(PET.fileNames); 
    hWaitBar=waitbar(0,'Reading PET DICOM files');

    PET.Matrix=zeros(PET.info.Rows, PET.info.Columns, numImages);
    order=zeros(1,length(PET.fileNames));
    for ii=1:length(PET.fileNames)
        fname=fullfile(PET.dir,PET.fileNames{ii});
        info=dicominfo(fname);
        try
        order(ii)=info.SliceLocation; 
        PET.info=dicominfo(fullfile(PET.dir,PET.fileNames{ii}));
        PET.Matrix(:,:,ii)=(dicomread(fname)*PET.info.RescaleSlope+PET.info.RescaleIntercept);    
        catch
            order(ii)=info.SliceLocation;
            PET.Matrix(:,:,ii)=(dicomread(fname)); 
        end
        waitbar((length(PET.fileNames)-ii+1)/length(PET.fileNames));         
    end
    delete(hWaitBar);
catch
    errordlg('could not find the file');
end
[A,I]=sort(order);
PET.Matrix=PET.Matrix(:,:,I);
PET.info.LargestImagePixelValue=max(PET.Matrix(:));
PET.info.SmallestImagePixelValue=min(PET.Matrix(:));
%%PET innitialize finish: has the filed: dir, info, voxel_size, Matrix, fileNames
PET.Matrix=mat2gray(PET.Matrix); %scale the value to 0~1
PET.voxel_size(3)=(max(order)-min(order))/(length(PET.fileNames)-1);
save('PET_DATA','PET');
guidata(hObject, handles);




% --- Executes on button press in Matrix_Dir.
function Matrix_Dir_Callback(hObject, eventdata, handles)
% hObject    handle to Matrix_Dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[imageName,imagePath]=uigetfile({'*.img;*.nii;*.mat'},'Please select a file');
set(handles.Scaner_Input,'string',strcat(imagePath,imageName));guidata(hObject, handles);





% --- Executes during object creation, after setting all properties.
function Matrix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Scaner_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function X_Value_Callback(hObject, eventdata, handles)
% hObject    handle to X_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_Value as text
%        str2double(get(hObject,'String')) returns contents of X_Value as a double
    X_Value=round(str2double(get(handles.X_Value,'string')));set(handles.X_Value,'string',num2str(X_Value));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Y_Value=round(str2double(get(handles.Y_Value,'string')));set(handles.Y_Value,'string',num2str(Y_Value));
    Z_Value=round(str2double(get(handles.Z_Value,'string')));set(handles.Z_Value,'string',num2str(Z_Value));

    
    ColorMap_choice = get(handles.Color_Map,'String');
    ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
    cross_tag=strcmp(get(handles.Data_Cursor,'state'),'off');cross_tag=1;
    if(get(handles.MRI_togglebutton,'value'))
    load MRI_DATA.mat;  
    display_3view(X_Value, Y_Value, Z_Value, MRI.Matrix,handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
    
    set(handles.slider1,'value',str2double(get(handles.Z_Value,'string')));
    set(handles.slider2,'value',str2double(get(handles.X_Value,'string')));
    set(handles.slider3,'value',str2double(get(handles.Y_Value,'string')));
    elseif(get(handles.PET_togglebutton,'value'))
    load PET_DATA_After_R.mat;
    display_3view(X_Value, Y_Value, Z_Value, PET.Matrix,handles.axes4, handles.axes5, handles.axes6, PET.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
    set(handles.slider4,'value',str2double(get(handles.Z_Value,'string')));
    set(handles.slider5,'value',str2double(get(handles.X_Value,'string')));
    set(handles.slider6,'value',str2double(get(handles.Y_Value,'string')));
    elseif(get(handles.PET_PVC_togglebutton,'value'))
        try
            load PET_PVC_DATA.mat;
            display_3view(X_Value, Y_Value, Z_Value, PET_PVC.Matrix,handles.axes7, handles.axes8, handles.axes9, PET_PVC.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
            Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
            set(handles.slider7,'value',str2double(get(handles.Z_Value,'string')));
            set(handles.slider8,'value',str2double(get(handles.X_Value,'string')));
            set(handles.slider9,'value',str2double(get(handles.Y_Value,'string')));
        catch
            errordlg('NO PET_PVC data available, please choose another toggle button! ');
        end
    end
    
    if(get(handles.MRI_togglebutton,'value'))
        set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
    elseif(get(handles.PET_togglebutton,'value'))
        set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
    else
        try
            set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
        catch
        end
    end    

% --- Executes during object creation, after setting all properties.
function X_Value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y_Value_Callback(hObject, eventdata, handles)
% hObject    handle to Y_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y_Value as text
%        str2double(get(hObject,'String')) returns contents of Y_Value as a double
    
    Y_Value=round(str2double(get(handles.Y_Value,'string')));set(handles.Y_Value,'string',num2str(Y_Value));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
    X_Value=round(str2double(get(handles.X_Value,'string')));set(handles.X_Value,'string',num2str(X_Value));
    Z_Value=round(str2double(get(handles.Z_Value,'string')));set(handles.Z_Value,'string',num2str(Z_Value));

      
    ColorMap_choice = get(handles.Color_Map,'String');
    ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
    cross_tag=strcmp(get(handles.Data_Cursor,'state'),'off');cross_tag=1;
    if(get(handles.MRI_togglebutton,'value'))
    load MRI_DATA.mat;  
    display_3view(X_Value, Y_Value, Z_Value, MRI.Matrix,handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
    
    set(handles.slider1,'value',str2double(get(handles.Z_Value,'string')));
    set(handles.slider2,'value',str2double(get(handles.X_Value,'string')));
    set(handles.slider3,'value',str2double(get(handles.Y_Value,'string')));
    elseif(get(handles.PET_togglebutton,'value'))
    load PET_DATA_After_R.mat;
    display_3view(X_Value, Y_Value, Z_Value, PET.Matrix,handles.axes4, handles.axes5, handles.axes6, PET.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
    set(handles.slider4,'value',str2double(get(handles.Z_Value,'string')));
    set(handles.slider5,'value',str2double(get(handles.X_Value,'string')));
    set(handles.slider6,'value',str2double(get(handles.Y_Value,'string')));
    elseif(get(handles.PET_PVC_togglebutton,'value'))
        try
            load PET_PVC_DATA.mat;
            display_3view(X_Value, Y_Value, Z_Value, PET_PVC.Matrix,handles.axes7, handles.axes8, handles.axes9, PET_PVC.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
            Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
            set(handles.slider7,'value',str2double(get(handles.Z_Value,'string')));
            set(handles.slider8,'value',str2double(get(handles.X_Value,'string')));
            set(handles.slider9,'value',str2double(get(handles.Y_Value,'string')));
        catch
            errordlg('NO PET_PVC data available, please choose another toggle button! ');
        end
    end
    
    if(get(handles.MRI_togglebutton,'value'))
        set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
    elseif(get(handles.PET_togglebutton,'value'))
        set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
    else
        try
            set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
        catch
        end
    end  
% --- Executes during object creation, after setting all properties.
function Y_Value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z_Value_Callback(hObject, eventdata, handles)
% hObject    handle to Z_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z_Value as text
%        str2double(get(hObject,'String')) returns contents of Z_Value as a double
    
    Z_Value=round(str2double(get(handles.Z_Value,'string')));set(handles.Z_Value,'string',num2str(Z_Value));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    X_Value=round(str2double(get(handles.X_Value,'string')));set(handles.X_Value,'string',num2str(X_Value));
    Y_Value=round(str2double(get(handles.Y_Value,'string')));set(handles.Y_Value,'string',num2str(Y_Value));
    
    
    ColorMap_choice = get(handles.Color_Map,'String');
    ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
    cross_tag=strcmp(get(handles.Data_Cursor,'state'),'off');cross_tag=1;
    if(get(handles.MRI_togglebutton,'value'))
    load MRI_DATA.mat;  
    display_3view(X_Value, Y_Value, Z_Value, MRI.Matrix,handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
    
    set(handles.slider1,'value',str2double(get(handles.Z_Value,'string')));
    set(handles.slider2,'value',str2double(get(handles.X_Value,'string')));
    set(handles.slider3,'value',str2double(get(handles.Y_Value,'string')));
    elseif(get(handles.PET_togglebutton,'value'))
    load PET_DATA_After_R.mat;
    display_3view(X_Value, Y_Value, Z_Value, PET.Matrix,handles.axes4, handles.axes5, handles.axes6, PET.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
    set(handles.slider4,'value',str2double(get(handles.Z_Value,'string')));
    set(handles.slider5,'value',str2double(get(handles.X_Value,'string')));
    set(handles.slider6,'value',str2double(get(handles.Y_Value,'string')));
    elseif(get(handles.PET_PVC_togglebutton,'value'))
        try
            load PET_PVC_DATA.mat;
            display_3view(X_Value, Y_Value, Z_Value, PET_PVC.Matrix,handles.axes7, handles.axes8, handles.axes9, PET_PVC.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
            Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
            set(handles.slider7,'value',str2double(get(handles.Z_Value,'string')));
            set(handles.slider8,'value',str2double(get(handles.X_Value,'string')));
            set(handles.slider9,'value',str2double(get(handles.Y_Value,'string')));
        catch
            errordlg('NO PET_PVC data available, please choose another toggle button! ');
        end
    end
    
    if(get(handles.MRI_togglebutton,'value'))
        set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
    elseif(get(handles.PET_togglebutton,'value'))
        set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
    else
        try
            set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
        catch
        end
    end
    
% --- Executes during object creation, after setting all properties.
function Z_Value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes when selected object is changed in Displaypanel.
function Displaypanel_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in Displaypanel 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in MRI_togglebutton.
function MRI_togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to MRI_togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MRI_togglebutton


% --- Executes when selected object is changed in ToggleBtnPanel.
function ToggleBtnPanel_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in ToggleBtnPanel 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%get colormap and cross_tag
ColorMap_choice = get(handles.Color_Map,'String');
ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
cross_tag=strcmp(get(handles.Data_Cursor,'state'),'off');cross_tag=1;
%%toggle button event function
switch get(eventdata.NewValue,'Tag')
    case 'MRI_togglebutton'
        load MRI_DATA.mat;
        set(handles.MRI_panel,'visible','on');
        set(handles.PET_panel,'visible','off');
        set(handles.PET_PVC_panel,'visible','off');
        
        set(handles.MRI_togglebutton,'backgroundcolor',[0.8,0.8,0.8]);
        set(handles.PET_togglebutton,'backgroundcolor',[0,0,0]);
        set(handles.PET_PVC_togglebutton,'backgroundcolor',[0,0,0]);
        
        set(handles.MRI_togglebutton,'Fontweight','bold');
        set(handles.PET_togglebutton,'Fontweight','normal');
        set(handles.PET_PVC_togglebutton,'Fontweight','normal');
        
        set(handles.X_Value,'STRING',num2str(get(handles.slider2,'value')));
        set(handles.Y_Value,'STRING',num2str(get(handles.slider3,'value')));
        set(handles.Z_Value,'STRING',num2str(get(handles.slider1,'value')));
        
        X_Value=round(str2double(get(handles.X_Value,'string')));
        Y_Value=round(str2double(get(handles.Y_Value,'string')));
        Z_Value=round(str2double(get(handles.Z_Value,'string')));
        
        if(get(handles.MRI_togglebutton,'value'))
            set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
        elseif(get(handles.PET_togglebutton,'value'))
            set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
        else
            try
                set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
            catch
            end
        end
        display_3view(X_Value, Y_Value, Z_Value, MRI.Matrix,handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
        Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
    case 'PET_togglebutton'
        try
        load PET_DATA_After_R.mat;
        catch
            load PET_DATA.mat;
        end
        set(handles.MRI_panel,'visible','off');
        set(handles.PET_panel,'visible','on');
        set(handles.PET_PVC_panel,'visible','off');
        
        set(handles.MRI_togglebutton,'backgroundcolor',[0,0,0]);
        set(handles.PET_togglebutton,'backgroundcolor',[0.8,0.8,0.8]);
        set(handles.PET_PVC_togglebutton,'backgroundcolor',[0,0,0]);
        
        set(handles.MRI_togglebutton,'Fontweight','normal');
        set(handles.PET_togglebutton,'Fontweight','bold');
        set(handles.PET_PVC_togglebutton,'Fontweight','normal');
        
        set(handles.X_Value,'STRING',num2str(get(handles.slider5,'value')));
        set(handles.Y_Value,'STRING',num2str(get(handles.slider6,'value')));
        set(handles.Z_Value,'STRING',num2str(get(handles.slider4,'value')));
        X_Value=round(str2double(get(handles.X_Value,'string')));
        Y_Value=round(str2double(get(handles.Y_Value,'string')));
        Z_Value=round(str2double(get(handles.Z_Value,'string')));
        
        if(get(handles.MRI_togglebutton,'value'))
            set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
        elseif(get(handles.PET_togglebutton,'value'))
            set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
        else
            try
                set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
            catch
            end
        end
        display_3view(X_Value, Y_Value, Z_Value, PET.Matrix,handles.axes4, handles.axes5, handles.axes6, PET.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
        Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
    case 'PET_PVC_togglebutton'
        set(handles.MRI_panel,'visible','off');
        set(handles.PET_panel,'visible','off');
        set(handles.PET_PVC_panel,'visible','on');

        set(handles.MRI_togglebutton,'backgroundcolor',[0,0,0]);
        set(handles.PET_togglebutton,'backgroundcolor',[0,0,0]);
        set(handles.PET_PVC_togglebutton,'backgroundcolor',[0.8,0.8,0.8]);
        set(handles.MRI_togglebutton,'Fontweight','normal');
        set(handles.PET_togglebutton,'Fontweight','normal');
        set(handles.PET_PVC_togglebutton,'Fontweight','bold');
        set(handles.X_Value,'STRING',num2str(get(handles.slider8,'value')));
        set(handles.Y_Value,'STRING',num2str(get(handles.slider9,'value')));
        set(handles.Z_Value,'STRING',num2str(get(handles.slider7,'value')));
        X_Value=round(str2double(get(handles.X_Value,'string')));
        Y_Value=round(str2double(get(handles.Y_Value,'string')));
        Z_Value=round(str2double(get(handles.Z_Value,'string')));

        if(get(handles.MRI_togglebutton,'value'))
            set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
        elseif(get(handles.PET_togglebutton,'value'))
            set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
        else
            try
                set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
            catch
            end
        end
        try
            load PET_PVC_DATA.mat;
            display_3view(X_Value, Y_Value, Z_Value, PET_PVC.Matrix,handles.axes7, handles.axes8, handles.axes9, PET_PVC.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
            Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
        catch
            cla(handles.axes7);cla(handles.axes8);cla(handles.axes9);
            set(handles.axes7,'visible','off');set(handles.axes8,'visible','off');set(handles.axes9,'visible','off');
            errordlg('NO PET_PVC data available, please choose another toggle button! ');
        end
    otherwise
    errordlg('Something wrong with the GUI! How did that happen?')
end


    
    

% --- Executes on scroll wheel click while the figure is in focus.This part
% is complex, but not hard to
% understand!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!need careful
function figure1_WindowScrollWheelFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	VerticalScrollCount: signed integer indicating direction and number of clicks
%	VerticalScrollAmount: number of lines scrolled for each click
% handles    structure with handles and user data (see GUIDATA)
global current_axes

    
    %%judge whether the current_axes belongs to current visible panel, if it is not then set
    %%it to the first axis of the current visible panel
    if(get(handles.MRI_togglebutton,'value'))
        if(~(current_axes==handles.axes1||current_axes==handles.axes2||current_axes==handles.axes3))
            current_axes=handles.axes1;
        end
    end

    if(get(handles.PET_togglebutton,'value'))
        if(~(current_axes==handles.axes4||current_axes==handles.axes5||current_axes==handles.axes6))
            current_axes=handles.axes4;
        end
    end

    if(get(handles.PET_PVC_togglebutton,'value'))
        if(~(current_axes==handles.axes7||current_axes==handles.axes8||current_axes==handles.axes9))
            current_axes=handles.axes7;
        end
    end

    %%get the colormap 
    ColorMap_choice = get(handles.Color_Map,'String');
    ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
    switch current_axes
        case handles.axes1
            load MRI_DATA.mat;
            if(eventdata.VerticalScrollCount > 0) 
                if(get(handles.slider1,'value')>1)
                    set(handles.slider1,'value',get(handles.slider1,'value')-1);set(handles.Z_Value,'string',num2str((get(handles.slider1,'Value'))));
                    Z_Value=1+round((get(handles.slider1,'Value')-get(handles.slider1,'Min'))/(get(handles.slider1,'Max')-get(handles.slider1,'Min')+1)...
                        *size(MRI.Matrix,3));
                    X_Value=1+round((get(handles.slider2,'Value')-get(handles.slider2,'Min'))/(get(handles.slider2,'Max')-get(handles.slider2,'Min')+1)...
                        *size(MRI.Matrix,1));
                    Y_Value=1+round((get(handles.slider3,'Value')-get(handles.slider3,'Min'))/(get(handles.slider3,'Max')-get(handles.slider3,'Min')+1)...
                        *size(MRI.Matrix,2));
                    
                    if(get(handles.MRI_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
                    elseif(get(handles.PET_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                    else
                        try
                            set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                        catch
                        end
                    end
                    display_3view(X_Value, Y_Value, Z_Value, MRI.Matrix,handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size,ColorMap_choice, 'off' ,get(handles.MIP,'value'));
                    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
                end
            elseif(eventdata.VerticalScrollCount < 0) 
                if(get(handles.slider1,'value')<size(MRI.Matrix,3))
                    set(handles.slider1,'value',get(handles.slider1,'value')+1);set(handles.Z_Value,'string',num2str((get(handles.slider1,'Value'))));
                    Z_Value=1+round((get(handles.slider1,'Value')-get(handles.slider1,'Min'))/(get(handles.slider1,'Max')-get(handles.slider1,'Min')+1)...
                        *size(MRI.Matrix,3));
                    X_Value=1+round((get(handles.slider2,'Value')-get(handles.slider2,'Min'))/(get(handles.slider2,'Max')-get(handles.slider2,'Min')+1)...
                        *size(MRI.Matrix,1));
                    Y_Value=1+round((get(handles.slider3,'Value')-get(handles.slider3,'Min'))/(get(handles.slider3,'Max')-get(handles.slider3,'Min')+1)...
                        *size(MRI.Matrix,2));
                    
                    if(get(handles.MRI_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
                    elseif(get(handles.PET_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                    else
                        try
                            set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                        catch
                        end
                    end
                    display_3view(X_Value, Y_Value, Z_Value, MRI.Matrix,handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size,ColorMap_choice, 'off' ,get(handles.MIP,'value'));
                    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
                end
            end
        case handles.axes2
            load MRI_DATA.mat;
            if(eventdata.VerticalScrollCount > 0) 
                if(get(handles.slider2,'value')>1)
                    set(handles.slider2,'value',get(handles.slider2,'value')-1);set(handles.X_Value,'string',num2str((get(handles.slider2,'Value'))));
                    Z_Value=1+round((get(handles.slider1,'Value')-get(handles.slider1,'Min'))/(get(handles.slider1,'Max')-get(handles.slider1,'Min')+1)...
                        *size(MRI.Matrix,3));
                    X_Value=1+round((get(handles.slider2,'Value')-get(handles.slider2,'Min'))/(get(handles.slider2,'Max')-get(handles.slider2,'Min')+1)...
                        *size(MRI.Matrix,1));
                    Y_Value=1+round((get(handles.slider3,'Value')-get(handles.slider3,'Min'))/(get(handles.slider3,'Max')-get(handles.slider3,'Min')+1)...
                        *size(MRI.Matrix,2));
                    
                    if(get(handles.MRI_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
                    elseif(get(handles.PET_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                    else
                        try
                            set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                        catch
                        end
                    end
                    display_3view(X_Value, Y_Value, Z_Value, MRI.Matrix,handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size,ColorMap_choice, 'off' ,get(handles.MIP,'value'));
                    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
                end
            elseif(eventdata.VerticalScrollCount < 0) 
                if(get(handles.slider2,'value')<size(MRI.Matrix,1))
                    set(handles.slider2,'value',get(handles.slider2,'value')+1);set(handles.X_Value,'string',num2str((get(handles.slider2,'Value'))));
                    Z_Value=1+round((get(handles.slider1,'Value')-get(handles.slider1,'Min'))/(get(handles.slider1,'Max')-get(handles.slider1,'Min')+1)...
                        *size(MRI.Matrix,3));
                    X_Value=1+round((get(handles.slider2,'Value')-get(handles.slider2,'Min'))/(get(handles.slider2,'Max')-get(handles.slider2,'Min')+1)...
                        *size(MRI.Matrix,1));
                    Y_Value=1+round((get(handles.slider3,'Value')-get(handles.slider3,'Min'))/(get(handles.slider3,'Max')-get(handles.slider3,'Min')+1)...
                        *size(MRI.Matrix,2));
                    if(get(handles.MRI_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
                    elseif(get(handles.PET_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                    else
                        try
                            set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                        catch
                        end
                    end
                    display_3view(X_Value, Y_Value, Z_Value, MRI.Matrix,handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size,ColorMap_choice, 'off' ,get(handles.MIP,'value'));
                    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
                end
            end
        case handles.axes3
            load MRI_DATA.mat;
            if(eventdata.VerticalScrollCount > 0) 
                if(get(handles.slider3,'value')>1)
                    set(handles.slider3,'value',get(handles.slider3,'value')-1);set(handles.Y_Value,'string',num2str((get(handles.slider3,'Value'))));
                    Z_Value=1+round((get(handles.slider1,'Value')-get(handles.slider1,'Min'))/(get(handles.slider1,'Max')-get(handles.slider1,'Min')+1)...
                        *size(MRI.Matrix,3));
                    X_Value=1+round((get(handles.slider2,'Value')-get(handles.slider2,'Min'))/(get(handles.slider2,'Max')-get(handles.slider2,'Min')+1)...
                        *size(MRI.Matrix,1));
                    Y_Value=1+round((get(handles.slider3,'Value')-get(handles.slider3,'Min'))/(get(handles.slider3,'Max')-get(handles.slider3,'Min')+1)...
                        *size(MRI.Matrix,2));
                    if(get(handles.MRI_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
                    elseif(get(handles.PET_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                    else
                        try
                            set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                        catch
                        end
                    end
                    display_3view(X_Value, Y_Value, Z_Value, MRI.Matrix,handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size,ColorMap_choice, 'off' ,get(handles.MIP,'value'));
                    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
                end
            elseif(eventdata.VerticalScrollCount < 0) 
                if(get(handles.slider3,'value')<size(MRI.Matrix,2))
                    set(handles.slider3,'value',get(handles.slider3,'value')+1);set(handles.Y_Value,'string',num2str((get(handles.slider3,'Value'))));
                    Z_Value=1+round((get(handles.slider1,'Value')-get(handles.slider1,'Min'))/(get(handles.slider1,'Max')-get(handles.slider1,'Min')+1)...
                        *size(MRI.Matrix,3));
                    X_Value=1+round((get(handles.slider2,'Value')-get(handles.slider2,'Min'))/(get(handles.slider2,'Max')-get(handles.slider2,'Min')+1)...
                        *size(MRI.Matrix,1));
                    Y_Value=1+round((get(handles.slider3,'Value')-get(handles.slider3,'Min'))/(get(handles.slider3,'Max')-get(handles.slider3,'Min')+1)...
                        *size(MRI.Matrix,2));
                    if(get(handles.MRI_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
                    elseif(get(handles.PET_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                    else
                        try
                            set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                        catch
                        end
                    end
                    display_3view(X_Value, Y_Value, Z_Value, MRI.Matrix,handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size,ColorMap_choice, 'off' ,get(handles.MIP,'value'));
                    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
                end
            end

        %for image 4, 5, 6
        case handles.axes4
            try
            load PET_DATA_After_R.mat;
            catch
                load PET_DATA;
            end
            if(eventdata.VerticalScrollCount > 0) 
                if(get(handles.slider4,'value')>1)
                    set(handles.slider4,'value',get(handles.slider4,'value')-1);set(handles.Z_Value,'string',num2str((get(handles.slider4,'Value'))));
                    Z_Value=1+round((get(handles.slider4,'Value')-get(handles.slider4,'Min'))/(get(handles.slider4,'Max')-get(handles.slider4,'Min')+1)...
                        *size(PET.Matrix,3));
                    X_Value=1+round((get(handles.slider5,'Value')-get(handles.slider5,'Min'))/(get(handles.slider5,'Max')-get(handles.slider5,'Min')+1)...
                        *size(PET.Matrix,1));
                    Y_Value=1+round((get(handles.slider6,'Value')-get(handles.slider6,'Min'))/(get(handles.slider6,'Max')-get(handles.slider6,'Min')+1)...
                        *size(PET.Matrix,2));
                    if(get(handles.MRI_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
                    elseif(get(handles.PET_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                    else
                        try
                            set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                        catch
                        end
                    end
                    display_3view(X_Value, Y_Value, Z_Value, PET.Matrix,handles.axes4, handles.axes5, handles.axes6, PET.voxel_size,ColorMap_choice, 'off' ,get(handles.MIP,'value'));
                    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
                end
            elseif(eventdata.VerticalScrollCount < 0) 
                if(get(handles.slider4,'value')<size(PET.Matrix,3))
                    set(handles.slider4,'value',get(handles.slider4,'value')+1);set(handles.Z_Value,'string',num2str((get(handles.slider4,'Value'))));
                    Z_Value=1+round((get(handles.slider4,'Value')-get(handles.slider4,'Min'))/(get(handles.slider4,'Max')-get(handles.slider4,'Min')+1)...
                        *size(PET.Matrix,3));
                    X_Value=1+round((get(handles.slider5,'Value')-get(handles.slider5,'Min'))/(get(handles.slider5,'Max')-get(handles.slider5,'Min')+1)...
                        *size(PET.Matrix,1));
                    Y_Value=1+round((get(handles.slider6,'Value')-get(handles.slider6,'Min'))/(get(handles.slider6,'Max')-get(handles.slider6,'Min')+1)...
                        *size(PET.Matrix,2));
                    if(get(handles.MRI_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
                    elseif(get(handles.PET_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                    else
                        try
                            set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                        catch
                        end
                    end
                    display_3view(X_Value, Y_Value, Z_Value, PET.Matrix,handles.axes4, handles.axes5, handles.axes6, PET.voxel_size,ColorMap_choice, 'off' ,get(handles.MIP,'value'));
                    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
                end
            end
        case handles.axes5
            try
            load PET_DATA_After_R.mat;
            catch
                load PET_DATA;
            end
            if(eventdata.VerticalScrollCount > 0) 
                if(get(handles.slider5,'value')>1)
                    set(handles.slider5,'value',get(handles.slider5,'value')-1);set(handles.X_Value,'string',num2str((get(handles.slider5,'Value'))));
                    Z_Value=1+round((get(handles.slider4,'Value')-get(handles.slider4,'Min'))/(get(handles.slider4,'Max')-get(handles.slider1,'Min')+1)...
                        *size(PET.Matrix,3));
                    X_Value=1+round((get(handles.slider5,'Value')-get(handles.slider5,'Min'))/(get(handles.slider5,'Max')-get(handles.slider2,'Min')+1)...
                        *size(PET.Matrix,1));
                    Y_Value=1+round((get(handles.slider6,'Value')-get(handles.slider6,'Min'))/(get(handles.slider6,'Max')-get(handles.slider3,'Min')+1)...
                        *size(PET.Matrix,2));
                    if(get(handles.MRI_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
                    elseif(get(handles.PET_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                    else
                        try
                            set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                        catch
                        end
                    end
                    display_3view(X_Value, Y_Value, Z_Value, PET.Matrix,handles.axes4, handles.axes5, handles.axes6, PET.voxel_size,ColorMap_choice, 'off' ,get(handles.MIP,'value'));
                    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
                end
            elseif(eventdata.VerticalScrollCount < 0) 
                if(get(handles.slider5,'value')<size(PET.Matrix,1))
                    set(handles.slider5,'value',get(handles.slider5,'value')+1);set(handles.X_Value,'string',num2str((get(handles.slider5,'Value'))));
                    Z_Value=1+round((get(handles.slider4,'Value')-get(handles.slider4,'Min'))/(get(handles.slider4,'Max')-get(handles.slider4,'Min')+1)...
                        *size(PET.Matrix,3));
                    X_Value=1+round((get(handles.slider5,'Value')-get(handles.slider5,'Min'))/(get(handles.slider5,'Max')-get(handles.slider5,'Min')+1)...
                        *size(PET.Matrix,1));
                    Y_Value=1+round((get(handles.slider6,'Value')-get(handles.slider6,'Min'))/(get(handles.slider6,'Max')-get(handles.slider6,'Min')+1)...
                        *size(PET.Matrix,2));
                    if(get(handles.MRI_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
                    elseif(get(handles.PET_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                    else
                        try
                            set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                        catch
                        end
                    end
                    display_3view(X_Value, Y_Value, Z_Value, PET.Matrix,handles.axes4, handles.axes5, handles.axes6, PET.voxel_size,ColorMap_choice, 'off' ,get(handles.MIP,'value'));
                    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
                end
            end
        case handles.axes6
            try
            load PET_DATA_After_R.mat;
            catch
                load PET_DATA;
            end
            if(eventdata.VerticalScrollCount > 0) 
                if(get(handles.slider6,'value')>1)
                    set(handles.slider6,'value',get(handles.slider6,'value')-1);set(handles.Y_Value,'string',num2str((get(handles.slider6,'Value'))));
                    Z_Value=1+round((get(handles.slider4,'Value')-get(handles.slider4,'Min'))/(get(handles.slider4,'Max')-get(handles.slider4,'Min')+1)...
                        *size(PET.Matrix,3));
                    X_Value=1+round((get(handles.slider5,'Value')-get(handles.slider5,'Min'))/(get(handles.slider5,'Max')-get(handles.slider5,'Min')+1)...
                        *size(PET.Matrix,1));
                    Y_Value=1+round((get(handles.slider6,'Value')-get(handles.slider6,'Min'))/(get(handles.slider6,'Max')-get(handles.slider6,'Min')+1)...
                        *size(PET.Matrix,2));
                    if(get(handles.MRI_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
                    elseif(get(handles.PET_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                    else
                        try
                            set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                        catch
                        end
                    end
                    display_3view(X_Value, Y_Value, Z_Value, PET.Matrix,handles.axes4, handles.axes5, handles.axes6, PET.voxel_size,ColorMap_choice, 'off' ,get(handles.MIP,'value'));
                    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
                end
            elseif(eventdata.VerticalScrollCount < 0) 
                if(get(handles.slider6,'value')<size(PET.Matrix,2))
                    set(handles.slider6,'value',get(handles.slider6,'value')+1);set(handles.Y_Value,'string',num2str((get(handles.slider6,'Value'))));
                    Z_Value=1+round((get(handles.slider4,'Value')-get(handles.slider4,'Min'))/(get(handles.slider4,'Max')-get(handles.slider4,'Min')+1)...
                        *size(PET.Matrix,3));
                    X_Value=1+round((get(handles.slider5,'Value')-get(handles.slider5,'Min'))/(get(handles.slider5,'Max')-get(handles.slider5,'Min')+1)...
                        *size(PET.Matrix,1));
                    Y_Value=1+round((get(handles.slider6,'Value')-get(handles.slider6,'Min'))/(get(handles.slider6,'Max')-get(handles.slider6,'Min')+1)...
                        *size(PET.Matrix,2));

                    if(get(handles.MRI_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
                    elseif(get(handles.PET_togglebutton,'value'))
                        set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                    else
                        try
                            set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                        catch
                        end
                    end
                    display_3view(X_Value, Y_Value, Z_Value, PET.Matrix,handles.axes4, handles.axes5, handles.axes6, PET.voxel_size,ColorMap_choice, 'off' ,get(handles.MIP,'value'));
                    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
                end
            end
        case handles.axes7
            try
                load PET_PVC_DATA.mat;
                if(eventdata.VerticalScrollCount > 0) 
                    if(get(handles.slider7,'value')>1)
                        set(handles.slider7,'value',get(handles.slider7,'value')-1);set(handles.Z_Value,'string',num2str((get(handles.slider7,'Value'))));
                        Z_Value=1+round((get(handles.slider7,'Value')-get(handles.slider7,'Min'))/(get(handles.slider7,'Max')-get(handles.slider7,'Min')+1)...
                            *size(PET_PVC.Matrix,3));
                        X_Value=1+round((get(handles.slider8,'Value')-get(handles.slider8,'Min'))/(get(handles.slider8,'Max')-get(handles.slider8,'Min')+1)...
                            *size(PET_PVC.Matrix,1));
                        Y_Value=1+round((get(handles.slider9,'Value')-get(handles.slider9,'Min'))/(get(handles.slider9,'Max')-get(handles.slider9,'Min')+1)...
                            *size(PET_PVC.Matrix,2));
                        if(get(handles.MRI_togglebutton,'value'))
                            set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
                        elseif(get(handles.PET_togglebutton,'value'))
                            set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                        else
                            try
                                set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                            catch
                            end
                        end
                        display_3view(X_Value, Y_Value, Z_Value, PET_PVC.Matrix,handles.axes7, handles.axes8, handles.axes9, PET_PVC.voxel_size,ColorMap_choice, 'off' ,get(handles.MIP,'value'));
                        Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
                    end
                elseif(eventdata.VerticalScrollCount < 0) 
                    if(get(handles.slider7,'value')<size(PET_PVC.Matrix,3))
                        set(handles.slider7,'value',get(handles.slider7,'value')+1);set(handles.Z_Value,'string',num2str((get(handles.slider7,'Value'))));
                        Z_Value=1+round((get(handles.slider7,'Value')-get(handles.slider7,'Min'))/(get(handles.slider7,'Max')-get(handles.slider7,'Min')+1)...
                            *size(PET_PVC.Matrix,3));
                        X_Value=1+round((get(handles.slider8,'Value')-get(handles.slider8,'Min'))/(get(handles.slider8,'Max')-get(handles.slider8,'Min')+1)...
                            *size(PET_PVC.Matrix,1));
                        Y_Value=1+round((get(handles.slider3,'Value')-get(handles.slider9,'Min'))/(get(handles.slider3,'Max')-get(handles.slider9,'Min')+1)...
                            *size(PET_PVC.Matrix,2));
                        if(get(handles.MRI_togglebutton,'value'))
                            set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
                        elseif(get(handles.PET_togglebutton,'value'))
                            set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                        else
                            try
                                set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                            catch
                            end
                        end
                        display_3view(X_Value, Y_Value, Z_Value, PET_PVC.Matrix,handles.axes7, handles.axes8, handles.axes9, PET_PVC.voxel_size,ColorMap_choice, 'off' ,get(handles.MIP,'value'));
                        Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
                    end
                end
            catch
                errordlg('NO PET_PVC data available, please choose another toggle button! ');
            end
        case handles.axes8
            try
                load PET_PVC_DATA.mat;
                if(eventdata.VerticalScrollCount > 0) 
                    if(get(handles.slider8,'value')>1)
                    set(handles.slider8,'value',get(handles.slider8,'value')-1);set(handles.X_Value,'string',num2str((get(handles.slider8,'Value'))));
                        Z_Value=1+round((get(handles.slider7,'Value')-get(handles.slider7,'Min'))/(get(handles.slider7,'Max')-get(handles.slider7,'Min')+1)...
                            *size(PET_PVC.Matrix,3));
                        X_Value=1+round((get(handles.slider8,'Value')-get(handles.slider8,'Min'))/(get(handles.slider8,'Max')-get(handles.slider8,'Min')+1)...
                            *size(PET_PVC.Matrix,1));
                        Y_Value=1+round((get(handles.slider9,'Value')-get(handles.slider9,'Min'))/(get(handles.slider9,'Max')-get(handles.slider9,'Min')+1)...
                            *size(PET_PVC.Matrix,2));
                        if(get(handles.MRI_togglebutton,'value'))
                            set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
                        elseif(get(handles.PET_togglebutton,'value'))
                            set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                        else
                            try
                                set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                            catch
                            end
                        end
                        display_3view(X_Value, Y_Value, Z_Value, PET_PVC.Matrix,handles.axes7, handles.axes8, handles.axes9, PET_PVC.voxel_size,ColorMap_choice, 'off' ,get(handles.MIP,'value'));
                        Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
                    end
                elseif(eventdata.VerticalScrollCount < 0) 
                    if(get(handles.slider8,'value')<size(PET_PVC.Matrix,1))
                        set(handles.slider8,'value',get(handles.slider8,'value')+1);set(handles.X_Value,'string',num2str((get(handles.slider8,'Value'))));
                        Z_Value=1+round((get(handles.slider7,'Value')-get(handles.slider7,'Min'))/(get(handles.slider7,'Max')-get(handles.slider7,'Min')+1)...
                            *size(PET_PVC.Matrix,3));
                        X_Value=1+round((get(handles.slider8,'Value')-get(handles.slider8,'Min'))/(get(handles.slider8,'Max')-get(handles.slider8,'Min')+1)...
                            *size(PET_PVC.Matrix,1));
                        Y_Value=1+round((get(handles.slider9,'Value')-get(handles.slider9,'Min'))/(get(handles.slider9,'Max')-get(handles.slider9,'Min')+1)...
                            *size(PET_PVC.Matrix,2));
                        if(get(handles.MRI_togglebutton,'value'))
                            set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
                        elseif(get(handles.PET_togglebutton,'value'))
                            set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                        else
                            try
                                set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                            catch
                            end
                        end
                        display_3view(X_Value, Y_Value, Z_Value, PET_PVC.Matrix,handles.axes7, handles.axes8, handles.axes9, PET_PVC.voxel_size,ColorMap_choice, 'off' ,get(handles.MIP,'value'));
                        Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
                    end
                end
            catch
                errordlg('NO PET_PVC data available, please choose another toggle button! ');
            end
        case handles.axes9
            try
                load PET_PVC_DATA.mat;
                if(eventdata.VerticalScrollCount > 0) 
                    if(get(handles.slider9,'value')>1)
                        set(handles.slider9,'value',get(handles.slider9,'value')-1);set(handles.Y_Value,'string',num2str((get(handles.slider9,'Value'))));
                        Z_Value=1+round((get(handles.slider7,'Value')-get(handles.slider7,'Min'))/(get(handles.slider7,'Max')-get(handles.slider7,'Min')+1)...
                            *size(PET_PVC.Matrix,3));
                        X_Value=1+round((get(handles.slider8,'Value')-get(handles.slider8,'Min'))/(get(handles.slider8,'Max')-get(handles.slider8,'Min')+1)...
                            *size(PET_PVC.Matrix,1));
                        Y_Value=1+round((get(handles.slider9,'Value')-get(handles.slider9,'Min'))/(get(handles.slider9,'Max')-get(handles.slider9,'Min')+1)...
                            *size(PET_PVC.Matrix,2));
                        if(get(handles.MRI_togglebutton,'value'))
                            set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
                        elseif(get(handles.PET_togglebutton,'value'))
                            set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                        else
                            try
                                set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                            catch
                            end
                        end
                        display_3view(X_Value, Y_Value, Z_Value, PET_PVC.Matrix,handles.axes7, handles.axes8, handles.axes9, PET_PVC.voxel_size,ColorMap_choice, 'off' ,get(handles.MIP,'value'));
                        Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
                    end
                elseif(eventdata.VerticalScrollCount < 0) 
                    if(get(handles.slider9,'value')<size(PET_PVC.Matrix,2))
                        set(handles.slider9,'value',get(handles.slider9,'value')+1);set(handles.Y_Value,'string',num2str((get(handles.slider9,'Value'))));
                        Z_Value=1+round((get(handles.slider7,'Value')-get(handles.slider7,'Min'))/(get(handles.slider7,'Max')-get(handles.slider7,'Min')+1)...
                            *size(PET_PVC.Matrix,3));
                        X_Value=1+round((get(handles.slider8,'Value')-get(handles.slider8,'Min'))/(get(handles.slider8,'Max')-get(handles.slider8,'Min')+1)...
                            *size(PET_PVC.Matrix,1));
                        Y_Value=1+round((get(handles.slider9,'Value')-get(handles.slider9,'Min'))/(get(handles.slider9,'Max')-get(handles.slider9,'Min')+1)...
                            *size(PET_PVC.Matrix,2));
                        if(get(handles.MRI_togglebutton,'value'))
                            set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
                        elseif(get(handles.PET_togglebutton,'value'))
                            set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                        else
                            try
                                set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                            catch
                            end
                        end
                        display_3view(X_Value, Y_Value, Z_Value, PET_PVC.Matrix,handles.axes7, handles.axes8, handles.axes9, PET_PVC.voxel_size,ColorMap_choice, 'off' ,get(handles.MIP,'value'));
                        Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
                    end
                end
            catch
                errordlg('NO PET_PVC data available, please choose another toggle button! ');
            end
    end



% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
load MRI_DATA.mat;
Z_Value=1+round((get(handles.slider1,'Value')-get(handles.slider1,'Min'))/(1+get(handles.slider1,'Max')-get(handles.slider1,'Min'))...
    *size(MRI.Matrix,3));
set(handles.slider1,'value',Z_Value);
set(handles.Z_Value,'string',num2str(Z_Value));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X_Value=1+round((get(handles.slider2,'Value')-get(handles.slider2,'Min'))/(1+get(handles.slider2,'Max')-get(handles.slider2,'Min'))...
    *size(MRI.Matrix,1));
Y_Value=1+round((get(handles.slider3,'Value')-get(handles.slider3,'Min'))/(1+get(handles.slider3,'Max')-get(handles.slider3,'Min'))...
    *size(MRI.Matrix,2));

if(get(handles.MRI_togglebutton,'value'))
    set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
elseif(get(handles.PET_togglebutton,'value'))
    set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
else
    try
        set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
    catch
    end
end
set(handles.X_Value,'string',num2str(X_Value));
set(handles.Y_Value,'string',num2str(Y_Value));


ColorMap_choice = get(handles.Color_Map,'String');
ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
cross_tag=strcmp(get(handles.Data_Cursor,'state'),'off');cross_tag=1;
display_3view(X_Value, Y_Value, Z_Value, MRI.Matrix,handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
load MRI_DATA.mat;
X_Value=1+round((get(handles.slider2,'Value')-get(handles.slider2,'Min'))/(1+get(handles.slider2,'Max')-get(handles.slider2,'Min'))...
    *size(MRI.Matrix,1));
set(handles.slider2,'value',X_Value);
set(handles.X_Value,'string',num2str(X_Value));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Y_Value=1+round((get(handles.slider3,'Value')-get(handles.slider3,'Min'))/(1+get(handles.slider3,'Max')-get(handles.slider3,'Min'))...
    *size(MRI.Matrix,2));
Z_Value=1+round((get(handles.slider1,'Value')-get(handles.slider1,'Min'))/(1+get(handles.slider1,'Max')-get(handles.slider1,'Min'))...
    *size(MRI.Matrix,3));


if(get(handles.MRI_togglebutton,'value'))
    set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
elseif(get(handles.PET_togglebutton,'value'))
    set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
else
    try
        set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
    catch
    end
end
set(handles.Y_Value,'string',num2str(Y_Value));
set(handles.Z_Value,'string',num2str(Z_Value));



ColorMap_choice = get(handles.Color_Map,'String');
ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
cross_tag=strcmp(get(handles.Data_Cursor,'state'),'off');cross_tag=1;
display_3view(X_Value, Y_Value, Z_Value, MRI.Matrix,handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );



% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
load MRI_DATA.mat;
Y_Value=1+round((get(handles.slider3,'Value')-get(handles.slider3,'Min'))/(1+get(handles.slider3,'Max')-get(handles.slider3,'Min'))...
    *size(MRI.Matrix,2));
set(handles.slider3,'value',Y_Value);
set(handles.Y_Value,'string',num2str(Y_Value));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
Z_Value=1+round((get(handles.slider1,'Value')-get(handles.slider1,'Min'))/(1+get(handles.slider1,'Max')-get(handles.slider1,'Min'))...
    *size(MRI.Matrix,3));
X_Value=1+round((get(handles.slider2,'Value')-get(handles.slider2,'Min'))/(1+get(handles.slider2,'Max')-get(handles.slider2,'Min'))...
    *size(MRI.Matrix,1));
set(handles.X_Value,'string',num2str(X_Value));

set(handles.Z_Value,'string',num2str(Z_Value));



if(get(handles.MRI_togglebutton,'value'))
    set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
elseif(get(handles.PET_togglebutton,'value'))
    set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
else
    try
        set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
    catch
    end
end
ColorMap_choice = get(handles.Color_Map,'String');
ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
cross_tag=strcmp(get(handles.Data_Cursor,'state'),'off');cross_tag=1;
display_3view(X_Value, Y_Value, Z_Value, MRI.Matrix,handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
try
load PET_DATA_After_R.mat;
catch
    load PET_DATA;
end
Z_Value=1+round((get(handles.slider4,'Value')-get(handles.slider4,'Min'))/(1+get(handles.slider4,'Max')-get(handles.slider4,'Min'))...
    *size(PET.Matrix,3));
set(handles.slider4,'value',Z_Value);
set(handles.Z_Value,'string',num2str(Z_Value));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X_Value=1+round((get(handles.slider5,'Value')-get(handles.slider5,'Min'))/(1+get(handles.slider5,'Max')-get(handles.slider5,'Min'))...
    *size(PET.Matrix,1));
Y_Value=1+round((get(handles.slider6,'Value')-get(handles.slider6,'Min'))/(1+get(handles.slider6,'Max')-get(handles.slider6,'Min'))...
    *size(PET.Matrix,2));



if(get(handles.MRI_togglebutton,'value'))
    set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
elseif(get(handles.PET_togglebutton,'value'))
    set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
else
    try
        set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
    catch
    end
end
set(handles.X_Value,'string',num2str(X_Value));
set(handles.Y_Value,'string',num2str(Y_Value));




ColorMap_choice = get(handles.Color_Map,'String');
ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
cross_tag=strcmp(get(handles.Data_Cursor,'state'),'off');cross_tag=1;
display_3view(X_Value, Y_Value, Z_Value, PET.Matrix, handles.axes4, handles.axes5, handles.axes6, PET.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)   
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
try
load PET_DATA_After_R.mat;
catch
    load PET_DATA;
end
X_Value=1+round((get(handles.slider5,'Value')-get(handles.slider5,'Min'))/(1+get(handles.slider5,'Max')-get(handles.slider5,'Min'))...
    *size(PET.Matrix,1));
set(handles.slider5,'value',X_Value);
set(handles.X_Value,'string',num2str(X_Value));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Y_Value=1+round((get(handles.slider6,'Value')-get(handles.slider6,'Min'))/(1+get(handles.slider6,'Max')-get(handles.slider6,'Min'))...
    *size(PET.Matrix,2));

Z_Value=1+round((get(handles.slider4,'Value')-get(handles.slider4,'Min'))/(1+get(handles.slider4,'Max')-get(handles.slider4,'Min'))...
    *size(PET.Matrix,3));


if(get(handles.MRI_togglebutton,'value'))
    set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
elseif(get(handles.PET_togglebutton,'value'))
    set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
else
    try
        set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
    catch
    end
end
set(handles.Y_Value,'string',num2str(Y_Value));
set(handles.Z_Value,'string',num2str(Z_Value));



ColorMap_choice = get(handles.Color_Map,'String');
ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
cross_tag=strcmp(get(handles.Data_Cursor,'state'),'off');cross_tag=1;
display_3view(X_Value, Y_Value, Z_Value, PET.Matrix, handles.axes4, handles.axes5, handles.axes6, PET.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );

% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
try
load PET_DATA_After_R.mat;
catch
    load PET_DATA;
end
Y_Value=1+round((get(handles.slider6,'Value')-get(handles.slider6,'Min'))/(1+get(handles.slider6,'Max')-get(handles.slider6,'Min'))...
    *size(PET.Matrix,2));
set(handles.slider6,'value',Y_Value);
set(handles.Y_Value,'string',num2str(Y_Value));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Z_Value=1+round((get(handles.slider4,'Value')-get(handles.slider4,'Min'))/(1+get(handles.slider4,'Max')-get(handles.slider4,'Min'))...
    *size(PET.Matrix,3));
X_Value=1+round((get(handles.slider5,'Value')-get(handles.slider5,'Min'))/(1+get(handles.slider5,'Max')-get(handles.slider5,'Min'))...
    *size(PET.Matrix,1));
set(handles.X_Value,'string',num2str(X_Value));

set(handles.Z_Value,'string',num2str(Z_Value));


if(get(handles.MRI_togglebutton,'value'))
    set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
elseif(get(handles.PET_togglebutton,'value'))
    set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
else
    try
        set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
    catch
    end
end

ColorMap_choice = get(handles.Color_Map,'String');
ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
cross_tag=strcmp(get(handles.Data_Cursor,'state'),'off');cross_tag=1;
display_3view(X_Value, Y_Value, Z_Value, PET.Matrix, handles.axes4, handles.axes5, handles.axes6, PET.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );

% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
load PET_PVC_DATA.mat;
Z_Value=1+round((get(handles.slider7,'Value')-get(handles.slider7,'Min'))/(1+get(handles.slider7,'Max')-get(handles.slider7,'Min'))...
    *size(PET_PVC.Matrix,3));
set(handles.slider7,'value',Z_Value);
set(handles.Z_Value,'string',num2str(Z_Value));
%%show the figure!!!!!! This part need revise!!!!!!!!!!!!!!!!!!! 
X_Value=1+round((get(handles.slider8,'Value')-get(handles.slider8,'Min'))/(1+get(handles.slider8,'Max')-get(handles.slider8,'Min'))...
    *size(PET_PVC.Matrix,1));
Y_Value=1+round((get(handles.slider9,'Value')-get(handles.slider9,'Min'))/(1+get(handles.slider9,'Max')-get(handles.slider9,'Min'))...
    *size(PET_PVC.Matrix,2));

set(handles.X_Value,'string',num2str(X_Value));
set(handles.Y_Value,'string',num2str(Y_Value));



if(get(handles.MRI_togglebutton,'value'))
    set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
elseif(get(handles.PET_togglebutton,'value'))
    set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
else
    try
        set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
    catch
    end
end

ColorMap_choice = get(handles.Color_Map,'String');
ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
cross_tag=strcmp(get(handles.Data_Cursor,'state'),'off');cross_tag=1;
display_3view(X_Value, Y_Value, Z_Value, PET_PVC.Matrix,handles.axes7, handles.axes8, handles.axes9, PET_PVC.voxel_size,ColorMap_choice,cross_tag ,get(handles.MIP,'value'));
Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );

% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
load PET_PVC_DATA.mat;

X_Value=1+round((get(handles.slider8,'Value')-get(handles.slider8,'Min'))/(1+get(handles.slider8,'Max')-get(handles.slider8,'Min'))...
    *size(PET_PVC.Matrix,1));
set(handles.slider8,'value',X_Value);
set(handles.X_Value,'string',num2str(X_Value));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Z_Value=1+round((get(handles.slider7,'Value')-get(handles.slider7,'Min'))/(1+get(handles.slider7,'Max')-get(handles.slider7,'Min'))...
    *size(PET_PVC.Matrix,3));
Y_Value=1+round((get(handles.slider9,'Value')-get(handles.slider9,'Min'))/(1+get(handles.slider9,'Max')-get(handles.slider9,'Min'))...
    *size(PET_PVC.Matrix,2));


if(get(handles.MRI_togglebutton,'value'))
    set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
elseif(get(handles.PET_togglebutton,'value'))
    set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
else
    try
        set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
    catch
    end
end

set(handles.Y_Value,'string',num2str(Y_Value));
set(handles.Z_Value,'string',num2str(Z_Value));



ColorMap_choice = get(handles.Color_Map,'String');
ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
cross_tag=strcmp(get(handles.Data_Cursor,'state'),'off');cross_tag=1;
display_3view(X_Value, Y_Value, Z_Value, PET_PVC.Matrix,handles.axes7, handles.axes8, handles.axes9, PET_PVC.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );

% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
load PET_PVC_DATA.mat;
Y_Value=1+round((get(handles.slider9,'Value')-get(handles.slider9,'Min'))/(1+get(handles.slider9,'Max')-get(handles.slider9,'Min'))...
    *size(PET_PVC.Matrix,2));
set(handles.slider9,'value',Y_Value);
set(handles.Y_Value,'string',num2str(Y_Value));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Z_Value=1+round((get(handles.slider7,'Value')-get(handles.slider7,'Min'))/(1+get(handles.slider7,'Max')-get(handles.slider7,'Min'))...
    *size(PET_PVC.Matrix,3));
X_Value=1+round((get(handles.slider8,'Value')-get(handles.slider8,'Min'))/(1+get(handles.slider8,'Max')-get(handles.slider8,'Min'))...
    *size(PET_PVC.Matrix,1));
set(handles.X_Value,'string',num2str(X_Value));

set(handles.Z_Value,'string',num2str(Z_Value));


if(get(handles.MRI_togglebutton,'value'))
    set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
elseif(get(handles.PET_togglebutton,'value'))
    set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
else
    try
        set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
    catch
    end
end

ColorMap_choice = get(handles.Color_Map,'String');
ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
cross_tag=strcmp(get(handles.Data_Cursor,'state'),'off');cross_tag=1;
display_3view(X_Value, Y_Value, Z_Value, PET_PVC.Matrix,handles.axes7, handles.axes8, handles.axes9, PET_PVC.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );

% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global current_axes;
if(~(strcmp(get(handles.Zoom_In,'state'),'on')||...
                    strcmp(get(handles.Zoom_Out,'state'),'on')||...
                    strcmp(get(handles.Pan,'state'),'on')||...
                    strcmp(get(handles.Data_Cursor,'state'),'on')))%%%judge whether use this buttondown function
    
    current_axes=gca; 
    clim=get(gca,'CLim');
    set(handles.Gray_Scale1,'value',clim(1));%%set the current gray_scale corresponding to the current axes
    set(handles.Gray_Scale2,'value',clim(2)); 
    
    
    CP=get(gca,'currentpoint');CP=CP(1,:);%get current point in the axis
    cross_tag=strcmp(get(handles.Data_Cursor,'state'),'off');cross_tag=1;
    %%if in the panel1
    if(gca==handles.axes1)
        load MRI_DATA  
        X_Value=round(CP(1,2)/MRI.voxel_size(1))+1;
        Y_Value=round(CP(1,1)/MRI.voxel_size(2))+1;
        Z_Value=round(str2double(get(handles.Z_Value,'string')));
        
        if(X_Value>=1&&X_Value<=size(MRI.Matrix,1)&&Y_Value>=1&&Y_Value<=size(MRI.Matrix,2)&&Z_Value>=1&&Z_Value<=size(MRI.Matrix,3))
            %judge whether in/out of the image
            set(handles.X_Value,'string',num2str(X_Value));set(handles.Y_Value,'string',num2str(Y_Value));
            set(handles.slider1,'value',str2double(get(handles.Z_Value,'string')));
            set(handles.slider2,'value',str2double(get(handles.X_Value,'string')));
            set(handles.slider3,'value',str2double(get(handles.Y_Value,'string')));
            ColorMap_choice = get(handles.Color_Map,'String');
            ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
            display_3view(X_Value, Y_Value, Z_Value, MRI.Matrix,handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
            Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
            %may need revise
            if(get(handles.MRI_togglebutton,'value'))
                set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
            elseif(get(handles.PET_togglebutton,'value'))
                set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
            else
                try
                    set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                catch
                end
            end
        end
    elseif(gca==handles.axes2)
        load MRI_DATA
        X_Value=round(str2double(get(handles.X_Value,'string')));
        Y_Value=round(CP(1,1)/MRI.voxel_size(2))+1;
        Z_Value=size(MRI.Matrix,3)-round(CP(1,2)/MRI.voxel_size(3));
        
        if(X_Value>=1&&X_Value<=size(MRI.Matrix,1)&&Y_Value>=1&&Y_Value<=size(MRI.Matrix,2)&&Z_Value>=1&&Z_Value<=size(MRI.Matrix,3))
            %judge whether in/out of the image
            set(handles.Y_Value,'string',num2str(Y_Value));set(handles.Z_Value,'string',num2str(Z_Value));
            set(handles.slider1,'value',str2double(get(handles.Z_Value,'string')));
            set(handles.slider2,'value',str2double(get(handles.X_Value,'string')));
            set(handles.slider3,'value',str2double(get(handles.Y_Value,'string')));
            ColorMap_choice = get(handles.Color_Map,'String');
            ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
            display_3view(X_Value, Y_Value, Z_Value, MRI.Matrix,handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
            Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
            %may need revise
            if(get(handles.MRI_togglebutton,'value'))
                set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
            elseif(get(handles.PET_togglebutton,'value'))
                set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
            else
                try
                    set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                catch
                end
            end
        end
    elseif(gca==handles.axes3)
        load MRI_DATA
        X_Value=round(CP(1,1)/MRI.voxel_size(1))+1;
        Y_Value=round(str2double(get(handles.Y_Value,'string')));
        Z_Value=size(MRI.Matrix,3)-round(CP(1,2)/MRI.voxel_size(3));

        if(X_Value>=1&&X_Value<=size(MRI.Matrix,1)&&Y_Value>=1&&Y_Value<=size(MRI.Matrix,2)&&Z_Value>=1&&Z_Value<=size(MRI.Matrix,3))
            %judge whether in/out of the image
            set(handles.X_Value,'string',num2str(X_Value));set(handles.Z_Value,'string',num2str(Z_Value));
            set(handles.slider1,'value',str2double(get(handles.Z_Value,'string')));
            set(handles.slider2,'value',str2double(get(handles.X_Value,'string')));
            set(handles.slider3,'value',str2double(get(handles.Y_Value,'string')));
            ColorMap_choice = get(handles.Color_Map,'String');
            ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
            display_3view(X_Value, Y_Value, Z_Value, MRI.Matrix,handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value')); 
            Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
            if(get(handles.MRI_togglebutton,'value'))
                set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
            elseif(get(handles.PET_togglebutton,'value'))
                set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
            else
                try
                    set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                catch
                end
            end
        end
    end

    %%if in the panel2
    if(gca==handles.axes4)
        try
        load PET_DATA_After_R
        catch
            load PET_DATA;
        end
        X_Value=round(CP(1,2)/PET.voxel_size(1))+1;
        Y_Value=round(CP(1,1)/PET.voxel_size(2))+1;
        Z_Value=round(str2double(get(handles.Z_Value,'string')));
        
        if(X_Value>=1&&X_Value<=size(PET.Matrix,1)&&Y_Value>=1&&Y_Value<=size(PET.Matrix,2)&&Z_Value>=1&&Z_Value<=size(PET.Matrix,3))
            %judge whether in/out of the image
            set(handles.X_Value,'string',num2str(X_Value));set(handles.Y_Value,'string',num2str(Y_Value));
            set(handles.slider4,'value',str2double(get(handles.Z_Value,'string')));
            set(handles.slider5,'value',str2double(get(handles.X_Value,'string')));
            set(handles.slider6,'value',str2double(get(handles.Y_Value,'string')));
            ColorMap_choice = get(handles.Color_Map,'String');
            ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
            display_3view(X_Value, Y_Value, Z_Value, PET.Matrix,handles.axes4, handles.axes5, handles.axes6, PET.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
            Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
            if(get(handles.MRI_togglebutton,'value'))
                set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
            elseif(get(handles.PET_togglebutton,'value'))
                set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
            else
                try
                    set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                catch
                end
            end
        end
    elseif(gca==handles.axes5)
        try
        load PET_DATA_After_R
        catch
            load PET_DATA
        end;
        X_Value=round(str2double(get(handles.X_Value,'string')));
        Y_Value=round(CP(1,1)/PET.voxel_size(2))+1;
        Z_Value=size(PET.Matrix,3)-round(CP(1,2)/PET.voxel_size(3));
        
        if(X_Value>=1&&X_Value<=size(PET.Matrix,1)&&Y_Value>=1&&Y_Value<=size(PET.Matrix,2)&&Z_Value>=1&&Z_Value<=size(PET.Matrix,3))
            %judge whether in/out of the image
            set(handles.Y_Value,'string',num2str(Y_Value));set(handles.Z_Value,'string',num2str(Z_Value));
            set(handles.slider4,'value',str2double(get(handles.Z_Value,'string')));
            set(handles.slider5,'value',str2double(get(handles.X_Value,'string')));
            set(handles.slider6,'value',str2double(get(handles.Y_Value,'string')));
            ColorMap_choice = get(handles.Color_Map,'String');
            ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
            display_3view(X_Value, Y_Value, Z_Value, PET.Matrix,handles.axes4, handles.axes5, handles.axes6, PET.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
            Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
            if(get(handles.MRI_togglebutton,'value'))
                set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
            elseif(get(handles.PET_togglebutton,'value'))
                set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
            else
                try
                    set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                catch
                end
            end
        end
    elseif(gca==handles.axes6)
        try
        load PET_DATA_After_R
        catch
            load PET_DATA;
        end
        X_Value=round(CP(1,1)/PET.voxel_size(1))+1;
        Y_Value=round(str2double(get(handles.Y_Value,'string')));
        Z_Value=size(PET.Matrix,3)-round(CP(1,2)/PET.voxel_size(3));
        
        if(X_Value>=1&&X_Value<=size(PET.Matrix,1)&&Y_Value>=1&&Y_Value<=size(PET.Matrix,2)&&Z_Value>=1&&Z_Value<=size(PET.Matrix,3))
            %judge whether in/out of the image
            set(handles.X_Value,'string',num2str(X_Value));set(handles.Z_Value,'string',num2str(Z_Value));
            set(handles.slider4,'value',str2double(get(handles.Z_Value,'string')));
            set(handles.slider5,'value',str2double(get(handles.X_Value,'string')));
            set(handles.slider6,'value',str2double(get(handles.Y_Value,'string')));
            ColorMap_choice = get(handles.Color_Map,'String');
            ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
            display_3view(X_Value, Y_Value, Z_Value, PET.Matrix,handles.axes4, handles.axes5, handles.axes6, PET.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value')); 
            Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
            if(get(handles.MRI_togglebutton,'value'))
                set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
            elseif(get(handles.PET_togglebutton,'value'))
                set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
            else
                try
                    set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                catch
                end
            end
        end
    end

    %%if in the panel3
    if(gca==handles.axes7)
        try
            load PET_PVC_DATA
            X_Value=round(CP(1,2)/PET_PVC.voxel_size(1))+1;
            Y_Value=round(CP(1,1)/PET_PVC.voxel_size(2))+1;
            Z_Value=round(str2double(get(handles.Z_Value,'string')));
            
            if(X_Value>=1&&X_Value<=size(PET_PVC.Matrix,1)&&Y_Value>=1&&Y_Value<=size(PET_PVC.Matrix,2)&&Z_Value>=1&&Z_Value<=size(PET_PVC.Matrix,3))
                %judge whether in/out of the image
                set(handles.X_Value,'string',num2str(X_Value));set(handles.Y_Value,'string',num2str(Y_Value));
                set(handles.slider7,'value',str2double(get(handles.Z_Value,'string')));
                set(handles.slider8,'value',str2double(get(handles.X_Value,'string')));
                set(handles.slider9,'value',str2double(get(handles.Y_Value,'string')));
                ColorMap_choice = get(handles.Color_Map,'String');
                ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
                display_3view(X_Value, Y_Value, Z_Value, PET_PVC.Matrix,handles.axes7, handles.axes8, handles.axes9, PET_PVC.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
                Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
                if(get(handles.MRI_togglebutton,'value'))
                    set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
                elseif(get(handles.PET_togglebutton,'value'))
                    set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                else
                    try
                        set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET_PVC.info.LargestImagePixelValue-PET_PVC.info.SmallestImagePixelValue)+PET_PVC.info.SmallestImagePixelValue));
                    catch
                    end
                end
            end
        catch
            errordlg('NO PET_PVC data available, please choose another toggle button! ');
        end
    elseif(gca==handles.axes8)
        try
            load PET_PVC_DATA
            X_Value=round(str2double(get(handles.X_Value,'string')));
            Y_Value=round(CP(1,1)/PET_PVC.voxel_size(2))+1;
            Z_Value=size(PET_PVC.Matrix,3)-round(CP(1,2)/PET_PVC.voxel_size(3));
            
            if(X_Value>=1&&X_Value<=size(PET_PVC.Matrix,1)&&Y_Value>=1&&Y_Value<=size(PET_PVC.Matrix,2)&&Z_Value>=1&&Z_Value<=size(PET_PVC.Matrix,3))
                %judge whether in/out of the image
                set(handles.Y_Value,'string',num2str(Y_Value));set(handles.Z_Value,'string',num2str(Z_Value));
                set(handles.slider7,'value',str2double(get(handles.Z_Value,'string')));
                set(handles.slider8,'value',str2double(get(handles.X_Value,'string')));
                set(handles.slider9,'value',str2double(get(handles.Y_Value,'string')));
                ColorMap_choice = get(handles.Color_Map,'String');
                ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
                display_3view(X_Value, Y_Value, Z_Value, PET_PVC.Matrix,handles.axes7, handles.axes8, handles.axes9, PET_PVC.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
                Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
                if(get(handles.MRI_togglebutton,'value'))
                    set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
                elseif(get(handles.PET_togglebutton,'value'))
                    set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                else
                    try
                        set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                    catch
                    end
                end
            end
        catch
            errordlg('NO PET_PVC data available, please choose another toggle button! ');
        end
    elseif(gca==handles.axes9)
        try
            load PET_PVC_DATA
            X_Value=round(CP(1,1)/PET_PVC.voxel_size(1))+1;
            Y_Value=round(str2double(get(handles.Y_Value,'string')));
            Z_Value=size(PET_PVC.Matrix,3)-round(CP(1,2)/PET_PVC.voxel_size(3));
            
            if(X_Value>=1&&X_Value<=size(PET_PVC.Matrix,1)&&Y_Value>=1&&Y_Value<=size(PET_PVC.Matrix,2)&&Z_Value>=1&&Z_Value<=size(PET_PVC.Matrix,3))
                %judge whether in/out of the image
                set(handles.X_Value,'string',num2str(X_Value));set(handles.Z_Value,'string',num2str(Z_Value));
                set(handles.slider7,'value',str2double(get(handles.Z_Value,'string')));
                set(handles.slider8,'value',str2double(get(handles.X_Value,'string')));
                set(handles.slider9,'value',str2double(get(handles.Y_Value,'string')));
                ColorMap_choice = get(handles.Color_Map,'String');
                ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
                display_3view(X_Value, Y_Value, Z_Value, PET_PVC.Matrix,handles.axes7, handles.axes8, handles.axes9, PET_PVC.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value')); 
                Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
                if(get(handles.MRI_togglebutton,'value'))
                    set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
                elseif(get(handles.PET_togglebutton,'value'))
                    set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                else
                    try
                        set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
                    catch
                    end
                end
            end
        catch
            errordlg('NO PET_PVC data available, please choose another toggle button! ');
        end
    end

end


    
% --- Executes on selection change in Color_Map.
function Color_Map_Callback(hObject, eventdata, handles)
% hObject    handle to Color_Map (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Color_Map contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Color_Map
if(~strcmp(get(handles.X_Value,'string'),''))
    X_Value=round(str2double(get(handles.X_Value,'string')));set(handles.X_Value,'string',num2str(X_Value));
    Y_Value=round(str2double(get(handles.Y_Value,'string')));set(handles.Y_Value,'string',num2str(Y_Value));
    Z_Value=round(str2double(get(handles.Z_Value,'string')));set(handles.Z_Value,'string',num2str(Z_Value));
    ColorMap_choice = get(handles.Color_Map,'String');
    ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
    cross_tag=strcmp(get(handles.Data_Cursor,'state'),'off');cross_tag=1;
    if(get(handles.MRI_togglebutton,'value'))
    load MRI_DATA.mat;  
    display_3view(X_Value, Y_Value, Z_Value, MRI.Matrix,handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
    
    set(handles.slider1,'value',str2double(get(handles.Z_Value,'string')));
    set(handles.slider2,'value',str2double(get(handles.X_Value,'string')));
    set(handles.slider3,'value',str2double(get(handles.Y_Value,'string')));
    elseif(get(handles.PET_togglebutton,'value'))
        try
            load PET_DATA_After_R.mat;
        catch
            load PET_DATA
        end
    display_3view(X_Value, Y_Value, Z_Value, PET.Matrix,handles.axes4, handles.axes5, handles.axes6, PET.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
    
    set(handles.slider4,'value',str2double(get(handles.Z_Value,'string')));
    set(handles.slider5,'value',str2double(get(handles.X_Value,'string')));
    set(handles.slider6,'value',str2double(get(handles.Y_Value,'string')));
    elseif(get(handles.PET_PVC_togglebutton,'value'))
        try
            load PET_PVC_DATA.mat;
            display_3view(X_Value, Y_Value, Z_Value, PET_PVC.Matrix,handles.axes7, handles.axes8, handles.axes9, PET_PVC.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
            Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
            
            set(handles.slider7,'value',str2double(get(handles.Z_Value,'string')));
            set(handles.slider8,'value',str2double(get(handles.X_Value,'string')));
            set(handles.slider9,'value',str2double(get(handles.Y_Value,'string')));
        catch
            errordlg('NO PET_PVC data available, please choose another toggle button! ');
        end
    end
end


% --- Executes on slider movement.
function Gray_Scale1_Callback(hObject, eventdata, handles)
% hObject    handle to Gray_Scale1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global current_axes;
if(ishandle(gca))
    if(get(handles.MRI_togglebutton,'value'))
        if(~(current_axes==handles.axes1||current_axes==handles.axes2||current_axes==handles.axes3))
            current_axes=handles.axes1;
        end
    end

    if(get(handles.PET_togglebutton,'value'))
        if(~(current_axes==handles.axes4||current_axes==handles.axes5||current_axes==handles.axes6))
            current_axes=handles.axes4;
        end
    end

    if(get(handles.PET_PVC_togglebutton,'value'))
        if(~(current_axes==handles.axes7||current_axes==handles.axes8||current_axes==handles.axes9))
            current_axes=handles.axes7;
        end
    end
    
    set(current_axes,'CLim',[get(handles.Gray_Scale1,'Value'),get(handles.Gray_Scale2,'Value')]);
end

% --- Executes during object creation, after setting all properties.
function Gray_Scale1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Gray_Scale1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function Gray_Scale2_Callback(hObject, eventdata, handles)
% hObject    handle to Gray_Scale2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global current_axes;
if(ishandle(gca))
    if(get(handles.MRI_togglebutton,'value'))
        if(~(current_axes==handles.axes1||current_axes==handles.axes2||current_axes==handles.axes3))
            current_axes=handles.axes1;
        end
    end

    if(get(handles.PET_togglebutton,'value'))
        if(~(current_axes==handles.axes4||current_axes==handles.axes5||current_axes==handles.axes6))
            current_axes=handles.axes4;
        end
    end

    if(get(handles.PET_PVC_togglebutton,'value'))
        if(~(current_axes==handles.axes7||current_axes==handles.axes8||current_axes==handles.axes9))
            current_axes=handles.axes7;
        end
    end
    
    set(current_axes,'CLim',[get(handles.Gray_Scale1,'Value'),get(handles.Gray_Scale2,'Value')]);
end


% --- Executes during object creation, after setting all properties.
function Gray_Scale2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Gray_Scale2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%Judge where the cursor is!
CP = get (gcf, 'CurrentPoint');
L1=get(handles.Displaypanel,'position');
L2=get(handles.ToggleBtnPanel,'position');
if(CP(1)>L1(1)&&CP(1)<1&&CP(2)>L1(2)&&CP(2)<1)
    if(CP(1)>L1(1)&&CP(1)<1&&CP(2)>L1(2)&&CP(2)<1*L2(2))
        if ((CP(1)-L1(1)>L1(3)*(1/3-0.02)&&CP(1)-L1(1)<L1(3)*1/3)||...
                (CP(1)-L1(1)>L1(3)*(2/3-0.02)&&CP(1)-L1(1)<L1(3)*2/3)||...
                (CP(1)-L1(1)>L1(3)*(3/3-0.02)&&CP(1)-L1(1)<L1(3)*3/3))
            set(gcf,'pointer','arrow');
        else
            if(~(strcmp(get(handles.Zoom_In,'state'),'on')||...
                    strcmp(get(handles.Zoom_Out,'state'),'on')||...
                    strcmp(get(handles.Pan,'state'),'on'))||...
                    strcmp(get(handles.Data_Cursor,'state'),'on'))
                set(gcf,'pointer','cross');
            end
        end
    else
        set(gcf,'pointer','arrow');
    end
end

if(~(CP(1)>L1(1)&&CP(1)<1&&CP(2)>L1(2)&&CP(2)<1))
    set(gcf,'pointer','arrow');
end
% set(handles.message,'string',num2str(C));


% --- Executes on button press in JE_Perior.
function JE_Perior_Callback(hObject, eventdata, handles)
% hObject    handle to JE_Perior (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of JE_Perior
if(~get(handles.JE_Perior,'value'))
    set(handles.Reg_Par,'string','0');
else
    try
        load PET_DATA_After_R.mat;
    catch
        load PET_DATA;
    end
    load MRI_DATA.mat;
    %%THIS IS THE DATASET
    Scaner_choice = get(handles.Scaner_Input,'String');
    Scaner_choice = Scaner_choice(get(handles.Scaner_Input,'value'),:); 
    if (strcmp(Scaner_choice,'Scaner 1'))
        load blurinterp.mat%%need the dataset
    else 
        errordlg('wrong input fro PSF');
    end
    %%further revise from here
    sigscale_x=str2double(get(handles.Sig_PET,'string'));
    sigscale_y=str2double(get(handles.Sig_MRI,'string'));
    EPS = 1e-8;params.EPS=EPS;
    params.H=H;
    params.D=D;
    params.sizex=size(PET.Matrix);
    temp=zeros(size(PET.Matrix));
    temp(PET.Matrix>0)=1;
    temp=imfill(temp);
    params.mask=zeros(size(PET.Matrix));
    params.mask(temp>0.02)=1;    

    sig_y=max(PET.Matrix(:))/sigscale_y; 
    params.sig_x=max(PET.Matrix(:))/sigscale_x;
    M = max(size(PET.Matrix))*3+1;%pdf sample number
    params.M=M;    
    params.imy = initanat(MRI.Matrix*max(PET.Matrix(:))/max(MRI.Matrix(:)),M,sig_y,EPS,params.mask);
    params.imx = initanat(PET.Matrix,M,params.sig_x,EPS,params.mask);
    
    h_temp1=mydialog('Please wait for computing the regulation parameter!',0); 
    g1 = reshape(bckprojH(fwdprojH(PET.Matrix,params),params) - bckprojH(PET.Matrix,params),params.sizex);
    g2=reshape(gradanat(PET.Matrix,params),params.sizex);
    
    set(handles.Reg_Par,'string',num2str(max(g1(:))/max(g2(:))));

    h_temp2=mydialog('Finished, please press the run button or change the regulation parameter by yourself!',0); 

end




% --------------------------------------------------------------------
function Data_Cursor_OnCallback(hObject, eventdata, handles)
% hObject    handle to Data_Cursor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    load MRI_DATA.mat;
    try
        load PET_DATA_After_R.mat;
    catch
        load PET_DATA;
    end
catch
end
global current_axes
if(gca==handles.axes1||gca==handles.axes2||gca==handles.axes3)
    current_axes=handles.axes1;
    axes(current_axes);
elseif(gca==handles.axes4||gca==handles.axes5||gca==handles.axes6)
    current_axes=handles.axes4;
    axes(current_axes);
else
    current_axes=handles.axes7;
    axes(current_axes);
end
try
    
    X_Value=round(str2double(get(handles.X_Value,'string')));set(handles.X_Value,'string',num2str(X_Value));
    Y_Value=round(str2double(get(handles.Y_Value,'string')));set(handles.Y_Value,'string',num2str(Y_Value));
    Z_Value=round(str2double(get(handles.Z_Value,'string')));set(handles.Z_Value,'string',num2str(Z_Value));

    
    if(get(handles.MRI_togglebutton,'value'))
        set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
    elseif(get(handles.PET_togglebutton,'value'))
        set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
    else
        try
            set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
            
        catch
        end
    end
    ColorMap_choice = get(handles.Color_Map,'String');
    ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
    cross_tag=strcmp(get(handles.Data_Cursor,'state'),'off');cross_tag=1;
    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
    display_3view(X_Value, Y_Value, Z_Value, MRI.Matrix,handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
    display_3view(X_Value, Y_Value, Z_Value, PET.Matrix,handles.axes4, handles.axes5, handles.axes6, PET.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
    
    try
        display_3view(X_Value, Y_Value, Z_Value, PET.Matrix,handles.axes7, handles.axes8, handles.axes9, PET.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
    catch
    end
    mydialog('Please draw the ROI in the transaxial view.',1); 

    
    h1 = impoly(current_axes);
    BW = createMask(h1);
    if(gca==handles.axes1)
        mydialog('Please draw the Depth of ROI in the vertical direction of the coronal view.',1); 
        h2=imline(handles.axes2);
        pos = getPosition(h2); 
        pos=sort(round(pos(:,2)/MRI.voxel_size(3))+1);
        ROI=zeros(size(MRI.Matrix));
        for ii=max(1,pos(1)):min(size(MRI.Matrix,3),pos(2))
            ROI(:,:,size(MRI.Matrix,3)-ii+1)=BW;
        end
        ROI=MRI.Matrix.*ROI*double(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+double(MRI.info.SmallestImagePixelValue);
        save([MRI.dir,'/MRI_ROI',datestr(now,30)],'BW','pos','ROI');
        set(handles.Data_Cursor,'state','off');
    end
    
    if(gca==handles.axes4)
        mydialog('Please draw the Depth of ROI in the vertical direction of the coronal view.',1); 
        h2=imline(handles.axes5);
        pos = getPosition(h2); 
        pos=sort(round(pos(:,2)/MRI.voxel_size(3))+1);
        ROI=zeros(size(PET.Matrix));
        for ii=max(1,pos(1)):min(size(PET.Matrix,3),pos(2))
            ROI(:,:,size(PET.Matrix,3)-ii+1)=BW;
        end
        ROI=PET.Matrix.*ROI*double(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+double(PET.info.SmallestImagePixelValue);
        save([PET.dir,'/PET_ROI',datestr(now,30)],'BW','pos','ROI');
        set(handles.Data_Cursor,'state','off');
    end
    try 
        load PET_PVC_DATA.mat
        display_3view(X_Value, Y_Value, Z_Value, PET_PVC.Matrix,handles.axes7, handles.axes8, handles.axes9, PET_PVC.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
        Slider_Visible(handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
        if(gca==handles.axes7)
            mydialog('Please draw the Depth of ROI in the vertical direction of the coronal view.',1); 
            h2=imline(handles.axes8);
            pos = getPosition(h2); 
            pos=sort(round(pos(:,2)/MRI.voxel_size(3))+1);
            ROI=zeros(size(PET_PVC.Matrix));
            for ii=max(1,pos(1)):min(size(PET_PVC.Matrix,3),pos(2))
                ROI(:,:,size(PET_PVC.Matrix,3)-ii+1)=BW;
            end
            ROI=PET_PVC.Matrix.*ROI*double(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+double(PET.info.SmallestImagePixelValue);
            save([PET.dir,'/PET_PVC_ROI',datestr(now,30)],'BW','pos','ROI');
        set(handles.Data_Cursor,'state','off');
        end
    catch  
    end
catch
    set(handles.Data_Cursor,'state','off');
    errordlg('please first load MRI/PET data')
end
% --------------------------------------------------------------------


% --- Executes on button press in MIP.
function MIP_Callback(hObject, eventdata, handles)
% hObject    handle to MIP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MIP
load MRI_DATA.mat;
try
load PET_DATA_After_R.mat;
catch
    load PET_DATA;
end
X_Value=round(str2double(get(handles.X_Value,'string')));set(handles.X_Value,'string',num2str(X_Value));
Y_Value=round(str2double(get(handles.Y_Value,'string')));set(handles.Y_Value,'string',num2str(Y_Value));
Z_Value=round(str2double(get(handles.Z_Value,'string')));set(handles.Z_Value,'string',num2str(Z_Value));

set(handles.Voxel_Value,'string','');

ColorMap_choice = get(handles.Color_Map,'String');
ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
cross_tag=strcmp(get(handles.Data_Cursor,'state'),'off');cross_tag=1;
display_3view(X_Value, Y_Value, Z_Value, MRI.Matrix,handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
display_3view(X_Value, Y_Value, Z_Value, PET.Matrix,handles.axes4, handles.axes5, handles.axes6, PET.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
try 
    load PET_PVC_DATA.mat
    display_3view(X_Value, Y_Value, Z_Value, PET_PVC.Matrix,handles.axes7, handles.axes8, handles.axes9, PET_PVC.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
    Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
catch
%     keyboard;
end




% --- Executes on button press in Show_MIP.
function Show_MIP_Callback(hObject, eventdata, handles)
% hObject    handle to Show_MIP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ColorMap_choice = get(handles.Color_Map,'String');
ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:);
if(get(handles.MRI_togglebutton,'value'))
    load MRI_DATA;
    load MRI_MIP;
    MIP_Rotate( image_mip,MRI.voxel_size ,ColorMap_choice);
%     MIP_Rotate( MRI.Matrsix, MRI.voxel_size ,ColorMap_choice);
elseif(get(handles.PET_togglebutton,'value'))
    try
    load PET_DATA_After_R;
    catch
        load PET_DATA;
    end
    load PET_MIP;
    MIP_Rotate( image_mip, PET.voxel_size ,ColorMap_choice);
else
    try
        load PET_PVC_DATA;
        load PET_PVC_MIP;
        MIP_Rotate( image_mip, PET_PVC.voxel_size ,ColorMap_choice);
    catch
    end
end


%%%%%%%%%%%%%%%% useless part%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Voxel_Value_Callback(hObject, eventdata, handles)
% hObject    handle to Voxel_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Voxel_Value as text
%        str2double(get(hObject,'String')) returns contents of Voxel_Value as a double


% --- Executes during object creation, after setting all properties.
function Voxel_Value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Voxel_Value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function Sig_MRI_Callback(hObject, eventdata, handles)
% hObject    handle to Sig_MRI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sig_MRI as text
%        str2double(get(hObject,'String')) returns contents of Sig_MRI as a double


% --- Executes during object creation, after setting all properties.
function Sig_MRI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sig_MRI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function Color_Map_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Color_Map (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function PET_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PET_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function Scaner_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Scaner_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Scaner_Input as text
%        str2double(get(hObject,'String')) returns contents of Scaner_Input as a double



% --- Executes during object creation, after setting all properties.
function Scaner_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Scaner_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Sig_PET_Callback(hObject, eventdata, handles)
% hObject    handle to Sig_PET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sig_PET as text
%        str2double(get(hObject,'String')) returns contents of Sig_PET as a double


% --- Executes during object creation, after setting all properties.
function Sig_PET_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sig_PET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Reg_Par_Callback(hObject, eventdata, handles)
% hObject    handle to Reg_Par (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Reg_Par as text
%        str2double(get(hObject,'String')) returns contents of Reg_Par as a double
if(get(handles.JE_Perior,'value'))
    ChooseRegPar_JEPerior(str2double(get(handles.Reg_Par,'string')));
else
    set(handles.Reg_Par,'string','0')
end

% --- Executes during object creation, after setting all properties.
function Reg_Par_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Reg_Par (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Step_Size_Callback(hObject, eventdata, handles)
% hObject    handle to Step_Size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Step_Size as text
%        str2double(get(hObject,'String')) returns contents of Step_Size as a double


% --- Executes during object creation, after setting all properties.
function Step_Size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Step_Size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Num_Iter_Callback(hObject, eventdata, handles)
% hObject    handle to Num_Iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Num_Iter as text
%        str2double(get(hObject,'String')) returns contents of Num_Iter as a double


% --- Executes during object creation, after setting all properties.
function Num_Iter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Num_Iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SVPSF.
function SVPSF_Callback(hObject, eventdata, handles)
% hObject    handle to SVPSF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SVPSF




% --- Executes on button press in None_JE_Prior_Toggle.
function None_JE_Prior_Toggle_Callback(hObject, eventdata, handles)
% hObject    handle to None_JE_Prior_Toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of None_JE_Prior_Toggle


% --- Executes on button press in JE_Perior_Toggle.
function JE_Perior_Toggle_Callback(hObject, eventdata, handles)
% hObject    handle to JE_Perior_Toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of JE_Perior_Toggle


% --------------------------------------------------------------------
function Background_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Background_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Edit_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Guide_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Guide_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function TEST1_Callback(hObject, eventdata, handles)
% hObject    handle to TEST1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Data_Cursor_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to TEST1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Compute_MIP.
function Compute_MIP_Callback(hObject, eventdata, handles)
% hObject    handle to Compute_MIP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%save the MIP data this part need revise
load MRI_DATA;
set(handles.figure1, 'pointer', 'watch')
tic
MIP_save( MRI.Matrix ,'MRI');
toc

try
    try
    load PET_DATA_After_R;
    catch
        load PET_DATA;
    end
    tic
    MIP_save( PET.Matrix ,'PET');
    toc
    catch
end

try
    load PET_PVC_DATA;
    tic
    MIP_save( PET.Matrix ,'PET_PVC');
    toc
    catch
end
set(handles.figure1, 'pointer', 'arrow')
Message_State(handles);


% --- Executes on button press in Show_Histogram.
function Show_Histogram_Callback(hObject, eventdata, handles)
% hObject    handle to Show_Histogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
load PET_DATA_After_R;
catch
    load PET_DATA
end
load MRI_DATA;
sigscale_x=str2double(get(handles.Sig_PET,'string'));
sigscale_y=str2double(get(handles.Sig_MRI,'string'));
Histogram_GUI(PET.Matrix, MRI.Matrix, sigscale_x,sigscale_y)


% --- Executes on button press in Show.
function Show_Callback(hObject, eventdata, handles)
% hObject    handle to Show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('MRI_DATA'); 
try
    load('PET_DATA_After_R');
catch
    load('PET_DATA.mat');
end
%%set the first value of PVC parameters
set(handles.Sig_PET,'string','10');
set(handles.Sig_MRI,'string','10');
set(handles.Reg_Par,'string','0');
set(handles.Step_Size,'string','1');
set(handles.Num_Iter,'string','1');
set(handles.SVPSF,'Value',1); 
set(handles.JE_Perior,'value',0);

%%set the first value of X,Y,Z and others
set(handles.X_Value,'string',num2str(round(size(MRI.Matrix,1)/2)));
set(handles.Y_Value,'string',num2str(round(size(MRI.Matrix,2)/2)));
set(handles.Z_Value,'string',num2str(round(size(MRI.Matrix,3)/2)));
set(handles.MIP,'value',0);

%set the first value and units for slider 1,2,3
slider_step(1) = 1/(size(MRI.Matrix,3)-1);
slider_step(2) = 1/(size(MRI.Matrix,3)-1);
set(handles.slider1,'sliderstep',slider_step,...
      'max',size(MRI.Matrix,3),'min',1,'Value',round(size(MRI.Matrix,3)/2));

slider_step(1) = 1/(size(MRI.Matrix,1)-1);
slider_step(2) = 1/(size(MRI.Matrix,1)-1);
set(handles.slider2,'sliderstep',slider_step,...
      'max',size(MRI.Matrix,1),'min',1,'Value',round((size(MRI.Matrix,1))/2));

slider_step(1) = 1/(size(MRI.Matrix,2)-1);
slider_step(2) = 1/(size(MRI.Matrix,2)-1);
set(handles.slider3,'sliderstep',slider_step,...
      'max',size(MRI.Matrix,2),'min',1,'Value',round(size(MRI.Matrix,2)/2));

%set the first value and units for slider 4,5,6
slider_step(1) = 1/(size(PET.Matrix,3)-1);
slider_step(2) = 1/(size(PET.Matrix,3)-1);
set(handles.slider4,'sliderstep',slider_step,...
      'max',size(PET.Matrix,3),'min',1,'Value',round(size(PET.Matrix,3)/2));

slider_step(1) = 1/(size(PET.Matrix,1)-1);
slider_step(2) = 1/(size(PET.Matrix,1)-1);
set(handles.slider5,'sliderstep',slider_step,...
      'max',size(PET.Matrix,1),'min',1,'Value',round(size(PET.Matrix,1)/2));

slider_step(1) = 1/(size(PET.Matrix,2)-1);
slider_step(2) = 1/(size(PET.Matrix,2)-1);
set(handles.slider6,'sliderstep',slider_step,...
      'max',size(PET.Matrix,2),'min',1,'Value',round(size(PET.Matrix,2)/2));

%set the first value and units for slider 7,8,9
slider_step(1) = 1/(size(PET.Matrix,3)-1);
slider_step(2) = 1/(size(PET.Matrix,3)-1);
set(handles.slider7,'sliderstep',slider_step,...
      'max',size(PET.Matrix,3),'min',1,'Value',round((size(PET.Matrix,3))/2));

slider_step(1) = 1/(size(PET.Matrix,1)-1);
slider_step(2) = 1/(size(PET.Matrix,1)-1);
set(handles.slider8,'sliderstep',slider_step,...
      'max',size(PET.Matrix,1),'min',1,'Value',round((size(PET.Matrix,1))/2));

slider_step(1) = 1/(size(PET.Matrix,2)-1);
slider_step(2) = 1/(size(PET.Matrix,2)-1);
set(handles.slider9,'sliderstep',slider_step,...
      'max',size(PET.Matrix,2),'min',1,'Value',round((size(PET.Matrix,2))/2));

%initialize TOGGLEBUTTON and Panel, first set MRI on!!!others off
set(handles.MRI_togglebutton,'value',1);
set(handles.PET_togglebutton,'value',0);
set(handles.PET_togglebutton,'value',0);
set(handles.MRI_togglebutton,'backgroundcolor',[0.8,0.8,0.8]);
set(handles.PET_togglebutton,'backgroundcolor',[0,0,0]);
set(handles.PET_PVC_togglebutton,'backgroundcolor',[0,0,0]);
set(handles.MRI_panel,'visible','on');
set(handles.PET_panel,'visible','off');
set(handles.PET_PVC_panel,'visible','off');
% set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
  
  
%%show the figure!!!!!! This part need revise!!!!!!!!!!!!!!!!!!!
X_Value=round(str2double(get(handles.X_Value,'string')));
Y_Value=round(str2double(get(handles.Y_Value,'string')));
Z_Value=round(str2double(get(handles.Z_Value,'string')));
if(get(handles.MRI_togglebutton,'value'))
    set(handles.Voxel_Value,'string',num2str((MRI.Matrix(X_Value,Y_Value,Z_Value))*(MRI.info.LargestImagePixelValue-MRI.info.SmallestImagePixelValue)+MRI.info.SmallestImagePixelValue));
elseif(get(handles.PET_togglebutton,'value'))
    set(handles.Voxel_Value,'string',num2str((PET.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
else
    try
        set(handles.Voxel_Value,'string',num2str((PET_PVC.Matrix(X_Value,Y_Value,Z_Value))*(PET.info.LargestImagePixelValue-PET.info.SmallestImagePixelValue)+PET.info.SmallestImagePixelValue));
    catch
    end
end
ColorMap_choice = get(handles.Color_Map,'String');
ColorMap_choice = ColorMap_choice(get(handles.Color_Map,'value'),:); 
cross_tag=strcmp(get(handles.Data_Cursor,'state'),'off');cross_tag=1;
display_3view_initial(X_Value, Y_Value, Z_Value, MRI.Matrix,handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
display_3view_initial(X_Value, Y_Value, Z_Value, PET.Matrix,handles.axes4, handles.axes5, handles.axes6, PET.voxel_size,ColorMap_choice, cross_tag ,get(handles.MIP,'value'));
Slider_Visible( handles.slider1,handles.slider2,handles.slider3,handles.slider4,handles.slider5,handles.slider6,handles.slider7,handles.slider8,handles.slider9,1-get(handles.MIP,'value') );
set(handles.slider1,'visible','on');set(handles.slider2,'visible','on');set(handles.slider3,'visible','on');
set(handles.slider4,'visible','on');set(handles.slider5,'visible','on');set(handles.slider6,'visible','on');
set(handles.slider7,'visible','on');set(handles.slider8,'visible','on');set(handles.slider9,'visible','on');
set(handles.figure1, 'pointer', 'arrow');
Message_State(handles);


% --------------------------------------------------------------------
function ROI_Callback(hObject, eventdata, handles)
% hObject    handle to ROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ROI_Mean_Callback(hObject, eventdata, handles)
% hObject    handle to ROI_Mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.mat','Select the MATLAB code file');
load( [PathName,FileName]);
ROI_Mean=sum(ROI(:))/numel(find(ROI));
mydialog(['The mean value of the ROI is:', num2str(ROI_Mean)],0);
