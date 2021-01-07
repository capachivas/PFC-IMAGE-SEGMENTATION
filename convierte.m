function convierte

ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO_DCP\DATOS_PACIENTES\Dr.Armengot\Batida_ciliar_normal.avi'; 
%ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO\PFC_Discinesia_ciliar_primaria\DATOS_PACIENTES\Dr.Armengot\normal.avi';

fragmento_video= aviread (ruta,1);

fragmento_video_INFO=aviinfo (ruta);
maximo=fragmento_video_INFO(1,1).NumFrames;

mov=avifile('ciliorototo.avi');
mov.compression='none';
mov.fps=fragmento_video_INFO(1,1).FramesPerSecond;

for k=17:34
fragmento_video= aviread (ruta,k);%cargo todo el video
frame_k=fragmento_video(1,1).cdata; %frame k-1 ( en este caso el frame 1 )
frame_k=frame_k(:,:,1);
figure(1),imshow(frame_k),title(['FRAME ' num2str(k)])
mov = addframe(mov,getframe);
end
mov=close(mov);



