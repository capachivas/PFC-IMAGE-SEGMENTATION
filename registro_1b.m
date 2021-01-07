function registro_1b
clear all
%estas rutas las cogera el automaticamente en la interfaz grafica!!!
ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO\PFC_Discinesia_ciliar_primaria\DATOS_PACIENTES\Dr.Armengot\Batida_ciliar_normal.avi';
fragmento_video= aviread (ruta);%cargo todo el video
fragmento_video_INFO= aviinfo (ruta);
max=fragmento_video_INFO(1,1).NumFrames;
frame_1=fragmento_video(1,1).cdata; %frame k-1 ( en este caso el frame 1 )
frame_1=imadjust(frame_1);

%especifico ROI
[frame_1 region]=imcrop(frame_1);

corr=zeros(length(max-1));%almacena la correlacion entre imagenes sucesivas

frame_k_t=frame_1;  %sera el primer frame al inicio 
frame_k_1=frame_1;

ANGULO=0;

 mov = avifile('corrrahora.avi'); 
 mov.compression='none';
 figure(1),imshow(frame_1)
 mov = addframe(mov,getframe);
 
k=2;
while k<=150
        fragmento_video= aviread (ruta);%cargo todo el video
        frame_k=fragmento_video(1,k).cdata; %frame k   
        frame_k=imadjust(frame_k);
        frame_k=imcrop(frame_k,region);

        
        corr(k-1)=corr2(frame_1,frame_k); % calculo la correlacion entre frame k y frame k-1 para ver cuanto de parecidas son dos imagenes
         

        frame_k_g=imrotate(frame_k,ANGULO,'bilinear');
             
             %MODELO GRUESO-FINO
                     
                     %segundo nivel positivos
                     [im,rot,theta_1A,In,Jn,K]=image_registr_MI_COR_sinbase(frame_1,frame_k_g,frame_k,[0.1:0.5:2]);
                     
                     %tercer nivel positivos
                     [im,rot,theta_2A,In,Jn,K]=image_registr_MI_COR_sinbase(frame_1,frame_k_g,frame_k,[theta_1A:0.1:theta_1A+0.5]);
                     
                     %cuarto nivel positivos
                     [frame_k_t,p,theta,I,J,K]=image_registr_MI_COR_sinbase(frame_1,frame_k_g,frame_k,[theta_2A:0.05:theta_2A+0.1]);   

             
            ANGULO=ANGULO+theta; % voy sumandole el giro entre frames
            figure(1),imshow(frame_k_t),hold on
            title([' frame ' num2str(k) ' correlacion con frame 1 ' num2str(corr(k-1))])
            mov = addframe(mov,getframe);
            k=k+1;
end
mov=close(mov);