function varargout = ventana_frecuencias(varargin)
% VENTANA_FRECUENCIAS M-file for ventana_frecuencias.fig
%      VENTANA_FRECUENCIAS, by itself, creates a new VENTANA_FRECUENCIAS or raises the existing
%      singleton*.
%
%      H = VENTANA_FRECUENCIAS returns the handle to a new VENTANA_FRECUENCIAS or the handle to
%      the existing singleton*.
%
%      VENTANA_FRECUENCIAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VENTANA_FRECUENCIAS.M with the given input arguments.
%
%      VENTANA_FRECUENCIAS('Property','Value',...) creates a new VENTANA_FRECUENCIAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ventana_frecuencias_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ventana_frecuencias_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ventana_frecuencias

% Last Modified by GUIDE v2.5 03-Jun-2009 19:08:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ventana_frecuencias_OpeningFcn, ...
                   'gui_OutputFcn',  @ventana_frecuencias_OutputFcn, ...
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


% --- Executes just before ventana_frecuencias is made visible.
function ventana_frecuencias_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ventana_frecuencias (see VARARGIN)

DFT=varargin{1};
DFT1=varargin{2};
DFT2=varargin{3};
Fs=varargin{4};
N=varargin{5};

%se debe acceder a los varargin mediante CORCHETES!!!!!

grid on,zoom on
axes(handles.axes_freq),subplot(311),
plot((-N/2:N/2)*(Fs/N),abs(DFT)./max(abs(DFT)),'g'),
xlabel(['TF1-TF2']),subplot(312),plot((-N/2:N/2)*(Fs/N),abs(DFT1)./max(abs(DFT1))),
xlabel(['TF1']),subplot(313),
plot((-N/2:N/2)*(Fs/N),abs(DFT2)./max(abs(DFT2)),'r'),xlabel(['TF2'])

% Plot single-sided amplitude spectrum.
title('Contenido espectral')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

% Choose default command line output for ventana_frecuencias
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ventana_frecuencias wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ventana_frecuencias_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



