function adapta_final(ruta,maxiter,alfa,beta,gamma,kappa,presion,umbral_correlacion,axes_video)
%falta crear video segmentado, me da problemas!!!!(lo dejo en %%%)
fragmento_video= aviread (ruta,1);%cargo todo el video

fragmento_video_INFO= aviinfo (ruta);
maximo=fragmento_video_INFO(1,1).NumFrames;
frame_1=fragmento_video(1,1).cdata; %frame k-1 ( en este caso el frame 1 )

[M N]=size(frame_1);%como hacer que axes_video o crea_video sea de grande como la imagen o imagen cropeada
%especifico ROI

[frame_1 region]=imcrop(frame_1);
axes(axes_video),imshow(frame_1)

[x1,y1]=frameini1(frame_1,maxiter,alfa,beta,gamma,kappa,presion,axes_video); %se adapta al primer frame y extrae su contorno(x,y)

corr=zeros(length(maximo-1));%almacena la correlacion entre imagenes sucesivas

frame_k_1=frame_1;

x0=x1;
y0=y1; %contorno del primer frame

% %%
% mov = avifile('segmentacion_gui.avi');
% mov.compression='none';
% mov.fps=fragmento_video_INFO(1,1).FramesPerSecond;
% 
% imshow(frame_1),hold on,plot([x1;x1(1,1)],[y1;y1(1,1)],'y'),title([' SEGMENTACIÓN PRIMER FRAME'])
% 
% mov = addframe(mov,getframe);
% %%

corr=zeros(length(maximo-1));%almacena la correlacion entre imagenes sucesivas

k=2;

while k<=maximo
fragmento_video= aviread (ruta,k);%cargo todo el video
frame_k=fragmento_video(1,1).cdata; %frame k
frame_k=imcrop(frame_k,region);

corr(k-1)=corr2(frame_k_1,frame_k); % calculo la correlacion entre frame k y frame k-1 para ver cuanto de parecidas son dos imagenes

        if corr(k-1)<umbral_correlacion %la celula gira muy deprisa y debo ajustarme rapidamente a su movimiento
                    [x,y]=framek1(frame_k,k,x1,y1,maxiter*2/5,alfa/2,beta*8.35,gamma,kappa*2,presion);  
                 else
                    [x,y]=framek1(frame_k,k,x1,y1,maxiter/5,alfa/2,beta+0.2,gamma,kappa,presion/10);
        end
         
        x1=x;
        y1=y; %actualizo el contorno actual
        
        frame_k_1=frame_k; %actualizo el frame al siguiente
        k=k+1;
        %axes(axes_video),
        imshow(frame_k),hold on,plot([x;x(1,1)],[y;y(1,1)]),title([' SEGMENTACIÓN FRAME ' num2str(k)])
        
%         %%
%         mov = addframe(mov,getframe);
%         %%

end

% %%
% mov=close(mov);
% %%


