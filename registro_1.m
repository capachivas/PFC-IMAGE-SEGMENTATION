function registro_1
clear all
%estas rutas las cogera el automaticamente en la interfaz grafica!!!
ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO_DCP\DATOS_PACIENTES\VIDEO_COREGISTRADOS\ciliorot1n.avi';
fragmento_video= aviread (ruta);%cargo todo el video
fragmento_video_INFO= aviinfo (ruta);
max=fragmento_video_INFO(1,1).NumFrames;
frame_1=fragmento_video(1,1).cdata; %frame k-1 ( en este caso el frame 1 )
frame_1=mat2gray(frame_1,[150 255]); %130-255
frame_1=uint8(frame_1*255);

%especifico ROI
[frame_1 region]=imcrop(frame_1);

corr=zeros(length(max-1));%almacena la correlacion entre imagenes sucesivas

frame_k_t=frame_1;  %sera el primer frame al inicio 
frame_k_1=frame_1;

ANGULO=0;

 mov = avifile('ahora.avi');
 mov.compression='none';
 figure(1),imshow(frame_1)
 mov = addframe(mov,getframe);
 
k=2;
while k<=300
        fragmento_video= aviread (ruta);%cargo todo el video
        frame_k=fragmento_video(1,k).cdata; %frame k   
        frame_k=mat2gray(frame_k,[150 255]);
        frame_k=uint8(frame_k*255);
        frame_k=imcrop(frame_k,region);

        
        corr(k-1)=corr2(frame_k_1,frame_k); % calculo la correlacion entre frame k y frame k-1 para ver cuanto de parecidas son dos imagenes
         

        frame_k_g=imrotate(frame_k,ANGULO,'bilinear');
             
             %MODELO GRUESO-FINO
                     
                [im,theta_0,In,Jn,K]=image_registr_MI_COR(frame_1,frame_k_g,frame_k,[-1 1]);
                fin=theta_0;
                ini=0;

             while (fin-ini)>0.1
        
                      [frame_k_t,theta,In,Jn,K]=image_registr_MI_COR(frame_1,frame_k_g,frame_k,[ini fin]);
                   
                     if theta==ini
                         fin=(fin+ini)/2;
                     else
                        ini=(fin+ini)/2;
                     end

             end
        
             [frame_k_t,theta,In,Jn,K]=image_registr_MI_COR(frame_1,frame_k_g,frame_k,[ini fin]);
              
            
            ANGULO=ANGULO+theta; % voy sumandole el giro entre frames
            figure(1),imshow(frame_k_t),hold on
            title([' frame ' num2str(k) ' correlacion ' num2str(corr(k-1))])
            mov = addframe(mov,getframe);
            k=k+1;
end
mov=close(mov);