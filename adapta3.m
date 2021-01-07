function adapta3
clear all
%estas rutas las cogera el automaticamente en la interfaz grafica!!!
ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO_DCP\DATOS_PACIENTES\Dr.Armengot\Batida_ciliar_normal.avi';
fragmento_video= aviread (ruta);%cargo todo el video
fragmento_video_INFO= aviinfo (ruta);
max=fragmento_video_INFO(1,1).NumFrames;
frame_1=fragmento_video(1,1).cdata; %frame k-1 ( en este caso el frame 1 )
frame_1x=frame_1;%original

frame_1=imadjust(frame_1); 
frame_1=mat2gray(frame_1,[130 255]);
%frame_1=uint8(frame_1*255);

%especifico ROI
[frame_1x region]=imcrop(frame_1x);
frame_1=imcrop(frame_1,region);%original

corr=zeros(length(max-1));%almacena la correlacion entre imagenes sucesivas

frame_k_t=frame_1;  %sera el primer frame al inicio 
frame_k_1=frame_1;

ANGULO=0;

 mov = avifile('ahora2.avi');
 mov.compression='none';
 figure(1),imshow(frame_1x)
 
 mov = addframe(mov,getframe);
 
k=2;
while k<=80
        %CARGO FRAME K
        fragmento_video= aviread (ruta);%cargo todo el video
        frame_k=fragmento_video(1,k).cdata; %frame k  
        
        %CREO COPIA ORIGINAL AL FRAME K
        frame_kx=frame_k;
        
        %PREPROCESADO PARA CORRELACION
        frame_k=imadjust(frame_k); 
        frame_k=mat2gray(frame_k,[130 255]);
        %frame_k=uint8(frame_k*255);
        
        %ROI
        frame_kx=imcrop(frame_kx,region);
        frame_k=imcrop(frame_k,region);

        %CORR
        corr(k-1)=corr2(frame_k_1,frame_k); % calculo la correlacion entre frame k y frame k-1 para ver cuanto de parecidas son dos imagenes
        
        frame_k_gx=imrotate(frame_kx,ANGULO,'bilinear');%original<---se difumina
        
        
        frame_k_g=imrotate(frame_k,ANGULO,'bilinear');%no puedo filtrarla!!!es la base del coregistro esta transformacion
        
             %MODELO GRUESO-FINO

%     if k==1 | k==2 | k==3
%                      
%                      segundo nivel positivos
%                      [im,im,theta_1A,In,Jn,K]=image_registr_MI_COR_o(frame_kx,frame_k_gx,frame_k_t,frame_k_g,frame_k,[-0.5:0.5:2]);
%                      
%                      tercer nivel positivos
%                      [im,im,theta_2A,In,Jn,K]=image_registr_MI_COR_o(frame_kx,frame_k_gx,frame_k_t,frame_k_g,frame_k,[theta_1A:0.1:theta_1A+0.5]);
%                      
%                      cuarto nivel positivos
%                      [frame_k_tx,frame_k_t,theta,I,J,K]=image_registr_MI_COR_o(frame_kx,frame_k_gx,frame_k_t,frame_k_g,frame_k,[theta_2A:0.05:theta_2A+0.1]);   
% 
%     else
                     
                %[im,im,theta_0,In,Jn,K]=image_registr_MI_COR_o(frame_kx,frame_k_gx,frame_1,frame_k_g,frame_k,[-1 1]);
            
                  %if theta_0>=0
                     
                     %segundo nivel positivos
                     [frame_k_tx,theta_1A,In,Jn,K]=image_registr_MI_COR_o(frame_kx,frame_k_gx,frame_1,frame_k_g,frame_k,[-0.5:0.5:2]);
                     
                     %tercer nivel positivos
                     [frame_k_tx,theta_2A,In,Jn,K]=image_registr_MI_COR_o(frame_kx,frame_k_gx,frame_1,frame_k_g,frame_k,[theta_1A:0.1:theta_1A+0.5]);
                     
                     %cuarto nivel positivos
                     [frame_k_tx,theta,I,J,K]=image_registr_MI_COR_o(frame_kx,frame_k_gx,frame_1,frame_k_g,frame_k,[theta_2A:0.05:theta_2A+0.1]);   

%                   else
%                     
%                     %segundo nivel negativos
%                     [im,im,theta_1B,In,Jn,K]=image_registr_MI_COR_o(frame_kx,frame_k_gx,frame_1,frame_k_g,frame_k,[-2:0.5:-0.1]);
%                     
%                      %tercer nivel negativos
%                      [im,im,theta_2B,In,Jn,K]=image_registr_MI_COR_o(frame_kx,frame_k_gx,frame_1,frame_k_g,frame_k,[theta_1B:0.1:theta_1B+0.5]);
%                      
% 
%                      %cuarto nivel negativos
%                      [frame_k_tx,frame_k_t,theta,I,J,K]=image_registr_MI_COR_o(frame_kx,frame_k_gx,frame_1,frame_k_g,frame_k,[theta_2B:0.05:theta_2B+0.05]);  
% 
%                   end
             
%    end
             
            ANGULO=ANGULO+theta; % voy sumandole el giro entre frames
            figure(1),imshow(frame_k_tx),hold on
            title([' frame ' num2str(k) ' correlacion ' num2str(corr(k-1))])
            mov = addframe(mov,getframe);
            k=k+1;
end
mov=close(mov);
