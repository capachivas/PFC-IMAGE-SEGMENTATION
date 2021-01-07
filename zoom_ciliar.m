function zoom_ciliar(ruta,axes_video);

fragmento_video= aviread (ruta,1);%cargo frame a frame del video coregsitrado

%informacion del video
fragmento_video_INFO= aviinfo (ruta);
frames=fragmento_video_INFO(1,1).NumFrames;
frame_1=fragmento_video(1,1).cdata; %frame 1 
frame_1=frame_1(:,:,1);
%%
frame_1r=imresize(frame_1,2);
[valor_ciliar_1 zona_ciliar]=imcrop(frame_1r);
%%
axes(axes_video),imshow(imresize(valor_ciliar_1,2))
k=1;

while k<=frames
fragmento_video= aviread (ruta,k);
frame_k=fragmento_video(1,1).cdata; %frame k 
frame_k=frame_k(:,:,1);

valor_ciliar_k=imcrop(frame_k,zona_ciliar);
axes(axes_video),imshow(imresize(valor_ciliar_k,2)),title(['FRAME ' num2str(k)])
k=k+1;
end

