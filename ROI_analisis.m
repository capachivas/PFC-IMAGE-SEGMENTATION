function ROI_analisis

ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO_DCP\DATOS_PACIENTES\VIDEO_COREGISTRADOS\cil7.avi';
%ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO_DCP\DATOS_PACIENTES\Dr.Armengot\normal.avi';
%ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO_DCP\DATOS_PACIENTES\Dr.Armengot\cilio3.avi';

fragmento_video= aviread (ruta,1);

%carga primer frame e informacion
fragmento_video_INFO= aviinfo (ruta);
frames=fragmento_video_INFO(1,1).NumFrames;
frame_1=fragmento_video(1,1).cdata; %frame 1
frame_1=frame_1(:,:,1);%solo quiero una componente

%ELIJO UNA ROI
[valor_ciliar_1 zona_ciliar]=imcrop(frame_1);%zona ciliar de interes

VAL=zeros(1,frames);

VAL(1)=round(mean(mean(valor_ciliar_1)));

for k=1:frames
    
fragmento_video= aviread (ruta,k);
frame_k=fragmento_video(1,1).cdata; %frame k 
frame_k=frame_k(:,:,1);
valor_ciliar_k=imcrop(frame_k,zona_ciliar);

VAL(k)=round(mean(mean(valor_ciliar_k)));

end

figure(1),plot(1:frames,VAL)

%%%%%%%CREACION SEÑAL TEMPORAL%%%%%%%%
T=round((fragmento_video_INFO(1,1).NumFrames)/(fragmento_video_INFO(1,1).FramesPerSecond)); %duracion video
Ts=T/(frames-1);%tiempo de muestra=duracion video/num. subintervalos
Fs=fragmento_video_INFO(1,1).FramesPerSecond;
t=0:Ts:T; %duracion temporal señal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%PETICION FRAMES A TENER EN CUENTA Y CALCULO FFT%%%%
     
%     [x,y,N]=ginput(2);
%     SENAL=VAL(x(1):x(2));
    
    SENAL=VAL;%SINO LA COJO POR TROZOS...
    SENAL=SENAL-mean(SENAL);

     N=1024;
     %ventana=rectwin(length(SENAL))'; %VENTANA RECTANGULAR
     %SENAL=SENAL.*ventana;
     DFT=fft(SENAL,N+1);
     DFT=fftshift(DFT);
    
     figure(2),subplot(211),plot((-N/2:N/2)*(Fs/N),(abs(DFT)./max(abs(DFT)))*100),grid on,hold on
     title('Contenido espectral')
     xlabel('Frequency (Hz)')
     ylabel('|Y(f)|')

     %PWELCH
     res=0.1; %RESOLUCIÓN 
     NOVERLAP=20; %NUMERO MUESTRAS QUE SE SOLAPAN
     NFFT=length(SENAL); %NUMERO MUESTRAS FFT
     window=rectwin(NFFT);
     [PSD,f]=pwelch(SENAL,window,NOVERLAP,NFFT,Fs);
     subplot(212),plot(f,(abs(PSD))),grid on
     





 
