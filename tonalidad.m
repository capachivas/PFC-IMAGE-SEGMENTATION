function tonalidad
clear all
%estas rutas las cogera el automaticamente en la interfaz grafica!!!
ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO\PFC_Discinesia_ciliar_primaria\DATOS_PACIENTES\VIDEO_COREGISTRADOS\coregistra_80f_imadjust.avi';
fragmento_video= aviread (ruta);%cargo todo el video
fragmento_video_INFO= aviinfo (ruta);
max=fragmento_video_INFO(1,1).NumFrames;


mov = avifile('cor_tonalidad_corregida.avi');
mov.compression='none';

k=2;
while k<=max
frame_k=fragmento_video(1,k).cdata; %frame k-1 ( en este caso el frame 1 )
frame_k=frame_k(:,:,1);
%frame_k=histeq(frame_k); %deshacer la transformacion de intensidad
figure(1),imshow(frame_k),hold on
mov = addframe(mov,getframe);
k=k+1;
end
