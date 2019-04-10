function varargout = ChooseRegPar_JEPerior(varargin)
% ChooseRegPar_JEPerior MATLAB code for ChooseRegPar_JEPerior.fig
%      ChooseRegPar_JEPerior, by itself, creates a new ChooseRegPar_JEPerior or raises the existing
%      singleton*.
%
%      H = ChooseRegPar_JEPerior returns the handle to a new ChooseRegPar_JEPerior or the handle to
%      the existing singleton*.
%
%      ChooseRegPar_JEPerior('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ChooseRegPar_JEPerior.M with the given input arguments.
%
%      ChooseRegPar_JEPerior('Property','Value',...) creates a new ChooseRegPar_JEPerior or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ChooseRegPar_JEPerior_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ChooseRegPar_JEPerior_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ChooseRegPar_JEPerior

% Last Modified by GUIDE v2.5 22-Jul-2015 14:46:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ChooseRegPar_JEPerior_OpeningFcn, ...
                   'gui_OutputFcn',  @ChooseRegPar_JEPerior_OutputFcn, ...
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


% --- Executes just before ChooseRegPar_JEPerior is made visible.
function ChooseRegPar_JEPerior_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ChooseRegPar_JEPerior (see VARARGIN)

% Choose default command line output for ChooseRegPar_JEPerior
handles.output = hObject;

slider_step(1) = 1/(200);
slider_step(2) = 1/(200);
set(handles.sliderM,'sliderstep',slider_step,...
      'max',100,'min',-100,'Value',0);
set(handles.sliderA,'sliderstep',slider_step,...
      'max',100,'min',-100,'Value',0);

set(handles.MV,'STRING','-1');
set(handles.AV,'STRING','+1');
nVarargs = length(varargin);initial_value=varargin{nVarargs};
set(handles.Reg_Par_sub,'STRING',num2str(initial_value));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ChooseRegPar_JEPerior wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ChooseRegPar_JEPerior_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Reg_Par_sub_Callback(hObject, eventdata, handles)
% hObject    handle to Reg_Par_sub (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Reg_Par_sub as text
%        str2double(get(hObject,'String')) returns contents of Reg_Par_sub as a double


% --- Executes during object creation, after setting all properties.
function Reg_Par_sub_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Reg_Par_sub (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in M1.
function M1_Callback(hObject, eventdata, handles)
% hObject    handle to M1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Reg_Par_sub,'string',num2str(-10^(get(handles.sliderM,'Value'))+str2double(get(handles.Reg_Par_sub,'string'))));

% --- Executes on button press in A1.
function A1_Callback(hObject, eventdata, handles)
% hObject    handle to A1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Reg_Par_sub,'string',num2str(10^(get(handles.sliderA,'Value'))+str2double(get(handles.Reg_Par_sub,'string'))));


% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
H = findall(0,'tag','Reg_Par'); 
set(H,'string',get(handles.Reg_Par_sub,'string'))
close(gcf);
% --- Executes during object creation, after setting all properties.
function Save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function sliderA_Callback(hObject, eventdata, handles)
% hObject    handle to sliderA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Va=round(get(handles.sliderA,'Value'));
set(handles.sliderA,'Value',Va);
if Va~=0
    set(handles.AV,'string',['+10^',num2str(Va)]);
else
    set(handles.AV,'string',['+1']);
end

% --- Executes during object creation, after setting all properties.
function sliderA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderM_Callback(hObject, eventdata, handles)
% hObject    handle to sliderM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Vm=round(get(handles.sliderM,'Value'));
set(handles.sliderM,'Value',Vm);
if Vm~=0
    set(handles.MV,'string',['-10^',num2str(Vm)]);
else
    set(handles.MV,'string',['-1']);
end

% --- Executes during object creation, after setting all properties.
function sliderM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

delete(hObject);
