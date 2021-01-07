function [x,y]=frameini2(primera,maxiter,alfa,beta,gamma,kappa,presion)

%para poder operar con la imagen
primera=im2double(primera);
primera=imcrop(primera);
%figure(1),imshow(primera),title(['IMAGEN ORIGINAL'])

%filtrado gausiano paso bajo para poder calcular GVF (hace que las flechas se agranden) y hace el enganche mas
%facil aun
h=fspecial('gaussian',[5 5],3); % a mas coeficientes mas promedia y por tanto mas se suaviza
pasobajo=imfilter(primera,h,'replicate');
%figure(2),imshow(pasobajo),title(['IMAGEN FILTRADA PASO BAJO']) %calculare el GVF de aqui ya que refuerzo los bordes y las flechas crecen

%realzar bordes
lap=fspecial('laplacian',0.5);
realzada=imfilter(pasobajo,lap,'replicate');
realzada=realzada*10;

%figure(3),imshow(realzada),title(['IMAGEN REALZADA'])

%gradiente del gaussiano
grad=abs(gradient(pasobajo));
grad=grad*10;
%figure(4),imshow(grad),title(['GRADIENTE DE LA IMAGEN PASO BAJO'])

%deteccion de bordes a partir de la imagen sin filtrar 
bw=edge(realzada,'canny',[0,0.2],0.5);
%figure(5),imshow(bw),title(['IMAGEN BINARIA CON LOS BORDES EXTRAIDOS'])

%imagen total con ponderacion para determinar el contorno, me sirve de referencia para mover el snake 

imt=pasobajo.*bw;
%figure(6),imshow(imt),title(['IMAGEN PREPROCESADA'])

[yi,xi]=find(bw(:,:,1));%indices donde tengo que escribir
 %como accedo a las posiciones esas
[m,n]=size(primera);
imagee=zeros(m,n,3);
coord=(xi-1)*m+yi; %hay que hacer este truco para acceder a la matriz RGB
imagee(:,:,1)=primera;
imagee(:,:,2)=primera;
imagee(:,:,3)=primera;
imagee(coord)=1;
figure(7),imshow(imagee)%para ver como se ajusta el mapa bordes a la imagen original

[u,v]=GVF(-imt,0.1,15);%20-30 iteraciones
figure(8),quiver(u,v),title(['GVF(MAPA DE FUERZAS)'])
 %seleccion manual de puntos alrededor del contorno
figure(1),imshow(imagee),hold on,quiver(u,v);
[x,y]=snakeinit(0.1,imagee); %parametro delta=0.1, esta adaptada para borrar tambien!!
 snakedisp(x,y,'b');
 %iteraciones para mover los puntos de control hacia el contorno (tener en
 %cuenta la energia)
 iter=0;
 fin=1;
 while (iter<maxiter) & fin==1
    [x,y]=snakedeform2(x,y,alfa,beta,gamma,kappa,presion,u,v,1);%kappa negativo para que se expanda por igual, y no se expanda mas en unas dirs que en otras!!
    iter=iter+1;
        if rem(iter,25)==0 %cada 25 iteraciones
            imshow(primera),hold on,snakedisp(x,y,'y'),title(['FIN PRIMERA FASE ADAPTACION: seguir adaptando (bot.izq)']) %enseño como quedaria a esas alturas
            [xo,yo,fin]=ginput(1);
        end
    
    figure(1),snakedisp(x,y,'y'),title(['ADAPTACION ITERATIVA AL CONTORNO EN LA ITERACION ' num2str(iter)])
    pause(0.25);
 end
 hold off;
