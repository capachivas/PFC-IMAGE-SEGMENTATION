function angencil

% ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO_DCP\DATOS_PACIENTES\VIDEO_COREGISTRADOS\ciliorot1n.avi';
% ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO_DCP\DATOS_PACIENTES\VIDEO_COREGISTRADOS\ciliorot2n.avi';
% ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO_DCP\DATOS_PACIENTES\VIDEO_COREGISTRADOS\normal.avi';
% ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO_DCP\DATOS_PACIENTES\VIDEO_COREGISTRADOS\cilio6.avi';
ruta='O:\DADES\PROYECTO_DCP\DATOS_PACIENTES\VIDEO_COREGISTRADOS\celula1000n.avi';

[ROIVAL,zona_ciliar]=saca_ROIVAL(ruta);

%[ROIVALn]=quitaframes_ROIVAL(ROIVAL,2,ruta,zona_ciliar,'cilioanal.avi');
%crea un video con ese nombre en directorio matlab

analisis_ROIVAL(ROIVAL,'cilioanal.avi');