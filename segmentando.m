function segmentando
clear all
%ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO_DCP\DATOS_PACIENTES\Dr.Armengot\Batida_ciliar_normal.avi';
%ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO_DCP\DATOS_PACIENTES\Celulas mias (240909)\ciliomovil.avi';
ruta='C:\PROYECTO_DCP\DATOS_PACIENTES\Celulas mias (240909)\ciliomovil2.avi';

fragmento_video= aviread (ruta,1);%cargo todo el video

fragmento_video_INFO= aviinfo (ruta);
maximo=fragmento_video_INFO(1,1).NumFrames
frame_1=fragmento_video(1,1).cdata; %frame k-1 ( en este caso el frame 1 )
[frame_1 region]=imcrop(frame_1);

[x1,y1]=frameini2b(frame_1,50,1,1.8,1.3,-1,0.1); %se adapta al primer frame y extrae su contorno(x,y) 

corr=zeros(length(maximo-1));%almacena la correlacion entre imagenes sucesivas
 
frame_k_1=frame_1;

x0=x1;
y0=y1; %contorno del primer frame

mov = avifile('segmenta.avi');
mov.compression='none';
mov.fps=fragmento_video_INFO(1,1).FramesPerSecond;
figure(1),imshow(frame_1),hold on,plot([x1;x1(1,1)],[y1;y1(1,1)])
mov = addframe(mov,getframe);

k=2;

while k<=maximo
        %la tengo que cortar de nuevo con la ROI de antes (la celula seguira dentro)
        fragmento_video= aviread (ruta,k);%cargo todo el video
        frame_k=fragmento_video(1,1).cdata; %frame k   
        frame_k=imcrop(frame_k,region);
        
        corr(k-1)=corr2(frame_k_1,frame_k);
        
            %if corr(k-1)<0.98 %la celula gira muy deprisa y debo ajustarme rapidamente a su movimiento  
               %[x,y]=framek2b(frame_k,k,x1,y1,10,0.1,2,1.3,-2,0.1);  %alfa 82/v
             %else
                [x,y]=framek2b(frame_k,k,x1,y1,10,0.3,2,1.3,-1,0.01); %saca el contorno del frame transformado
            %end
            
            x1=x;
            y1=y; %actualizo el contorno actual
            
            frame_k_1=frame_k;
            k=k+1;
            figure(1),imshow(frame_k),hold on,plot([x;x(1,1)],[y;y(1,1)]),title(['frame ' num2str(k)])
            
            mov = addframe(mov,getframe);

end
mov=close(mov);
