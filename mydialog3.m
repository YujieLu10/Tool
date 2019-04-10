function varargout = mydialog3(varargin)
% MYDIALOG3 MATLAB code for mydialog3.fig
%      MYDIALOG3, by itself, creates a new MYDIALOG3 or raises the existing
%      singleton*.
%
%      H = MYDIALOG3 returns the handle to a new MYDIALOG3 or the handle to
%      the existing singleton*.
%
%      MYDIALOG3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYDIALOG3.M with the given input arguments.
%
%      MYDIALOG3('Property','Value',...) creates a new MYDIALOG3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mydialog3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mydialog3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mydialog3

% Last Modified by GUIDE v2.5 27-Jul-2015 16:52:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mydialog3_OpeningFcn, ...
                   'gui_OutputFcn',  @mydialog3_OutputFcn, ...
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


% --- Executes just before mydialog3 is made visible.
function mydialog3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mydialog3 (see VARARGIN)

% Choose default command line output for mydialog3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mydialog3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mydialog3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tag;
delete(gcf);
tag=1;
save('tag','tag');
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tag;
delete(gcf);
tag=2;
save('tag','tag');
