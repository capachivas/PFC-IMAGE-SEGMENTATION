function selrect

%ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO_DCP\DATOS_PACIENTES\VIDEO_COREGISTRADOS\normal.avi';
ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO_DCP\DATOS_PACIENTES\VIDEO_COREGISTRADOS\celula1000n.avi';
fragmento_video= aviread (ruta,1);

%carga primer frame e informacion
fragmento_video_INFO= aviinfo (ruta);
frames=fragmento_video_INFO(1,1).NumFrames;
frame_1=fragmento_video(1,1).cdata; %frame 1
imshow(frame_1)
hold on
%x=[58 58 73 73 58]';
%y=[12 45 45 12 12]';

x=[31 31 41 41 31]';
y=[57 85 85 57 57]';
line(x,y)