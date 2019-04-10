function varargout = Registration_Popout(varargin)
% REGISTRATION_POPOUT MATLAB code for Registration_Popout.fig
%      REGISTRATION_POPOUT, by itself, creates a new REGISTRATION_POPOUT or raises the existing
%      singleton*.
%
%      H = REGISTRATION_POPOUT returns the handle to a new REGISTRATION_POPOUT or the handle to
%      the existing singleton*.
%
%      REGISTRATION_POPOUT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REGISTRATION_POPOUT.M with the given input arguments.
%
%      REGISTRATION_POPOUT('Property','Value',...) creates a new REGISTRATION_POPOUT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Registration_Popout_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Registration_Popout_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Registration_Popout

% Last Modified by GUIDE v2.5 19-Mar-2019 20:14:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Registration_Popout_OpeningFcn, ...
                   'gui_OutputFcn',  @Registration_Popout_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Registration_Popout is made visible.
function Registration_Popout_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Registration_Popout (see VARARGIN)

% Choose default command line output for Registration_Popout
handles.output = hObject;
%%load and initialize
load MRI_DATA;
load PET_DATA;

%%SET UP THE selected toggle button
set(handles.Before_R,'value',1);
set(handles.Before_R,'backgroundcolor',[0.8,0.8,0.8]);
set(handles.Before_R,'Fontweight','bold');
set(handles.After_R,'Fontweight','normal');
        
        
MRI_X_Value=round(size(MRI.Matrix,1)/2);
MRI_Y_Value=round(size(MRI.Matrix,2)/2);
MRI_Z_Value=round(size(MRI.Matrix,3)/2);
PET_X_Value=round((MRI_X_Value+MRI.voxel_size(1)/2-PET.voxel_size(1)/2)/PET.voxel_size(1));
PET_Y_Value=round((MRI_Y_Value+MRI.voxel_size(2)/2-PET.voxel_size(2)/2)/PET.voxel_size(2));
PET_Z_Value=round((MRI_Z_Value+MRI.voxel_size(3)/2-PET.voxel_size(3)/2)/PET.voxel_size(3));

Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Registration_Popout wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Registration_Popout_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Before_R.
function Before_R_Callback(hObject, eventdata, handles)
% hObject    handle to Before_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Before_R


% --- Executes on button press in After_R.
function After_R_Callback(hObject, eventdata, handles)
% hObject    handle to After_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of After_R



function MRI_X_Callback(hObject, eventdata, handles)
% hObject    handle to MRI_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MRI_X as text
%        str2double(get(hObject,'String')) returns contents of MRI_X as a double
if get(handles.Before_R,'value')
    load MRI_DATA;
    load PET_DATA;
    MRI_X_Value=round(str2double(get(handles.MRI_X,'String')));
    MRI_Y_Value=round(str2double(get(handles.MRI_Y,'String')));
    MRI_Z_Value=round(str2double(get(handles.MRI_Z,'String')));

    PET_X_Value=round((MRI_X_Value+MRI.voxel_size(1)/2-PET.voxel_size(1)/2)/PET.voxel_size(1));
    PET_Y_Value=round(str2double(get(handles.PET_Y,'String')));
    PET_Z_Value=round(str2double(get(handles.PET_Z,'String')));

    Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value);
else
    load MRI_DATA;
    load PET_DATA_After_R;
    MRI_X_Value=round(str2double(get(handles.MRI_X,'String')));
    MRI_Y_Value=round(str2double(get(handles.MRI_Y,'String')));
    MRI_Z_Value=round(str2double(get(handles.MRI_Z,'String')));

    PET_X_Value=round((MRI_X_Value+MRI.voxel_size(1)/2-PET.voxel_size(1)/2)/PET.voxel_size(1));
    PET_Y_Value=round(str2double(get(handles.PET_Y,'String')));
    PET_Z_Value=round(str2double(get(handles.PET_Z,'String')));

    Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value);
end

% --- Executes during object creation, after setting all properties.
function MRI_X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MRI_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MRI_Y_Callback(hObject, eventdata, handles)
% hObject    handle to MRI_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MRI_Y as text
%        str2double(get(hObject,'String')) returns contents of MRI_Y as a double
if get(handles.Before_R,'value')
    load MRI_DATA;
    load PET_DATA;
    MRI_X_Value=round(str2double(get(handles.MRI_X,'String')));
    MRI_Y_Value=round(str2double(get(handles.MRI_Y,'String')));
    MRI_Z_Value=round(str2double(get(handles.MRI_Z,'String')));

    PET_X_Value=round(str2double(get(handles.PET_X,'String')));
    PET_Y_Value=round((MRI_Y_Value+MRI.voxel_size(2)/2-PET.voxel_size(2)/2)/PET.voxel_size(2));
    PET_Z_Value=round(str2double(get(handles.PET_Z,'String')));

    Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value);
