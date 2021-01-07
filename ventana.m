function varargout = ventana(varargin)
% VENTANA M-file for ventana.fig
%      VENTANA, by itself, creates a new VENTANA or raises the existing
%      singleton*.
%
%      H = VENTANA returns the handle to a new VENTANA or the handle to
%      the existing singleton*.
%
%      VENTANA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VENTANA.M with the given input arguments.
%
%      VENTANA('Property','Value',...) creates a new VENTANA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ventana_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ventana_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ventana

% Last Modified by GUIDE v2.5 20-Oct-2008 09:41:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ventana_OpeningFcn, ...
                   'gui_OutputFcn',  @ventana_OutputFcn, ...
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


% --- Executes just before ventana is made visible.
function ventana_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ventana (see VARARGIN)

archivo=varargin(1);
tamano=varargin(2);
modificado=varargin(3);
frames=varargin(4);
fps=varargin(5);
ancho=varargin(6);
alto=varargin(7);
tipo=varargin(8);
compresion=varargin(9);
calidad=varargin(10); %parametros de entrada ( las caracteristicas de informacion del video )

set(handles.text_archivo,'String',archivo);
format short;
set(handles.text_tamano,'String',tamano);
set(handles.text_modificado,'String',modificado);
set(handles.text_frames,'String',frames);
set(handles.text_fps,'String',fps);
set(handles.text_ancho,'String',ancho);
set(handles.text_alto,'String',alto);
set(handles.text_tipoimagen,'String',tipo);
set(handles.text_compresion,'String',compresion);
set(handles.text_calidad,'String',calidad);

% Choose default command line output for ventana
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ventana wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ventana_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output1;


% --- Executes on button press in Boton_Aceptar.
function Boton_Aceptar_Callback(hObject, eventdata, handles)
% hObject    handle to Boton_Aceptar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output1=handles.figure1;
guidata(hObject,handles);
uiresume;

