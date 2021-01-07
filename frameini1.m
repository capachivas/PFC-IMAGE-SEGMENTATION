function [x,y]=frameini1(primera,maxiter,alfa,beta,gamma,kappa,presion,axes_video)

%para poder operar con la imagen
primera=im2double(primera);

%filtrado gausiano paso bajo para poder calcular GVF (hace que las flechas se agranden) y hace el enganche mas
%facil aun
h=fspecial('gaussian',[5 5],3); % a mas coeficientes mas promedia y por tanto mas se suaviza
pasobajo=imfilter(primera,h,'replicate');

%realzar bordes
lap=fspecial('laplacian',0);
realzada=imfilter(pasobajo,lap,'replicate');
realzada=realzada*10;

%gradiente del gaussiano
grad=abs(gradient(pasobajo));
grad=grad*10;

%deteccion de bordes a partir de la imagen sin filtrar 
bw=edge(realzada,'canny',[0,0.2],0.5);

%imagen total con ponderacion para determinar el contorno, me sirve de
%referencia para mover el snake 

imt=pasobajo.*bw;

[yi,xi]=find(bw(:,:,1));%indices donde tengo que escribir
 %como accedo a las posiciones esas
[m,n]=size(primera);
imagee=zeros(m,n,3);
coord=(xi-1)*m+yi; %hay que hacer este truco para acceder a la matriz RGB
imagee(:,:,1)=primera;
imagee(:,:,2)=primera;
imagee(:,:,3)=primera;
imagee(coord)=1;

[u,v]=GVF(-imt,0.1,15);%20-30 iteraciones
%seleccion manual de puntos alrededor del contorno
axes(axes_video),imshow(imagee),hold on,quiver(u,v)
axes(axes_video),[x,y]=snakeinit(0.1,imagee); %parametro delta=0.1, esta adaptada para borrar tambien!!
axes(axes_video),snakedisp(x,y,'b');
 
 %iteraciones para mover los puntos de control hacia el contorno
 iter=0;
 fin=1;
 while (iter<maxiter) & fin==1
    [x,y]=snakedeform2(x,y,alfa,beta,gamma,kappa,presion,u,v,1);%kappa negativo para que se expanda por igual, y no se expanda mas en unas dirs que en otras!!
    iter=iter+1;
    if rem(iter,25)==0 %cada 25 iteraciones
         axes(axes_video),imshow(primera),hold on,snakedisp(x,y,'y'),title(['FIN PRIMERA FASE ADAPTACION: seguir adaptando (bot.izq)']) %enseño como quedaria a esas alturas
         [xo,yo,fin]=ginput(1);
           %poner algun mensaje para que sepa que con el derecho termina
           %las iteraciones
    end
    axes(axes_video),snakedisp(x,y,'y'),title(['ADAPTACION ITERATIVA AL CONTORNO EN LA ITERACION ' num2str(iter)])
    pause(0.25);
 end



