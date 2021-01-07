function analisis_cilios_OF;

ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO_DCP\DATOS_PACIENTES\VIDEO_COREGISTRADOS\cil1.avi';
fragmento_video= aviread (ruta,1);


%carga primer frame e informacion
fragmento_video_INFO= aviinfo (ruta);
frames=fragmento_video_INFO(1,1).NumFrames
Fs=fragmento_video_INFO(1,1).FramesPerSecond;
frame_1=fragmento_video(1,1).cdata; %frame 1
frame_1=frame_1(:,:,1);%solo quiero una componente
% frame_1=imadjust(frame_1);

[valor_ciliar_1 zona_ciliar]=imcrop(frame_1);
[M,N]=size(valor_ciliar_1);

mx=zeros(M,N,frames);
my=mx;

 mov = avifile('cilios_of_2.avi');
 mov.compression='none';
 mov.fps=fragmento_video_INFO(1,1).FramesPerSecond;

mod=zeros(1,frames-1);

images=zeros(M,N,2); %contendra la imagen k-1 y la imagen k
images(:,:,1)=valor_ciliar_1;

k=2;
while k<=frames
    
fragmento_video= aviread (ruta,k);
frame_k=fragmento_video(1,1).cdata; %frame k 
frame_k=frame_k(:,:,1);
% frame_1=imadjust(frame_k);

valor_ciliar_k=imcrop(frame_k,zona_ciliar);
images(:,:,2)=valor_ciliar_k;

[Vx,Vy] = OpticalFlow(images,50,100);

mx(:,:,k-1)=Vx;
my(:,:,k-1)=Vy;

figure(1),quiver(Vx,Vy),title(['frame ' num2str(k)])
mov = addframe(mov,getframe);
images(:,:,1)=images(:,:,2); %actualizo

k=k+1;

end
mov=close(mov);


%¿mod como se calcula?
N=2048;
DFT = fft(mod,N+1);
DFT=fftshift(DFT);

%representacion de la FFT y obtencion del espectro en frecuencia
figure(4),plot((-N/2:N/2)*(Fs/N),abs(DFT)./max(abs(DFT)))






