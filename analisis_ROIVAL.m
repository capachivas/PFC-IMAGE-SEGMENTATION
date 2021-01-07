function analisis_ROIVAL(ROIVAL,nomvid)

%COGE EL VIDEO CON LOS FRAMES VALIDOS Y LA ROIVAL VALIDA Y ANALIZA EN
%FRECUENCIA

fragmento_video_INFO= aviinfo (nomvid);

[M N P]=size(ROIVAL);

%QUITAR DC
MEDIA=zeros(1,P);
MEDIA(1,1:end)=round(mean(mean(ROIVAL(:,:,1:end))));

for k=1:P
    ROIVALm(:,:,k)=ROIVAL(:,:,k)-MEDIA(1,k);
end

VAL=zeros(1,P);
NFFT=1024;
DFT=zeros(1,NFFT+1);

SENAL=zeros(1,P);

 for  i=1:M
    for j=1:N
        VAL(1,:)=ROIVALm(i,j,:);  
        %parametros señal continua analogica y representacion
        T=round(P/(fragmento_video_INFO(1,1).FramesPerSecond));%duracion video
        Ts=T/(P-1);%tiempo de muestra=duracion video/num. subintervalos
        Fs=fragmento_video_INFO(1,1).FramesPerSecond;
        t=0:Ts:T; %duracion temporal señal
%       figure(2),plot(1:P,VAL,'r'),title([ ' muestra ' num2str(i) ' x ' num2str(j) ])
%       pause(2)

        ventana=hamming(length(VAL))'; %VENTANA 
        VAL=VAL.*ventana;
        VALn=[zeros(1,250) VAL zeros(1,250)];
        DFT=fft(VALn,NFFT+1);
        DFT=fftshift(DFT);
        %representacion de la FFT y obtencion del espectro en frecuencia
        figure(4),subplot(211)
        plot((-NFFT/2:NFFT/2)*(Fs/NFFT),abs(DFT)./max(abs(DFT))),hold on
        title('Contenido espectral')
        xlabel('Frequency (Hz)')
        ylabel('|Y(f)|')
        
        NOVERLAP=200; %NUMERO MUESTRAS QUE SE SOLAPAN
        [PSD,f]=pwelch(VAL,[],NOVERLAP,NFFT,Fs);
        subplot(212),plot(f,(abs(PSD))),grid on,hold on
    end
 end
 hold off

             
