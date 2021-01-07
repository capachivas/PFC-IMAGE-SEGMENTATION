function varargout = parametros(varargin)
% PARAMETROS M-file for parametros.fig
%      PARAMETROS, by itself, creates a new PARAMETROS or raises the existing
%      singleton*.
%
%      H = PARAMETROS returns the handle to a new PARAMETROS or the handle to
%      the existing singleton*.
%
%      PARAMETROS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARAMETROS.M with the given input arguments.
%
%      PARAMETROS('Property','Value',...) creates a new PARAMETROS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before parametros_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to parametros_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help parametros

% Last Modified by GUIDE v2.5 28-Oct-2008 15:59:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @parametros_OpeningFcn, ...
                   'gui_OutputFcn',  @parametros_OutputFcn, ...
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


% --- Executes just before parametros is made visible.
function parametros_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to parametros (see VARARGIN)

%la llamare con unos parametros determinados que coge de la entrada
handles.parametros_actuales=varargin{1};

% deteccion bordes por canny
handles.umbral_canny(1)=handles.parametros_actuales(1);
handles.umbral_canny(2)=handles.parametros_actuales(2); 
handles.sigma_canny=handles.parametros_actuales(3);

%calculo del GVF ( Gradient Vector Flow )
handles.param_mu=handles.parametros_actuales(4);
handles.iters_gvf=handles.parametros_actuales(5);

% Parametros snakes
handles.delta=handles.parametros_actuales(6);
handles.alfa=handles.parametros_actuales(7);
handles.beta=handles.parametros_actuales(8);
handles.gamma=handles.parametros_actuales(9);
handles.kappa=handles.parametros_actuales(10);
handles.presion=handles.parametros_actuales(11);
handles.iters_snakedeform=handles.parametros_actuales(12);
handles.multiplicador_iters_snake=handles.parametros_actuales(13);

handles.filt_mediana=handles.parametros_actuales(14);
handles.umbral_correlacion=handles.parametros_actuales(15);

%poner en cada textbox su correspondiente valor
set(handles.edit_inf,'String',num2str(handles.parametros_actuales(1)));
set(handles.edit_sup,'String',num2str(handles.parametros_actuales(2))); 
set(handles.edit_sigma,'String',num2str(handles.parametros_actuales(3)));
set(handles.edit_mu,'String',num2str(handles.parametros_actuales(4)));
set(handles.edit_iter,'String',num2str(handles.parametros_actuales(5)));

set(handles.edit_delta,'String',num2str(handles.parametros_actuales(6)));
set(handles.edit_alpha,'String',num2str(handles.parametros_actuales(7)));
set(handles.edit_beta,'String',num2str(handles.parametros_actuales(8)));
set(handles.edit_gamma,'String',num2str(handles.parametros_actuales(9)));
set(handles.edit_kappa,'String',num2str(handles.parametros_actuales(10)));
set(handles.edit_kappap,'String',num2str(handles.parametros_actuales(11)));
set(handles.edit_iteraciones,'String',num2str(handles.parametros_actuales(12)));
set(handles.edit_miter,'String',num2str(handles.parametros_actuales(13)));

set(handles.edit_tamgaus,'String',num2str(handles.parametros_actuales(14)));
set(handles.edit_vargaus,'String',num2str(handles.parametros_actuales(15)));
set(handles.edit_umbral_correlacion,'String',num2str(handles.parametros_actuales(16)));

handles.parametros_nuevos=handles.parametros_actuales;
% Choose default command line output for parametros
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes parametros wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = parametros_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output1;
varargout{2} = handles.output2;


