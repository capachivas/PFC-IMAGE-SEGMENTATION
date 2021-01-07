function correl=analisis_rot_corr;

%si corr(k)>0.98 iras cogiendo frames hasta que sea menor y tendras un
%video
ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO\PFC_Discinesia_ciliar_primaria\DATOS_PACIENTES\VIDEO_COREGISTRADOS\ciliorot1n.avi';

fragmento_video= aviread (ruta,1);

fragmento_video_INFO= aviinfo (ruta);
frames=fragmento_video_INFO(1,1).NumFrames;
frame_1=fragmento_video(1,1).cdata; %frame 1
frame_1=frame_1(:,:,1);%solo quiero una componente
%figure(1),imshow(frame_1)

k=1;

frame_k_1=frame_1;

correl=zeros(length(frames-1));%almacena la correlacion entre imagenes sucesivas

while k<=frames
fragmento_video= aviread (ruta,k);
frame_k=fragmento_video(1,1).cdata; %frame k 
frame_k=frame_k(:,:,1);
correl(k)=corr2(frame_k_1,frame_k);
frame_k_1=frame_k;
%figure(1),imshow(frame_k),title(['CORRELACION ' num2str(corr(k))])
k=k+1;
end

        
