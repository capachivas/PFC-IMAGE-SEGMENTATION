function varargout = ventana_graficas(varargin)
% VENTANA_GRAFICAS M-file for ventana_graficas.fig
%      VENTANA_GRAFICAS, by itself, creates a new VENTANA_GRAFICAS or raises the existing
%      singleton*.
%
%      H = VENTANA_GRAFICAS returns the handle to a new VENTANA_GRAFICAS or the handle to
%      the existing singleton*.
%
%      VENTANA_GRAFICAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VENTANA_GRAFICAS.M with the given input arguments.
%
%      VENTANA_GRAFICAS('Property','Value',...) creates a new VENTANA_GRAFICAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ventana_graficas_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ventana_graficas_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ventana_graficas

% Last Modified by GUIDE v2.5 07-Jun-2009 18:34:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ventana_graficas_OpeningFcn, ...
                   'gui_OutputFcn',  @ventana_graficas_OutputFcn, ...
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


% --- Executes just before ventana_graficas is made visible.
function ventana_graficas_OpeningFcn(hObject, eventdata, handles, varargin)

t=varargin{1};
MEDIA=varargin{2};

axes(handles.axes_grafica),plot(t,MEDIA)

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ventana_graficas (see VARARGIN)

% Choose default command line output for ventana_graficas
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ventana_graficas wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ventana_graficas_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