else
    load MRI_DATA;
    load PET_DATA_After_R;
    MRI_X_Value=round(str2double(get(handles.MRI_X,'String')));
    MRI_Y_Value=round(str2double(get(handles.MRI_Y,'String')));
    MRI_Z_Value=round(str2double(get(handles.MRI_Z,'String')));

    PET_X_Value=round(str2double(get(handles.PET_X,'String')));
    PET_Y_Value=round((MRI_Y_Value+MRI.voxel_size(2)/2-PET.voxel_size(2)/2)/PET.voxel_size(2));
    PET_Z_Value=round(str2double(get(handles.PET_Z,'String')));

    Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value);
end

% --- Executes during object creation, after setting all properties.
function MRI_Y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MRI_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MRI_Z_Callback(hObject, eventdata, handles)
% hObject    handle to MRI_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MRI_Z as text
%        str2double(get(hObject,'String')) returns contents of MRI_Z as a double
if get(handles.Before_R,'value')
    load MRI_DATA;
    load PET_DATA;
    MRI_X_Value=round(str2double(get(handles.MRI_X,'String')));
    MRI_Y_Value=round(str2double(get(handles.MRI_Y,'String')));
    MRI_Z_Value=round(str2double(get(handles.MRI_Z,'String')));

    PET_X_Value=round(str2double(get(handles.PET_X,'String')));
    PET_Y_Value=round(str2double(get(handles.PET_Y,'String')));
    PET_Z_Value=round((MRI_Z_Value+MRI.voxel_size(3)/2-PET.voxel_size(3)/2)/PET.voxel_size(3));

    Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value);
else
    load MRI_DATA;
    load PET_DATA_After_R;
    MRI_X_Value=round(str2double(get(handles.MRI_X,'String')));
    MRI_Y_Value=round(str2double(get(handles.MRI_Y,'String')));
    MRI_Z_Value=round(str2double(get(handles.MRI_Z,'String')));

    PET_X_Value=round(str2double(get(handles.PET_X,'String')));
    PET_Y_Value=round(str2double(get(handles.PET_Y,'String')));
    PET_Z_Value=round((MRI_Z_Value+MRI.voxel_size(3)/2-PET.voxel_size(3)/2)/PET.voxel_size(3));

    Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value);
end



% --- Executes during object creation, after setting all properties.
function MRI_Z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MRI_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






function MRI_V_Callback(hObject, eventdata, handles)
% hObject    handle to MRI_V (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MRI_V as text
%        str2double(get(hObject,'String')) returns contents of MRI_V as a double


% --- Executes during object creation, after setting all properties.
function MRI_V_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MRI_V (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PET_X_Callback(hObject, eventdata, handles)
% hObject    handle to PET_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PET_X as text
%        str2double(get(hObject,'String')) returns contents of PET_X as a double
if get(handles.Before_R,'value')
    PET_X_Value=round(str2double(get(handles.PET_X,'String')));
    PET_Y_Value=round(str2double(get(handles.PET_Y,'String')));
    PET_Z_Value=round(str2double(get(handles.PET_Z,'String')));
    
    MRI_X_Value=round((PET_X_Value+PET.voxel_size(1)/2-MRI.voxel_size(1)/2)/MRI.voxel_size(1));
    MRI_Y_Value=round(str2double(get(handles.MRI_Y,'String')));
    MRI_Z_Value=round(str2double(get(handles.MRI_Z,'String')));
    
    Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value);
else
    load MRI_DATA;
    load PET_DATA_After_R;
    PET_X_Value=round(str2double(get(handles.PET_X,'String')));
    PET_Y_Value=round(str2double(get(handles.PET_Y,'String')));
    PET_Z_Value=round(str2double(get(handles.PET_Z,'String')));
    
    MRI_X_Value=round((PET_X_Value+PET.voxel_size(1)/2-MRI.voxel_size(1)/2)/MRI.voxel_size(1));
    MRI_Y_Value=round(str2double(get(handles.MRI_Y,'String')));
    MRI_Z_Value=round(str2double(get(handles.MRI_Z,'String')));

    Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value);
end

