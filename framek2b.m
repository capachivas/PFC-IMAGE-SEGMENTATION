function [x,y]=framek2b(frame,k,x,y,maximo,alfa,beta,gamma,kappa,presion)
%a parte de elegir zona de interes (ROI), donde el frame pasado como argumento me vendra sobre una ROI determinada, el diezmado lo hare al final de
%los calculos
%el paso el frame siguiente

frame=im2double(frame);

%filtrado gausiano paso bajo para poder calcular GVF (hace que las flechas se agranden) y hace el enganche mas facil
h=fspecial('gaussian',[20 20],2); % a mas coeficientes mas promedia y por tanto mas se suaviza
pasobajo=imfilter(frame,h,'replicate');%desaparezcan los bordes!!

%figure(3),imshow(frame)
%figure(4),imshow(pasobajo)

%gradiente del gaussiano
grad=abs(gradient(pasobajo));
grad=grad*20;

%realzar bordes
lap=fspecial('laplacian',0);
realzada=imfilter(pasobajo,lap,'replicate');
realzada=realzada*10;

%deteccion de bordes a partir de la imagen sin filtrar 
bw=edge(realzada,'canny',[0,0.2],0.7); %binaria 0.2 0.4
%figure(5),imshow(bw),hold on

%imagen total con ponderacion para determinar el contorno, me sirve de
%referencia para mover el snake 
imt=pasobajo.*bw;

%calculo mapa fuerzas
[u,v]=GVF(-imt,0.1,15);
%iteraciones para mover los puntos de control hacia el contorno
 
 maxiter=maximo; %en el seguimiento no dare tantas iteraciones
 iter=0;
 while (iter<maxiter)
     %poca resistencia a moverse la cuva por im (alta gamma)
     %en 5 iter debe moverse rapidisimo segun fuerzas
     [x,y]=snakedeform2(x,y,alfa,beta,gamma,kappa,presion,u,v,1); 
     iter=iter+1; 
 end
