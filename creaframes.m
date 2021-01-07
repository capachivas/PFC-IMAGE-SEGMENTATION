function creaframes
clear all
ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO\PFC_Discinesia_ciliar_primaria\DATOS_PACIENTES\Dr.Armengot\Batida_ciliar_normal.avi';
 fragmento_video= aviread (ruta);%cargo todo el video
 fragmento_video_INFO= aviinfo (ruta); 
 max=fragmento_video_INFO(1,1).NumFrames;
for k=1:max
         m=num2str(k);
         frame=fragmento_video(1,k).cdata; %frame k
         v=['batida_ciliar_normal',m,'.jpg']
         imwrite(frame,v); %creo 1770 archivos
end
