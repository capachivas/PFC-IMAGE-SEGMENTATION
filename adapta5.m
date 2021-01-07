function adapta5
clear all
%estas rutas las cogera el automaticamente en la interfaz grafica!!!
ruta='O:\DADES\PROYECTO_DCP\DATOS_PACIENTES\Dr.Armengot\Batida_ciliar_normal.avi';
fragmento_video= aviread (ruta);%cargo todo el video
fragmento_video_INFO= aviinfo (ruta);
max=fragmento_video_INFO(1,1).NumFrames;
frame_1=fragmento_video(1,1).cdata; %frame k-1 ( en este caso el frame 1 )

%especifico ROI
[frame_1 region]=imcrop(frame_1);

%[x1,y1]=frameini2(frame_1,100,1,1.8,1.3,-1,0.1); %se adapta al primer frame y extrae su contorno(x,y) -->MEJORARLO PARA QUE EN MAS ENTORNOS SE QUEDE ENGANCHADO
[x1,y1]=frameini2(frame_1,100,1,1.8,1.3,-1,-0.02); %se adapta al primer frame y extrae su contorno(x,y) -->MEJORARLO PARA QUE EN MAS ENTORNOS SE QUEDE ENGANCHADO
%EL AJUSTE AL PRIMERA FRAME HA DE SER PREFECTO PUES SERA MI FUTURA
%REFERENCIA PARA GIRAR EL FRAME K TENIENDO EN CUENTA LA DIFERENCIA ENTRE
%LOS CONTORNOS SE MINIMIZE

corr=zeros(length(max-1));%almacena la correlacion entre imagenes sucesivas

frame_k_t=frame_1;  %sera el primer frame al inicio 
frame_k_1=frame_1;

ANGULO=0;

x0=x1;
y0=y1; %contorno del primer frame

x0r=round(x0);
y0r=round(y0);

 %mov = avifile('cell3.avi');
 %mov.compression='none';
 figure(9),imshow(frame_1),hold on,plot([x0r;x0r(1,1)],[y0r;y0r(1,1)])
 %mov = addframe(mov,getframe);
 hold on

for k=2:65
        la tengo que cortar de nuevo con la ROI de antes (la celula seguira dentro)
        fragmento_video= aviread (ruta);%cargo todo el video
        frame_k=fragmento_video(1,k).cdata; %frame k   
        frame_k=imadjust(frame_k);%siempre ajusto el contraste en el siguiente frame
        frame_k=mat2gray(frame_k,[155 255]);
        frame_k=uint8(frame_k*255);
        frame_k=imcrop(frame_k,region);
        
        corr(k-1)=corr2(frame_k_1,frame_k); % calculo la correlacion entre frame k y frame k-1 para ver cuanto de parecidas son dos imagenes
        
             segmenta el contorno para cada frame
             if corr(k-1)<0.98 %la celula gira muy deprisa y debo ajustarme rapidamente a su movimiento
                 [x,y]=framek2(frame_k,k,x1,y1,10,0.5,15,1.3,-2,0.1);  
             else
                 [x,y]=framek2(frame_k,k,x1,y1,5,0.5,2,1.3,-1,0.01); %saca el contorno del frame transformado
             end
             
                 xr=round(x);
                 yr=round(y);

                 
            frame_k_g=imrotate(frame_k,ANGULO,'bilinear');
            
            if corr(k-1)<0.98 %giro brusco de la celula
                    [COR,frame_k_t,theta]=image_registr_MI_COR(frame_k_1,frame_k_g,frame_k,[1.5:0.1:4]);
                    ANGULO=ANGULO+theta; % voy sumandole el giro entre frames
            end
                
            if corr(k-1)>0.99 %no corrijo 
                    frame_k_t=frame_k_g; %pero debo actualizar
            end
                
            if corr(k-1)>0.98 & corr(k-1)<0.99 %caso normal
                    [COR,frame_k_t,theta]=image_registr_MI_COR(frame_k_1,frame_k_g,frame_k,[-0.5:0.05:2]);
                    ANGULO=ANGULO+theta; % voy sumandole el giro entre frames
                    %tendre en cuenta el posible cambio de sentido en el
                    %giro que a veces se produce para corregirlo
            end
                %cuando corr(k-1)>0.99 no corrigo giro pues solo se estaran moviendo los cilios no la celula
            
            frame_k_1=frame_k;%actualizo para la correlacion simplemente
            
            figure(1),imshow(frame_k),hold on, plot([xr;xr(1,1)],[yr;yr(1,1)]),title(['frame ' num2str(k)])
            mov = addframe(mov,getframe);
end
mov=close(mov);