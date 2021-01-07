function adapta_p
clear all
%estas rutas las cogera el automaticamente en la interfaz grafica!!!
ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO\PFC_Discinesia_ciliar_primaria\DATOS_PACIENTES\Dr.Armengot\Batida_ciliar_normal.avi';
fragmento_video= aviread (ruta);%cargo todo el video

fragmento_video_INFO= aviinfo (ruta);
max=fragmento_video_INFO(1,1).NumFrames;
frame_1=fragmento_video(1,1).cdata; %frame k-1 ( en este caso el frame 1 )
frame_1=imadjust(frame_1);
%frame_1=imresize(frame_1,1.5);
%especifico ROI
[frame_1 region]=imcrop(frame_1);

%[x1,y1]=frameini2(frame_1,100,1,1.8,1.3,-1,0.1); %se adapta al primer frame y extrae su contorno(x,y) -->MEJORARLO PARA QUE EN MAS ENTORNOS SE QUEDE ENGANCHADO

corr=zeros(length(max-1));%almacena la correlacion entre imagenes sucesivas

% x=x1;
% y=y1;

frame_k_t=frame_1;  %sera el primer frame al inicio 
frame_k_1=frame_1;

%mov = avifile('cell3.avi');
%mov.compression='none';
figure(1),hold on,imshow(frame_1)
%mov = addframe(mov,getframe);


%parece que el giro de la funcion va a su bola siempre gira un grado y pico
%y yasta-->mas adaptatividad
for k=2:50
        %la tengo que cortar de nuevo con la ROI de antes (la celula seguira dentro)
        fragmento_video= aviread (ruta);%cargo todo el video
        frame_k=fragmento_video(1,k).cdata; %frame k   
        frame_k=imcrop(frame_k,region);
        
        %sale imagen frame_k_t en blanco!! y negro
        %corr(k-1)=corr2(frame_k_1,frame_k); % calculo la correlacion entre frame k y frame k-1 para ver cuanto de parecidas son dos imagenes
        
        %segmenta el contorno para cada frame
%                  if corr(k-1)<0.98 %la celula gira muy deprisa y debo ajustarme rapidamente a su movimiento
%                             [x,y]=framek2(frame_k_t,k,x1,y1,10,0.5,15,1.3,-2,0.1);  
%                 else
%                             [x,y]=framek2(frame_k_t,k,x1,y1,5,0.5,2,1.3,-1,0.01); %le pasare el frame_k_t, cuando lo tenga
%                  end
                 
           %estimacion angulo de giro entre dos imagenes a partir del contorno 
           %lo mejor es saber el angulo exacto que varian entre frames para
           %darselo como estimacion a la funcion que coregistra
           %saber el angulo que gira en dos casos: corr<0.98 y en el normal
           %que seran los dos casos que diferenciare de momento

            frame_k=imadjust(frame_k);%siempre ajusto el contraste en el siguiente frame  
            
            if k>2
                [h,frame_k_t,theta,I,J]=image_registr_MI(frame_1,frame_k,[theta:0.05:k+theta]); %<--
            else
                [h,frame_k_t,theta,I,J]=image_registr_MI(frame_1,frame_k,[0.01:0.01:2]); %<--
            end
            
            frame_k_t=uint8(frame_k_t);
            %figure,subplot(211),imshow(frame_k_t),title(['FRAME ' num2str(k) ' MAS CONTORNO']),subplot(212),imshow(frame_1)
            figure(1),imshow(frame_k_t),title(['frame' num2str(k)])
            %mov = addframe(mov,getframe);
end
%mov=close(mov);