% --- Executes during object creation, after setting all properties.
function PET_X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PET_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PET_Y_Callback(hObject, eventdata, handles)
% hObject    handle to PET_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PET_Y as text
%        str2double(get(hObject,'String')) returns contents of PET_Y as a double
if get(handles.Before_R,'value')
    load MRI_DATA;
    load PET_DATA;
    PET_X_Value=round(str2double(get(handles.PET_X,'String')));
    PET_Y_Value=round(str2double(get(handles.PET_Y,'String')));
    PET_Z_Value=round(str2double(get(handles.PET_Z,'String')));
    
    MRI_X_Value=round(str2double(get(handles.MRI_X,'String')));
    MRI_Y_Value=round((PET_Y_Value+PET.voxel_size(2)/2-MRI.voxel_size(2)/2)/MRI.voxel_size(2));
    MRI_Z_Value=round(str2double(get(handles.MRI_Z,'String')));
    
    Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value);
else
    load MRI_DATA;
    load PET_DATA_After_R;
    PET_X_Value=round(str2double(get(handles.PET_X,'String')));
    PET_Y_Value=round(str2double(get(handles.PET_Y,'String')));
    PET_Z_Value=round(str2double(get(handles.PET_Z,'String')));
    
    MRI_X_Value=round(str2double(get(handles.MRI_X,'String')));
    MRI_Y_Value=round((PET_Y_Value+PET.voxel_size(2)/2-MRI.voxel_size(2)/2)/MRI.voxel_size(2));
    MRI_Z_Value=round(str2double(get(handles.MRI_Z,'String')));

    Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value);
end

% --- Executes during object creation, after setting all properties.
function PET_Y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PET_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PET_Z_Callback(hObject, eventdata, handles)
% hObject    handle to PET_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PET_Z as text
%        str2double(get(hObject,'String')) returns contents of PET_Z as a double
if get(handles.Before_R,'value')
    load MRI_DATA;
    load PET_DATA;
    PET_X_Value=round(str2double(get(handles.PET_X,'String')));
    PET_Y_Value=round(str2double(get(handles.PET_Y,'String')));
    PET_Z_Value=round(str2double(get(handles.PET_Z,'String')));
    
    MRI_X_Value=round(str2double(get(handles.MRI_X,'String')));
    MRI_Y_Value=round(str2double(get(handles.MRI_Y,'String')));
    MRI_Z_Value=round((PET_Z_Value+PET.voxel_size(3)/2-MRI.voxel_size(3)/2)/MRI.voxel_size(3));
    
    Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value);
else
    load MRI_DATA;
    load PET_DATA_After_R;
    PET_X_Value=round(str2double(get(handles.PET_X,'String')));
    PET_Y_Value=round(str2double(get(handles.PET_Y,'String')));
    PET_Z_Value=round(str2double(get(handles.PET_Z,'String')));
    
    MRI_X_Value=round(str2double(get(handles.MRI_X,'String')));
    MRI_Y_Value=round(str2double(get(handles.MRI_Y,'String')));
    MRI_Z_Value=round((PET_Z_Value+PET.voxel_size(3)/2-MRI.voxel_size(3)/2)/MRI.voxel_size(3));
    
    Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value);
end

