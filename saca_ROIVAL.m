function [ROIVAL,zona_ciliar]=saca_ROIVAL(ruta);

%SACA VALORES CORRESPONDIENTES A LOS PIXELES DENTRO DE LA ROI SELECCIONADA

fragmento_video= aviread (ruta,1);

%carga primer frame e informacion
fragmento_video_INFO= aviinfo (ruta);
frames=fragmento_video_INFO(1,1).NumFrames
frame_1=fragmento_video(1,1).cdata; %frame 1
frame_1=frame_1(:,:,1);%solo quiero una componente

[valor_ciliar_1 zona_ciliar]=imcrop(frame_1);%zona ciliar de interes
[M N]=size(valor_ciliar_1) %tamaño de ROI

ROIVAL=zeros(M,N,frames);

ROIVAL(:,:,1)=valor_ciliar_1;

k=1;

while k<=frames
fragmento_video= aviread (ruta,k);
frame_k=fragmento_video(1,1).cdata; %frame k 
frame_k=frame_k(:,:,1);
valor_ciliar_k=imcrop(frame_k,zona_ciliar);
ROIVAL(:,:,k)=valor_ciliar_k;
k=k+1;

end
