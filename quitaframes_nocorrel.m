function quitaframes_nocorrel(ruta)

%ANALIZA LAS INTENSIDADES DE LOS PIXELES Y QUITA AQUELLOS FRAMES QUE NO
%ESTAN EN EL RANGO

fragmento_video= aviread (ruta,1);

%carga primer frame e informacion
fragmento_video_INFO= aviinfo (ruta);
frames=fragmento_video_INFO(1,1).NumFrames
frame_1=fragmento_video(1,1).cdata; %frame 1
frame_1=frame_1(:,:,1);%solo quiero una componente

frame_k_1=frame_1;

%ELIJO UNA ROI
[valor_ciliar_1,zona_ciliar]=imcrop(frame_1);%zona ciliar de interes

VAL=zeros(1,frames);
VAL(1)=round(mean(mean(valor_ciliar_1)));
 
CORR=zeros(length(frames-1)); %almacena la correlacion entre imagenes sucesivas

for k=2:frames
    
fragmento_video= aviread (ruta,k);
frame_k=fragmento_video(1,1).cdata; %frame k 
frame_k=frame_k(:,:,1);
CORR(k-1)=corr2(frame_k_1,frame_k);
valor_ciliar_k=imcrop(frame_k,zona_ciliar);
frame_k_1=frame_k;
VAL(k)=round(mean(mean(valor_ciliar_k))); %la media de los pixeles dentro de la ROI elegida
          
end


UMBRAL_SUP=round(mean(VAL(1:end))+1.75*std(VAL(1:end)));
UMBRAL_INF=round(mean(VAL(1:end))-1.75*std(VAL(1:end)));

INDOK=find(VAL<=UMBRAL_SUP & VAL>=UMBRAL_INF);
INDCORR=find(CORR>0.985);


%CONFIGURACION CREACION VIDEO
 mov = avifile('3.avi');
 mov.compression='none';
 mov.fps=fragmento_video_INFO(1,1).FramesPerSecond;

for m=2:length(INDCORR)
    fragmento_video= aviread (ruta,INDCORR(m-1));
    frame_m=fragmento_video(1,1).cdata; %frame m 
    frame_m=frame_m(:,:,1);
    valor_ciliar_m=imcrop(frame_m,zona_ciliar);
    figure(1),imshow(valor_ciliar_m),title(['frame ' num2str(INDCORR(m)) 'corr: ' num2str(CORR(INDCORR(m-1)))]),hold on
    mov = addframe(mov,getframe);
end

mov=close(mov);