% --- Executes during object creation, after setting all properties.
function PET_Z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PET_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PET_V_Callback(hObject, eventdata, handles)
% hObject    handle to PET_V (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PET_V as text
%        str2double(get(hObject,'String')) returns contents of PET_V as a double


% --- Executes during object creation, after setting all properties.
function PET_V_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PET_V (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Fuse_Para_Callback(hObject, eventdata, handles)
% hObject    handle to Fuse_Para (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Fuse_Para_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Fuse_Para (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in MRI_Colormap.
function MRI_Colormap_Callback(hObject, eventdata, handles)
% hObject    handle to MRI_Colormap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns MRI_Colormap contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MRI_Colormap
if (get(handles.Before_R,'value'))
    load MRI_DATA.mat;
else
    load MRI_DATA.mat;
end
unfreezeColors(handles.axes1);
unfreezeColors(handles.axes2);
unfreezeColors(handles.axes3);
freezeColors(handles.axes4);
freezeColors(handles.axes5);
freezeColors(handles.axes6);
freezeColors(handles.axes7);
freezeColors(handles.axes8);
freezeColors(handles.axes9);
ColorMap_choice = get(handles.MRI_Colormap,'String');
ColorMap_choice = ColorMap_choice(get(handles.MRI_Colormap,'value'),:); 

MRI_X_Value=round(str2double(get(handles.MRI_X,'String')));
MRI_Y_Value=round(str2double(get(handles.MRI_Y,'String')));
MRI_Z_Value=round(str2double(get(handles.MRI_Z,'String')));
display_3view_initial( MRI_X_Value, MRI_Y_Value, MRI_Z_Value, MRI.Matrix, ...
    handles.axes1, handles.axes2, handles.axes3, MRI.voxel_size, ColorMap_choice,1, 0)
% --- Executes during object creation, after setting all properties.
function MRI_Colormap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MRI_Colormap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Patch.
function Patch_Callback(hObject, eventdata, handles)
% hObject    handle to Patch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in PET_Colormap.
function PET_Colormap_Callback(hObject, eventdata, handles)
% hObject    handle to PET_Colormap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PET_Colormap contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PET_Colormap
if (get(handles.Before_R,'value'))
    load PET_DATA.mat;
else
    load PET_DATA_After_R.mat;
end

freezeColors(handles.axes1);
freezeColors(handles.axes2);
freezeColors(handles.axes3);
unfreezeColors(handles.axes4);
unfreezeColors(handles.axes5);
unfreezeColors(handles.axes6);
freezeColors(handles.axes7);
freezeColors(handles.axes8);
freezeColors(handles.axes9);
ColorMap_choice = get(handles.PET_Colormap,'String');
ColorMap_choice = ColorMap_choice(get(handles.PET_Colormap,'value'),:); 

PET_X_Value=round(str2double(get(handles.PET_X,'String')));
PET_Y_Value=round(str2double(get(handles.PET_Y,'String')));
PET_Z_Value=round(str2double(get(handles.PET_Z,'String')));
display_3view_initial( PET_X_Value, PET_Y_Value, PET_Z_Value, PET.Matrix, ...
    handles.axes4, handles.axes5, handles.axes6, PET.voxel_size, ColorMap_choice,1, 0)

% --- Executes during object creation, after setting all properties.
function PET_Colormap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PET_Colormap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes when selected object is changed in Toggle_Btn_Group.
function Toggle_Btn_Group_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in Toggle_Btn_Group 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag')
    case 'Before_R'
        load MRI_DATA.mat;
        load PET_DATA.mat;
        
        set(handles.Before_R,'backgroundcolor',[0.8,0.8,0.8]);
        set(handles.After_R,'backgroundcolor',[0,0,0]);
        
        set(handles.Before_R,'Fontweight','bold');
        set(handles.After_R,'Fontweight','normal');
        
        
        MRI_X_Value=round(str2double(get(handles.MRI_X,'String')));
        MRI_Y_Value=round(str2double(get(handles.MRI_Y,'String')));
        MRI_Z_Value=round(str2double(get(handles.MRI_Z,'String')));
        
        PET_X_Value=round((MRI_X_Value+MRI.voxel_size(1)/2-PET.voxel_size(1)/2)/PET.voxel_size(1));
        PET_Y_Value=round((MRI_Y_Value+MRI.voxel_size(2)/2-PET.voxel_size(2)/2)/PET.voxel_size(2));
        PET_Z_Value=round((MRI_Z_Value+MRI.voxel_size(3)/2-PET.voxel_size(3)/2)/PET.voxel_size(3));

        Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value);
    case 'After_R'
        try
        load MRI_DATA.mat;
        load PET_DATA_After_R.mat;
        catch
            errordlg('Please press Registration Button!');
        end
        set(handles.Before_R,'backgroundcolor',[0,0,0]);
        set(handles.After_R,'backgroundcolor',[0.8,0.8,0.8]);
        
        set(handles.Before_R,'Fontweight','normal');
        set(handles.After_R,'Fontweight','bold');
        
        MRI_X_Value=round(str2double(get(handles.MRI_X,'String')));
        MRI_Y_Value=round(str2double(get(handles.MRI_Y,'String')));
        MRI_Z_Value=round(str2double(get(handles.MRI_Z,'String')));
        
        PET_X_Value=round((MRI_X_Value+MRI.voxel_size(1)/2-PET.voxel_size(1)/2)/PET.voxel_size(1));
        PET_Y_Value=round((MRI_Y_Value+MRI.voxel_size(2)/2-PET.voxel_size(2)/2)/PET.voxel_size(2));
        PET_Z_Value=round((MRI_Z_Value+MRI.voxel_size(3)/2-PET.voxel_size(3)/2)/PET.voxel_size(3));

        Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value);
        
end




% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global current_axes
    current_axes=gca; 
    
    CP=get(gca,'currentpoint');CP=CP(1,:);%get current point in the axis
    %%if in the panel1
    if(gca==handles.axes1)
        if(get(handles.Before_R,'value'))
            load MRI_DATA.mat 
            load PET_DATA.mat
        else
            load MRI_DATA.mat
            load PET_DATA_After_R.mat
        end
        MRI_X_Value=round(CP(1,2)/MRI.voxel_size(1))+1;
        MRI_Y_Value=round(CP(1,1)/MRI.voxel_size(2))+1;
        MRI_Z_Value=round(str2double(get(handles.MRI_Z,'string')));
        if(MRI_X_Value>=1&&MRI_X_Value<=size(MRI.Matrix,1)&&MRI_Y_Value>=1&&MRI_Y_Value<=size(MRI.Matrix,2)&&MRI_Z_Value>=1&&MRI_Z_Value<=size(MRI.Matrix,3))
            %judge whether in/out of the image
            PET_X_Value=round(MRI_X_Value/size(MRI.Matrix,1)*size(PET.Matrix,1));
            PET_Y_Value=round(MRI_Y_Value/size(MRI.Matrix,2)*size(PET.Matrix,2));
            PET_Z_Value=round(MRI_Z_Value/size(MRI.Matrix,3)*size(PET.Matrix,3));

            Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value);
            
        end
    elseif(gca==handles.axes2)
        if(get(handles.Before_R,'value'))
            load MRI_DATA.mat 
            load PET_DATA.mat
        else
            load MRI_DATA.mat
            load PET_DATA_After_R.mat
        end 
        MRI_X_Value=round(str2double(get(handles.MRI_X,'string')));
        MRI_Y_Value=round(CP(1,1)/MRI.voxel_size(2))+1;
        MRI_Z_Value=size(MRI.Matrix,3)-round(CP(1,2)/MRI.voxel_size(3));
        if(MRI_X_Value>=1&&MRI_X_Value<=size(MRI.Matrix,1)&&MRI_Y_Value>=1&&MRI_Y_Value<=size(MRI.Matrix,2)&&MRI_Z_Value>=1&&MRI_Z_Value<=size(MRI.Matrix,3))
            %judge whether in/out of the image
            PET_X_Value=round(MRI_X_Value/size(MRI.Matrix,1)*size(PET.Matrix,1));
            PET_Y_Value=round(MRI_Y_Value/size(MRI.Matrix,2)*size(PET.Matrix,2));
            PET_Z_Value=round(MRI_Z_Value/size(MRI.Matrix,3)*size(PET.Matrix,3));

            Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value);
        end
    elseif(gca==handles.axes3)
        if(get(handles.Before_R,'value'))
            load MRI_DATA.mat 
            load PET_DATA.mat
        else
            load MRI_DATA.mat
            load PET_DATA_After_R.mat
        end
        MRI_X_Value=round(CP(1,1)/MRI.voxel_size(1))+1;
        MRI_Y_Value=round(str2double(get(handles.MRI_Y,'string')));
        MRI_Z_Value=size(MRI.Matrix,3)-round(CP(1,2)/MRI.voxel_size(3));
        if(MRI_X_Value>=1&&MRI_X_Value<=size(MRI.Matrix,1)&&MRI_Y_Value>=1&&MRI_Y_Value<=size(MRI.Matrix,2)&&MRI_Z_Value>=1&&MRI_Z_Value<=size(MRI.Matrix,3))
            %judge whether in/out of the image
            PET_X_Value=round(MRI_X_Value/size(MRI.Matrix,1)*size(PET.Matrix,1));
            PET_Y_Value=round(MRI_Y_Value/size(MRI.Matrix,2)*size(PET.Matrix,2));
            PET_Z_Value=round(MRI_Z_Value/size(MRI.Matrix,3)*size(PET.Matrix,3));

            Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value);
        end
    elseif(gca==handles.axes4)
        if(get(handles.Before_R,'value'))
            load MRI_DATA.mat 
            load PET_DATA.mat
        else
            load MRI_DATA.mat
            load PET_DATA_After_R.mat
        end
        PET_X_Value=round(CP(1,2)/PET.voxel_size(1))+1;
        PET_Y_Value=round(CP(1,1)/PET.voxel_size(2))+1;
        PET_Z_Value=round(str2double(get(handles.PET_Z,'string')));
        if(PET_X_Value>=1&&PET_X_Value<=size(PET.Matrix,1)&&PET_Y_Value>=1&&PET_Y_Value<=size(PET.Matrix,2)&&PET_Z_Value>=1&&PET_Z_Value<=size(PET.Matrix,3))
            %judge whether in/out of the image
            MRI_X_Value=round(PET_X_Value/size(PET.Matrix,1)*size(MRI.Matrix,1));
            MRI_Y_Value=round(PET_Y_Value/size(PET.Matrix,2)*size(MRI.Matrix,2));
            MRI_Z_Value=round(PET_Z_Value/size(PET.Matrix,3)*size(MRI.Matrix,3));

            Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value);
        end
    elseif(gca==handles.axes5)
        if(get(handles.Before_R,'value'))
            load MRI_DATA.mat 
            load PET_DATA.mat
        else
            load MRI_DATA.mat
            load PET_DATA_After_R.mat
        end
        PET_X_Value=round(str2double(get(handles.PET_X,'string')));
        PET_Y_Value=round(CP(1,1)/PET.voxel_size(2))+1;
        PET_Z_Value=size(PET.Matrix,3)-round(CP(1,2)/PET.voxel_size(3));
        if(PET_X_Value>=1&&PET_X_Value<=size(PET.Matrix,1)&&PET_Y_Value>=1&&PET_Y_Value<=size(PET.Matrix,2)&&PET_Z_Value>=1&&PET_Z_Value<=size(PET.Matrix,3))
            %judge whether in/out of the image
            MRI_X_Value=round(PET_X_Value/size(PET.Matrix,1)*size(MRI.Matrix,1));
            MRI_Y_Value=round(PET_Y_Value/size(PET.Matrix,2)*size(MRI.Matrix,2));
            MRI_Z_Value=round(PET_Z_Value/size(PET.Matrix,3)*size(MRI.Matrix,3));

            Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value);
        end
    elseif(gca==handles.axes6)
        if(get(handles.Before_R,'value'))
            load MRI_DATA.mat 
            load PET_DATA.mat
        else
            load MRI_DATA.mat
            load PET_DATA_After_R.mat
        end
        PET_X_Value=round(CP(1,1)/PET.voxel_size(1))+1;
        PET_Y_Value=round(str2double(get(handles.PET_Y,'string')));
        PET_Z_Value=size(PET.Matrix,3)-round(CP(1,2)/PET.voxel_size(3));
        if(PET_X_Value>=1&&PET_X_Value<=size(PET.Matrix,1)&&PET_Y_Value>=1&&PET_Y_Value<=size(PET.Matrix,2)&&PET_Z_Value>=1&&PET_Z_Value<=size(PET.Matrix,3))
            %judge whether in/out of the image
            MRI_X_Value=round(PET_X_Value/size(PET.Matrix,1)*size(MRI.Matrix,1));
            MRI_Y_Value=round(PET_Y_Value/size(PET.Matrix,2)*size(MRI.Matrix,2));
            MRI_Z_Value=round(PET_Z_Value/size(PET.Matrix,3)*size(MRI.Matrix,3));

            Registration_Show9figues( handles, MRI, PET, MRI_X_Value, MRI_Y_Value,MRI_Z_Value,PET_X_Value, PET_Y_Value,PET_Z_Value);
        end
    end


% --- Executes on button press in Registration.
function Registration_Callback(hObject, eventdata, handles)
% hObject    handle to Registration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% copyfile('Backup_Fake_Data\PET_DATA_After_R.mat','PET_DATA_After_R.mat');
% copyfile('Backup_Fake_Data\MRI_MIP.mat','MRI_MIP.mat');
% copyfile('Backup_Fake_Data\PET_MIP.mat','PET_MIP.mat');
% copyfile('Backup_Fake_Data\PET_PVC_MIP.mat','PET_PVC_MIP.mat');
load PET_DATA;
load MRI_DATA;
PET.voxel_size=MRI.voxel_size;
[optimizer, metric] = imregconfig('Multimodal');
PET.Matrix=imregister(PET.Matrix, MRI.Matrix, 'similarity', optimizer, metric);
PET.info.LargestImagePixelValue=PET.info.LargestImagePixelValue*max(PET.Matrix(:));
PET.info.SmallestImagePixelValue=0;
save('PET_DATA_After_R.mat','PET');

%%fake registration
copyfile('Backup_Fake_Data/PET_DATA_After_R.mat','PET_DATA_After_R.mat');
copyfile('Backup_Fake_Data/PET_DATA_After_R.mat','PET_DATA_After_R.mat');
