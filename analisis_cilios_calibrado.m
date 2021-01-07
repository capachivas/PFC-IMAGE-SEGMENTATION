function analisis_cilios_calibrado;
%COGE ROI EN ZONA INTERES Y ROI EN ZONA DE FONDO PARA RESTARSELO

%ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO_DCP\DATOS_PACIENTES\VIDEO_COREGISTRADOS\segmentarb_0.001_.avi';
ruta='O:\DADES\PROYECTO_DCP\DATOS_PACIENTES\VIDEO_COREGISTRADOS\celula1000n.avi';
%ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO_DCP\DATOS_PACIENTES\Dr.Armengot\normal.avi';


fragmento_video= aviread (ruta,1);

%carga primer frame e informacion
fragmento_video_INFO= aviinfo (ruta);
frames=fragmento_video_INFO(1,1).NumFrames;
frame_1=fragmento_video(1,1).cdata; %frame 1
frame_1=frame_1(:,:,1);%solo quiero una componente


MEDIA=zeros(1,frames);
%zona_ciliar=[58 12 73-58+1 45-12+1];
%zona_ciliar=[31 57 41-31+1 85-57+1];
[valor_ciliar_1 zona_ciliar]=imcrop(frame_1);%zona ciliar de interes
[M N]=size(valor_ciliar_1) %tamaño de ROI
MEDIA(1)=mean(mean(valor_ciliar_1));

k=1;

while k<=frames
fragmento_video= aviread (ruta,k);
frame_k=fragmento_video(1,1).cdata; %frame k 
frame_k=frame_k(:,:,1);

valor_ciliar_k=imcrop(frame_k,zona_ciliar);
MEDIA(k)=mean(mean(valor_ciliar_k));

k=k+1;
end

MEDIA=MEDIA-mean(MEDIA); %le quito la continua para ver mejor las

%parametros señal continua analogica y representacion
T=round((fragmento_video_INFO(1,1).NumFrames)/(fragmento_video_INFO(1,1).FramesPerSecond));%duracion video
Ts=T/(frames-1);%tiempo de muestra=duracion video/num. subintervalos
Fs=fragmento_video_INFO(1,1).FramesPerSecond;
t=0:Ts:T; %duracion temporal señal
figure(2),plot(MEDIA,'r')

%trunco la señal obtenida en 3 partes para analizar por separado
 
N=2048;

DFT=fft(MEDIA,N+1);
DFT=fftshift(DFT);

%representacion de la FFT y obtencion del espectro en frecuencia
figure(3),plot((-N/2:N/2)*(Fs/N),abs(DFT)./max(abs(DFT)))
title('Contenido espectral')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

%PWELCH
NOVERLAP=200; %NUMERO MUESTRAS QUE SE SOLAPAN
NFFT=1024; %NUMERO MUESTRAS FFT
[PSD,f]=pwelch(MEDIA,[],NOVERLAP,NFFT,Fs);
figure(4),plot(f,(abs(PSD))),grid on
      











