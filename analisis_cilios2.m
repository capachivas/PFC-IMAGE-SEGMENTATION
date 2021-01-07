function analisis_cilios2(ruta,axes_video);

fragmento_video= aviread (ruta,1);%cargo frame a frame del video coregsitrado

%informacion del video
fragmento_video_INFO= aviinfo (ruta);
frames=fragmento_video_INFO(1,1).NumFrames;
frame_1=fragmento_video(1,1).cdata; %frame 1 
frame_1=frame_1(:,:,1);

%preprocesado
%frame_1=imadjust(frame_1);
%frame_1=mat2gray(frame_1,[70,170]);

[valor_ciliar_1 zona_ciliar]=imcrop(frame_1);
[valor_ciliar_b zona_ciliar_b]=imcrop(frame_1);
%preprocesado

MEDIAA=zeros(1,frames);
MEDIAB=zeros(1,frames);

%ANALISIS POR MEDIA DE PIXELES
MEDIAA(1)=mean(mean(valor_ciliar_1));
MEDIAB(1)=mean(mean(valor_ciliar_b));

%ANALISIS POR PIXEL
%[pixel_int region_int]=imcrop(valor_ciliar_1);
%valores=zeros(1,frames);
%valores(1)=pixel_int;

k=1;

while k<=frames
fragmento_video= aviread (ruta,k);
frame_k=fragmento_video(1,1).cdata; %frame k 
frame_k=frame_k(:,:,1);

%preprocesado
%frame_k=imadjust(frame_k);
%frame_k=mat2gray(frame_k,[70,170]);

valor_ciliar_k=imcrop(frame_k,zona_ciliar);
valor_ciliar_kb=imcrop(frame_k,zona_ciliar_b);

%ANALISIS POR MEDIA DE PIXELES
MEDIAA(k)=mean(mean(valor_ciliar_k));
MEDIAB(k)=mean(mean(valor_ciliar_kb));

 %ANALISIS POR PIXEL
%pixel_int=imcrop(valor_ciliar_k,region_int);
%valores(k)=pixel_int;
k=k+1;
end

%analisis de media
MEDIAA=MEDIAA-mean(MEDIAA); %quito la continua
MEDIAB=MEDIAB-mean(MEDIAB); %quito la continua

T=round((fragmento_video_INFO(1,1).NumFrames)/(fragmento_video_INFO(1,1).FramesPerSecond));%duracion video
Ts=T/(frames-1);%tiempo de muestra=duracion video/num. subintervalos
Fs=fragmento_video_INFO(1,1).FramesPerSecond;

t=0:Ts:T; %duracion temporal señal
%valores=valores/(max(valores));
ventana_graficas(t,MEDIAA),hold on,plot(t,MEDIAB,'r')

%trunco la señal obtenida
 
% %muestra 1
% 
%  [tini1,yini]=ginput(1);
%  [tend1,yend]=ginput(1); %uso xend y xini solo
% 
%  xini1=round(tini1/Ts);
%  xend1=round(tend1/Ts);
% 
% valoresA=MEDIA(xini1:xend1);
% 
% %muestra 2
% 
%  [tini2,yini]=ginput(1);
%  [tend2,yend]=ginput(1); %uso xend y xini solo
% 
%  xini2=round(tini2/Ts);
%  xend2=round(tend2/Ts);
% 
%  valoresB=MEDIA(xini2:xend2);
%  
% %muestra 3
% 
%  [tini3,yini]=ginput(1);
%  [tend3,yend]=ginput(1); %uso xend y xini solo
% 
%  xini3=round(tini3/Ts);
%  xend3=round(tend3/Ts);
%  
%  valoresC=MEDIA(xini3:xend3);
%  
% %saco valores temporales
% 
% tma=t(xini1:xend1);
% tmb=t(xini2:xend2);
% tmc=t(xini3:xend3);

N=2048;

DFT1 = fft(MEDIAA,N+1);
DFT1=fftshift(DFT1);

DFT2 = fft(MEDIAB,N+1);
DFT2=fftshift(DFT2);
 

DFTA = fft(MEDIAA,N+1);
DFTA=fftshift(DFTA);

DFTB = fft(MEDIAB,N+1);
DFTB=fftshift(DFTB);

DFT=abs(DFTA)-abs(DFTB);


ventana_frecuencias(DFT,DFT1,DFT2,Fs,N)


