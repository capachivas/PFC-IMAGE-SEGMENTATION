function registro_2
clear all
%estas rutas las cogera el automaticamente en la interfaz grafica!!!
%ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO\PFC_Discinesia_ciliar_primaria\DATOS_PACIENTES\VIDEO_COREGISTRADOS\coregistra_100f_imadjust_sinbase_concomplementos.avi';
ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO\PFC_Discinesia_ciliar_primaria\DATOS_PACIENTES\VIDEO_COREGISTRADOS\coregistrar_1_80frames.avi';
fragmento_video= aviread (ruta);%cargo todo el video
fragmento_video_INFO= aviinfo (ruta);
max=fragmento_video_INFO(1,1).NumFrames;
frame_1=fragmento_video(1,1).cdata; %frame k-1 ( en este caso el frame 1 )
frame_1=frame_1(:,:,1);

%especifico ROI
[frame_1 region]=imcrop(frame_1);


corr=zeros(length(max-1));%almacena la correlacion entre imagenes sucesivas

frame_k_t=frame_1;  %sera el primer frame al inicio 
frame_k_1=frame_1;

ANGULO=0;
theta=0;

 mov = avifile('corregistrar_2.avi');
 mov.compression='none';
 figure(1),imshow(frame_1)
 mov = addframe(mov,getframe);
 
for k=2:80
        fragmento_video= aviread (ruta);%cargo todo el video
        frame_k=fragmento_video(1,k).cdata; %frame k  
        frame_k=frame_k(:,:,1);
        frame_k=imcrop(frame_k,region);

        corr(k-1)=corr2(frame_k_1,frame_k); % calculo la correlacion entre frame k y frame k-1 para ver cuanto de parecidas son dos imagenes
         
                 
        frame_k_g=imrotate(frame_k,ANGULO,'bilinear');
        %frame_k_t=registra(frame_1,frame_k); %por IM
        
             [im,rot,theta_0,In,Jn,K]=image_registr_MI_COR_sinbase(frame_1,frame_k_g,frame_k,[-1 1]);
            
                  if theta_0>=0
                     
                     %segundo nivel positivos
                     [im,rot,theta_1A,In,Jn,K]=image_registr_MI_COR_sinbase(frame_1,frame_k_g,frame_k,[0:0.1:0.5]);
                     theta_1A
                     %cuarto nivel positivos
                     [frame_k_t,rot,theta,I,J,K]=image_registr_MI_COR_sinbase(frame_1,frame_k_g,frame_k,[theta_1A:0.05:theta_1A+0.1]);   

                  else
                    
                    %segundo nivel negativos
                    [im,rot,theta_1B,In,Jn,K]=image_registr_MI_COR_sinbase(frame_1,frame_k_g,frame_k,[-0.5:0.1:0]);
                     

                     %cuarto nivel negativos
                     [frame_k_t,rot,theta,I,J,K]=image_registr_MI_COR_sinbase(frame_1,frame_k_g,frame_k,[theta_1B:0.05:theta_1B+0.1]);  

                  end

            ANGULO=ANGULO+theta; % voy sumandole el giro entre frames
            frame_k_1=imrotate(frame_k,ANGULO,'bilinear','crop');    
            figure(1),imshow(frame_k_t),hold on
            title([' frame ' num2str(k) ' correlacion ' num2str(corr(k-1))])
            mov = addframe(mov,getframe);
end
mov=close(mov);
