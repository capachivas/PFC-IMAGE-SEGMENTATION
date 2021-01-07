function varargout = interfaz(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @first_OpeningFcn, ...
                   'gui_OutputFcn',  @first_OutputFcn, ...
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

% FUNCION QUE SE EJECUTA AL INICIO DE ABRIR EL INTERFAZ
function first_OpeningFcn(hObject, eventdata, handles, varargin)

clc %INVESTIGAR COMO IR AL DIRECTORIO MATLAB SIN IMPORTAR EN QUE CARPETA ESTE (NO HAYA DEPENDENCIA CON DIFERENTES ORDENADORES)
%variables globales
handles.ruta='';
handles.posicion=1;
handles.frame=1;
handles.maximo=1;
handles.PathArchivo='';
handles.NombreArchivo='';
handles.info_video='';
handles.output = hObject;

%parametros adaptacion - valores por defecto que apareceran al inicio
handles.umbral_correlacion=0.98; 
handles.filt_gaussiano=20; 
handles.gaus_var=2;

%Parametros edge 
handles.umbral_canny=[0 0.2];
handles.sigma_canny=0.4;

%Parametros GVFc
handles.param_mu=0.1;
handles.iters_gvf=15;

%Parametros snake
handles.delta=0.1; 
handles.alfa=1;
handles.beta=1.8;
handles.gamma=1.3;
handles.kappa=-1;
handles.presion=0.1;
handles.iteraciones=50;
handles.multiplicador_iters_snake=1;

% %otros parametros
% handles.finf=70;
% handles.fsup=90;

handles.param_edgemap=[handles.umbral_canny(1), handles.umbral_canny(2), handles.sigma_canny];
    
handles.param_gvfc=[handles.param_mu, handles.iters_gvf];

handles.param_snakes=[handles.delta, handles.alfa, handles.beta, handles.gamma, ...
        handles.kappa, handles.presion, handles.iteraciones, handles.multiplicador_iters_snake];
    
handles.otros_param=[handles.filt_gaussiano, handles.gaus_var, handles.umbral_correlacion];


%dejar botones que no se puedan tocar aun en off

set(handles.segmentar,'Enable','off');
set(handles.coregistrar,'Enable','off');
set(handles.analisis,'Enable','off');
set(handles.Info_video,'Enable','off');
set(handles.zoomciliar,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = first_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function cajatexto_Callback(hObject, eventdata, handles)
handles.frame=str2double(get(hObject,'String'));
video = aviread (handles.ruta,handles.frame);%solo cargo ese frame
handles.maximo=handles.info_video.NumFrames; %maximo numero de frames
imshow(imresize(video(1,1).cdata,2));
set(handles.cajatexto,'String',''); %lo pongo en blanco de nuevo
set(handles.estatico,'String',handles.frame);%pongo el numero de frame en la caja de texto
%mover la scrollbar
handles.posicion=handles.frame;
set(handles.scrollbar,'Value',handles.posicion); %coloco la posicion del slider donde toca
guidata(hObject,handles); %guardo la posicion

function cajatexto_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

% --- Executes on slider movement.
function scrollbar_Callback(hObject, eventdata, handles) %slider
    handles.posicion=get(handles.scrollbar,'Value');
    video = aviread (handles.ruta,fix(handles.posicion)); %solo cargo ese frame

if (handles.posicion)<=1
  set(handles.estatico,'String',1); %solo le paso la parte entera, son frames!!
  imshow(imresize(video(1,1).cdata,2)); %me voy al frame 1
else  
  set(handles.estatico,'String',fix(handles.posicion)); %solo le paso la parte entera, son frames!!
  %imshow(video(1,fix((handles.posicion)*(handles.maximo))).cdata); %me voy al frame ese
  imshow(imresize(video(1,1).cdata,2)); %me voy al frame ese
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function scrollbar_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor',[.9 .9 .9]);
    end

% --- Executes on button press in CargaVideo.
function CargaVideo_Callback(hObject, eventdata, handles)
% hObject    handle to CargaVideo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try

dir_actual=cd; %guardo el directorio actual de trabajo 

%SE DONDE ESTA EL DIRECTORIO DE VIDEOS, EN OTRO ORDENADOR LO BUSCO MANUAL

cd ..
%cd PROYECTO_DCP
%cd DATOS_PACIENTES

dir_videos=cd; %guardo el directorio donde estan todos los videos

%cargo video y me quedo con su path y nombre
[handles.NombreArchivo,handles.PathArchivo] = uigetfile({'*.avi','Archivos de video (*.avi)'},'Selecciona un video');

if  handles.PathArchivo==0  %si le doy a cancelar handles.PathArchivo=0 no hago nada
    
else  %no cancelo
    handles.ruta=strcat(handles.PathArchivo,handles.NombreArchivo);
    
    %carga video
    video=aviread(handles.ruta,1);
    handles.info_video=aviinfo(handles.ruta);
    handles.maximo=handles.info_video.NumFrames; %maximo numero de frames
    axes(handles.axes_video),imshow(imresize(video(1,1).cdata,2));
    set(handles.cajatexto,'String',1); %lo pongo en el primer frame
    
    %cada vez que cargo video pongo el slider apuntando al primer frame
    handles.posicion=1;
    set(handles.estatico,'String',1); %solo le paso la parte entera, son frames!!
    
    %Configuracion del slider
    set(handles.scrollbar,'Min',1);
    set(handles.scrollbar,'Max',handles.maximo);
    set(handles.scrollbar,'SliderStep',[1/handles.maximo 1/handles.maximo]);
    set(handles.scrollbar,'Value',1); %coloco la posicion del slider al inicio al cargar cada video     
    
    %activo los botones para actuar sobre el video ya cargado
    set(handles.segmentar,'Enable','on');
    set(handles.coregistrar,'Enable','on');    
    set(handles.analisis,'Enable','on');
    set(handles.Info_video,'Enable','on');
    set(handles.zoomciliar,'Enable','on');
end

catch
end
guidata(hObject,handles); %actualizar siempre despues de modificar variables globales!!!!!

 cd(dir_actual) %ir al directorio previo almacenado

% --- Executes on button press in segmentar.
function segmentar_Callback(hObject, eventdata, handles)

adapta_final(handles.ruta,handles.iteraciones,handles.alfa,handles.beta,handles.gamma,handles.kappa,handles.presion,handles.umbral_correlacion,handles.axes_video);

% --- Executes on button press in Info_video.
function Info_video_Callback(hObject, eventdata, handles)
% hObject    handle to Info_video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Muestra la informacion del video
try
    i=handles.info_video;
    figura=ventana(handles.NombreArchivo,i.FileSize,i.FileModDate,i.NumFrames,i.FramesPerSecond,i.Width,i.Height,i.ImageType,i.VideoCompression,i.Quality);
    close(figura);
catch
    disp('La funcion "ventana.m" presenta algun problema o no se ha cerrado la ventana con el boton Aceptar"');
end
guidata(hObject,handles);

function Editar_etiqueta_Callback(hObject, eventdata, handles)
% hObject    handle to Editar_etiqueta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function Parametros_Callback(hObject, eventdata, handles)

%Editar los parametros del programa
parametros_actuales=[handles.param_edgemap, handles.param_gvfc, handles.param_snakes, handles.otros_param];
try  
%si cambio los valores en la ventana de parametros se le pasaran estos no los por defecto    
[figura,parametros_nuevos]=parametros(parametros_actuales);
handles.umbral_canny(1)=parametros_nuevos(1);
handles.umbral_canny(2)=parametros_nuevos(2);
handles.sigma_canny=parametros_nuevos(3);
handles.param_mu=parametros_nuevos(4);
handles.iters_gvfc=parametros_nuevos(5);
handles.delta=parametros_nuevos(6);
handles.alfa=parametros_nuevos(7);
handles.beta=parametros_nuevos(8);
handles.gamma=parametros_nuevos(9);
handles.kappa=parametros_nuevos(10);
handles.kappap=parametros_nuevos(11);
handles.iteraciones=parametros_nuevos(12);
handles.multiplicador_iters_snake=parametros_nuevos(13);
handles.filt_gaussiano=parametros_nuevos(14);
handles.gaus_var=parametros_nuevos(15);
handles.umbral_correlacion=parametros_nuevos(16);

close(figura);

handles.param_edgemap=[handles.umbral_canny(1), handles.umbral_canny(2), handles.sigma_canny];
    
handles.param_gvfc=[handles.param_mu, handles.iters_gvf];

handles.param_snakes=[handles.delta, handles.alfa, handles.beta, handles.gamma, ...
        handles.kappa, handles.presion, handles.iteraciones, handles.multiplicador_iters_snake];
    
handles.otros_param=[handles.filt_gaussiano, handles.gaus_var, handles.umbral_correlacion];

catch
end
guidata(hObject,handles);

% --- Executes on button press in coregistrar.
function coregistrar_Callback(hObject, eventdata, handles)

% --- Executes on button press in analisis.
function analisis_Callback(hObject, eventdata, handles)
set(handles.segmentar,'Enable','off');
set(handles.coregistrar,'Enable','off');
set(handles.analisis,'Enable','off');
set(handles.Info_video,'Enable','off');
set(handles.zoomciliar,'Enable','off');

%analisis_cilios2(handles.ruta,handles.axes_video,handles.finf,handles.fsup)-->hacer
analisis_cilios2(handles.ruta,handles.axes_video)

% --- Executes on button press in zoomciliar.
function zoomciliar_Callback(hObject, eventdata, handles)
zoom_ciliar(handles.ruta,handles.axes_video)

