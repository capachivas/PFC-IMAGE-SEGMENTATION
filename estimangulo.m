function estimangulo
clear all
%estas rutas las cogera el automaticamente en la interfaz grafica!!!
ruta='C:\Documents and Settings\Jose\My Documents\PROYECTO\PFC_Discinesia_ciliar_primaria\DATOS_PACIENTES\Dr.Armengot\Batida_ciliar_normal.avi';
fragmento_video= aviread (ruta);%cargo todo el video
fragmento_video_INFO= aviinfo (ruta);
max=fragmento_video_INFO(1,1).NumFrames;
frame_1=fragmento_video(1,1).cdata; %frame k-1 ( en este caso el frame 1 )
frame_1=mat2gray(frame_1,[155 255]);
frame_1=uint8(frame_1*255);

%especifico ROI
[frame_1 region]=imcrop(frame_1);

corr=zeros(length(max-1));%almacena la correlacion entre imagenes sucesivas
THETA=zeros(length(max-1));

frame_k_t=frame_1;  %sera el primer frame al inicio 
frame_k_1=frame_1;

ANGULO=0;

for k=2:150
        fragmento_video= aviread (ruta);%cargo todo el video
        frame_k=fragmento_video(1,k).cdata; %frame k     
        frame_k=mat2gray(frame_k,[155 255]);
        frame_k=uint8(frame_k*255);
        frame_k=imcrop(frame_k,region);  
        corr(k-1)=corr2(frame_k_1,frame_k); % calculo la correlacion entre frame k y frame k-1 para ver cuanto de parecidas son dos imagenes
                  
        frame_k_g=imrotate(frame_k,ANGULO,'bilinear');
               
        [COR,NADA,theta_0]=image_registr_MI_COR(frame_1,frame_k_g,frame_k,[-1 1]);
        
        if theta_0<0
            [COR,NADA,theta_1a]=image_registr_MI_COR(frame_1,frame_k_g,frame_k,[-1:0.2:0]);
            theta_1a
            [COR,frame_k_t,theta]=image_registr_MI_COR(frame_1,frame_k_g,frame_k,[theta_1a:0.05:theta_1a+0.2]);
            theta
        else
            [COR,NADA,theta_1b]=image_registr_MI_COR(frame_1,frame_k_g,frame_k,[0:0.2:2]);
            theta1_b
            [COR,frame_k_t,theta]=image_registr_MI_COR(frame_1,frame_k_g,frame_k,[theta_1b:0.05:theta_1b+0.2]);
            theta
        end
        
        THETA(k-1)=theta    
        ANGULO=ANGULO+theta; % voy sumandole el giro entre frames

        %si theta es negativo se resta automatico!!!
        frame_k_1=frame_k;%actualizo
    
        frame_k_t_p=imresize(frame_k_t,6);    
        figure(1),imshow(frame_k_t_p),hold on
        title(['frame ' num2str(k)])
end