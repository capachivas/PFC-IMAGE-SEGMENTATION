function crea_vid_corr(correl);

ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO\PFC_Discinesia_ciliar_primaria\DATOS_PACIENTES\VIDEO_COREGISTRADOS\ciliorot1n.avi';

%carga primer frame e informacion
fragmento_video_INFO= aviinfo (ruta);
frames=fragmento_video_INFO(1,1).NumFrames;

mov = avifile('cilios_anal.avi');
mov.compression='none';
mov.fps=25;

for k=53:89
    
fragmento_video= aviread (ruta,k);
frame=fragmento_video(1,1).cdata; %frame 1
frame=frame(:,:,1);%solo quiero una componente
figure(1),imshow(frame),title(['frame ' num2str(k)])
mov = addframe(mov,getframe);

end

mov=close(mov);

 
 

