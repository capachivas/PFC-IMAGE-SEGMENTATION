function ROIVALn=quitaframes_ROIVAL(ROIVAL,ndes,ruta,zona_ciliar,nomvid)

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
valor_ciliar_1=imcrop(frame_1,zona_ciliar);%zona ciliar de interes

ROIVALn=zeros(size(ROIVAL));

VAL=zeros(1,frames);
VAL(1)=round(mean(mean(ROIVAL(:,:,1))));;
 
MAX=max(max(ROIVAL(:,:,1)));
MIN=min(min(ROIVAL(:,:,1)));

CORR=zeros(length(frames-1)); %almacena la correlacion entre imagenes sucesivas

for k=2:frames
    
fragmento_video= aviread (ruta,k);
frame_k=fragmento_video(1,1).cdata; %frame k 
frame_k=frame_k(:,:,1);

CORR(k-1)=corr2(frame_k_1,frame_k);

valor_ciliar_k=imcrop(frame_k,zona_ciliar);

frame_k_1=frame_k;
VAL(k)=round(mean(mean(ROIVAL(:,:,k)))); %la media de los pixeles dentro de la ROI elegida
          
end

UMBRAL_SUP=round(mean(VAL(1:end))+ndes*std(VAL(1:end)));
UMBRAL_INF=round(mean(VAL(1:end))-ndes*std(VAL(1:end)));

IND_NOK=find(VAL>UMBRAL_SUP|VAL<UMBRAL_INF);
IND_OK=find(VAL<=UMBRAL_SUP&VAL>=UMBRAL_INF);

%muestro umbrales y la señal
figure(2),plot(1:frames,VAL),hold on,plot(IND_OK,VAL(IND_OK),'g*'),plot(IND_NOK,VAL(IND_NOK),'r*'),
plot(1:frames,UMBRAL_SUP,'r'),plot(1:frames,UMBRAL_INF,'r'),hold off,title(['ANALISIS DE FRAMES']),legend('SEÑAL ORIGINAL','FRAMES VALIDOS','FRAMES A ELIMINAR','Location','South')

%CONFIGURACION CREACION VIDEO
 mov = avifile(nomvid);
 mov.compression='none';
 mov.fps=fragmento_video_INFO(1,1).FramesPerSecond;

for m=2:length(IND_OK)
    fragmento_video= aviread (ruta,IND_OK(m-1));
    frame_m=fragmento_video(1,1).cdata; %frame m 
    frame_m=frame_m(:,:,1);
    valor_ciliar_m=imcrop(frame_m,zona_ciliar);
    figure(1),imshow(valor_ciliar_m),title(['frame ' num2str(IND_OK(m)) 'corr: ' num2str(CORR(IND_OK(m-1)))]),hold on
    mov = addframe(mov,getframe);
    ROIVALn(:,:,m-1)=ROIVAL(:,:,m-1);
end

mov=close(mov);










 