function edit_alpha_Callback(hObject, eventdata, handles)
handles.parametros_nuevos(9)=str2double(get(hObject,'String'));
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_beta_Callback(hObject, eventdata, handles)
handles.parametros_nuevos(10)=str2double(get(hObject,'String'));
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_beta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_gamma_Callback(hObject, eventdata, handles)
handles.parametros_nuevos(11)=str2double(get(hObject,'String'));
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_gamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_kappa_Callback(hObject, eventdata, handles)
handles.parametros_nuevos(12)=str2double(get(hObject,'String'));
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_kappa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_kappa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_delta_Callback(hObject, eventdata, handles)
handles.parametros_nuevos(8)=str2double(get(hObject,'String'));
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_delta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_delta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_kappap_Callback(hObject, eventdata, handles)
handles.parametros_nuevos(13)=str2double(get(hObject,'String'));
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_kappap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_kappap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_iteraciones_Callback(hObject, eventdata, handles)
handles.parametros_nuevos(14)=str2double(get(hObject,'String'));
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_iteraciones_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_iteraciones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_miter_Callback(hObject, eventdata, handles)
handles.parametros_nuevos(15)=str2double(get(hObject,'String'));
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_miter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_miter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_mu_Callback(hObject, eventdata, handles)
handles.parametros_nuevos(6)=str2double(get(hObject,'String'));
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_mu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_iter_Callback(hObject, eventdata, handles)
handles.parametros_nuevos(7)=str2double(get(hObject,'String'));
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_iter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_sup_Callback(hObject, eventdata, handles)
handles.parametros_nuevos(2)=str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_sup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_inf_Callback(hObject, eventdata, handles)
handles.parametros_nuevos(1)=str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_inf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_inf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_sigma_Callback(hObject, eventdata, handles)
handles.parametros_nuevos(3)=str2double(get(hObject,'String'));
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_tamgaus_Callback(hObject, eventdata, handles)
handles.parametros_nuevos(17)=str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_tamgaus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tamgaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_umbral_correlacion_Callback(hObject, eventdata, handles)
handles.parametros_nuevos(18)=str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_umbral_correlacion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_umbral_correlacion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in cancelar_but.
function cancelar_but_Callback(hObject, eventdata, handles)
handles.output1=handles.figure1;
handles.output2=handles.parametros_actuales;
guidata(hObject,handles);
uiresume;

% --- Executes on button press in restaurar_but.
function restaurar_but_Callback(hObject, eventdata, handles)

% deteccion bordes por canny
handles.umbral_canny(1)=handles.parametros_actuales(1);
handles.umbral_canny(2)=handles.parametros_actuales(2); 
handles.sigma_canny=handles.parametros_actuales(3);

%calculo del GVF ( Gradient Vector Flow )
handles.param_mu=handles.parametros_actuales(4);
handles.iters_gvf=handles.parametros_actuales(5);

% Parametros snakes
handles.delta=handles.parametros_actuales(6);
handles.alfa=handles.parametros_actuales(7);
handles.beta=handles.parametros_actuales(8);
handles.gamma=handles.parametros_actuales(9);
handles.kappa=handles.parametros_actuales(10);
handles.presion=handles.parametros_actuales(11);
handles.iters_snakedeform=handles.parametros_actuales(12);
handles.multiplicador_iters_snake=handles.parametros_actuales(13);

%otros parametros
handles.filt_mediana=handles.parametros_actuales(14);
handles.gaus_var=handles.parametros_actuales(15);
handles.umbral_correlacion=handles.parametros_actuales(16);

set(handles.edit_inf,'String',num2str(handles.parametros_actuales(1)));
set(handles.edit_sup,'String',num2str(handles.parametros_actuales(2))); 
set(handles.edit_sigma,'String',num2str(handles.parametros_actuales(3)));
set(handles.edit_mu,'String',num2str(handles.parametros_actuales(4)));
set(handles.edit_iter,'String',num2str(handles.parametros_actuales(5)));
set(handles.edit_delta,'String',num2str(handles.parametros_actuales(6)));
set(handles.edit_alpha,'String',num2str(handles.parametros_actuales(7)));
set(handles.edit_beta,'String',num2str(handles.parametros_actuales(8)));
set(handles.edit_gamma,'String',num2str(handles.parametros_actuales(9)));
set(handles.edit_kappa,'String',num2str(handles.parametros_actuales(10)));
set(handles.edit_kappap,'String',num2str(handles.parametros_actuales(11)));
set(handles.edit_iteraciones,'String',num2str(handles.parametros_actuales(12)));
set(handles.edit_miter,'String',num2str(handles.parametros_actuales(13)));
set(handles.edit_tamgaus,'String',num2str(handles.parametros_actuales(14)));
set(handles.edit_vargaus,'String',num2str(handles.parametros_actuales(15)));
set(handles.edit_umbral_correlacion,'String',num2str(handles.parametros_actuales(16)));

guidata(hObject,handles);

% --- Executes on button press in guarysalir_but.
function guarysalir_but_Callback(hObject, eventdata, handles)
handles.output1=handles.figure1;
handles.output2=handles.parametros_nuevos;
guidata(hObject,handles);
uiresume;

function edit_vargaus_Callback(hObject, eventdata, handles)
handles.parametros_nuevos(5)=str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_vargaus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vargaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


