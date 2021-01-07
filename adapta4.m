function adapta4
clear all
%estas rutas las cogera el automaticamente en la interfaz grafica!!!
ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO\PFC_Discinesia_ciliar_primaria\DATOS_PACIENTES\Dr.Armengot\Batida_ciliar_normal.avi';
fragmento_video= aviread (ruta);%cargo todo el video
fragmento_video_INFO= aviinfo (ruta);
max=fragmento_video_INFO(1,1).NumFrames;
frame_1=fragmento_video(1,1).cdata; %frame k-1 ( en este caso el frame 1 )

%especifico ROI
[frame_1 region]=imcrop(frame_1);
frame_1=imresize(frame_1,2);

 mov = avifile('corrrahora.avi');
 mov.compression='none';
 figure(1),imshow(frame_1)
 mov = addframe(mov,getframe);
 
k=2;
while k<=30
        fragmento_video= aviread (ruta);%cargo todo el video
        frame_k=fragmento_video(1,k).cdata; %frame k   
        frame_k=imcrop(frame_k,region);
        frame_k=imresize(frame_k,2);
             
            figure(1),imshow(frame_k),hold on
            title([' frame ' num2str(k) ' correlacion con frame 1 ' num2str(corr(k-1))])
            mov = addframe(mov,getframe);
            k=k+1;
end
mov=close(mov);