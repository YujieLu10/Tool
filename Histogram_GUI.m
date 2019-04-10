function varargout = Histogram_GUI(varargin)
% HISTOGRAM_GUI MATLAB code for Histogram_GUI.fig
%      HISTOGRAM_GUI, by itself, creates a new HISTOGRAM_GUI or raises the existing
%      singleton*.
%
%      H = HISTOGRAM_GUI returns the handle to a new HISTOGRAM_GUI or the handle to
%      the existing singleton*.
%
%      HISTOGRAM_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HISTOGRAM_GUI.M with the given input arguments.
%
%      HISTOGRAM_GUI('Property','Value',...) creates a new HISTOGRAM_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Histogram_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Histogram_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Histogram_GUI

% Last Modified by GUIDE v2.5 06-Aug-2015 13:39:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Histogram_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Histogram_GUI_OutputFcn, ...
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


% --- Executes just before Histogram_GUI is made visible.
function Histogram_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Histogram_GUI (see VARARGIN)

% Choose default command line output for Histogram_GUI
PET=varargin{1};
MRI=varargin{2};
sigscale_x=varargin{3};
sigscale_y=varargin{4};
handles.output = hObject;
axes(handles.axes1);
axis equal;
xlim([0,1]);
ylim([0,1]);
set(handles.Sig_PET_sub,'string',num2str(sigscale_x));
set(handles.Sig_MRI_sub,'string',num2str(sigscale_y));
slider_step(1) = 1/100;
slider_step(2) = 1/100;
set(handles.slider_PET,'sliderstep',slider_step,...
      'max',100,'min',0,...
      'Value',sigscale_x,'visible','on');
set(handles.slider_MRI,'sliderstep',slider_step,...
      'max',100,'min',0,...
      'Value',sigscale_y,'visible','on');
Histogram_show( PET,MRI,sigscale_x,sigscale_y,handles.axes1 )
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Histogram_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Histogram_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider_PET_Callback(hObject, eventdata, handles)
% hObject    handle to slider_PET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
load PET_DATA_After_R;
load MRI_DATA;
sigscale_x=get(handles.slider_PET,'VALUE');
sigscale_y=get(handles.slider_MRI,'VALUE');

set(handles.Sig_PET_sub,'string',num2str(sigscale_x));
set(handles.Sig_MRI_sub,'string',num2str(sigscale_y));
Histogram_show( PET.Matrix,MRI.Matrix,sigscale_x,sigscale_y,handles.axes1 )

% --- Executes during object creation, after setting all properties.
function slider_PET_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_PET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Sig_PET_sub_Callback(hObject, eventdata, handles)
% hObject    handle to Sig_PET_sub (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sig_PET_sub as text
%        str2double(get(hObject,'String')) returns contents of Sig_PET_sub as a double
load PET_DATA_After_R;
load MRI_DATA;
sigscale_x=str2double(get(handles.Sig_PET_sub,'string'));
sigscale_y=str2double(get(handles.Sig_MRI_sub,'string'));
if sigscale_x>0&&sigscale_y>0&&sigscale_x<get(handles.slider_PET,'MAX')&&sigscale_y<get(handles.slider_MRI,'MAX')
    set(handles.slider_PET,'value',sigscale_x);
    set(handles.slider_MRI,'value',sigscale_y);
    Histogram_show( PET.Matrix,MRI.Matrix,sigscale_x,sigscale_y,handles.axes1 )
end

% --- Executes during object creation, after setting all properties.
function Sig_PET_sub_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sig_PET_sub (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_MRI_Callback(hObject, eventdata, handles)
% hObject    handle to slider_MRI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
load PET_DATA_After_R;
load MRI_DATA;
sigscale_x=get(handles.slider_PET,'VALUE');
sigscale_y=get(handles.slider_MRI,'VALUE');

set(handles.Sig_PET_sub,'string',num2str(sigscale_x));
set(handles.Sig_MRI_sub,'string',num2str(sigscale_y));
Histogram_show( PET.Matrix,MRI.Matrix,sigscale_x,sigscale_y,handles.axes1 )

% --- Executes during object creation, after setting all properties.
function slider_MRI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_MRI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Sig_MRI_sub_Callback(hObject, eventdata, handles)
% hObject    handle to Sig_MRI_sub (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sig_MRI_sub as text
%        str2double(get(hObject,'String')) returns contents of Sig_MRI_sub as a double
load PET_DATA_After_R;
load MRI_DATA;
sigscale_x=str2double(get(handles.Sig_PET_sub,'string'));
sigscale_y=str2double(get(handles.Sig_MRI_sub,'string'));
if sigscale_x>0&&sigscale_y>0&&sigscale_x<get(handles.slider_PET,'MAX')&&sigscale_y<get(handles.slider_MRI,'MAX')
    set(handles.slider_PET,'value',sigscale_x);
    set(handles.slider_MRI,'value',sigscale_y);
    Histogram_show( PET.Matrix,MRI.Matrix,sigscale_x,sigscale_y,handles.axes1 )
end

% --- Executes during object creation, after setting all properties.
function Sig_MRI_sub_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sig_MRI_sub (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
H = findall(0,'tag','Sig_PET'); 
set(H,'string',get(handles.Sig_PET_sub,'string'));
H = findall(0,'tag','Sig_MRI'); 
set(H,'string',get(handles.Sig_MRI_sub,'string'));
close(gcf);

% --- Executes during object creation, after setting all properties.
function sig_PET_Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sig_PET_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
