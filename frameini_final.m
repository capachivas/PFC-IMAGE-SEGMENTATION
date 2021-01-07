function [x,y]=frameini_final(primera)
%function [x,y]=frameini_final(primera,tamano,varianza,inf,sup,sigma,factor1,factor2,iter_gvf,mu,delta,maxiter,alpha,beta,gamma,kappa,kappap,iter_snake)
%para poder operar con la imagen
primera=im2double(primera);

%filtrado gausiano paso bajo para poder calcular GVF (hace que las flechas se agranden) y hace el enganche mas
%facil aun
h=fspecial('gaussian',[5 5],3); % a mas coeficientes mas promedia y por tanto mas se suaviza
pasobajo=imfilter(primera,h,'replicate');
figure(2),imshow(pasobajo) %calculare el GVF de aqui ya que refuerzo los bordes y las flechas crecen

%realzar bordes
lap=fspecial('laplacian',0);
realzada=imfilter(pasobajo,lap,'replicate');
realzada=realzada*10;
figure(3),imshow(realzada)

%gradiente del gaussiano
grad=abs(gradient(pasobajo));
grad=grad*10;
figure(4),imshow(grad);

%deteccion de bordes a partir de la imagen sin filtrar 
bw=edge(realzada,'canny',[0,0.2],0.5);
figure(5),imshow(bw)

%imagen total con ponderacion para determinar el contorno, me sirve de referencia para mover el snake 
imt=pasobajo.*bw;
figure(6),imshow(imt)

[yi,xi]=find(bw(:,:,1));%indices donde tengo que escribir
 %como accedo a las posiciones esas
 [m,n]=size(primera);
 imagee=zeros(m,n,3);
 coord=(xi-1)*m+yi; %hay que hacer este truco para acceder a la matriz RGB
 imagee(:,:,1)=primera;
 imagee(:,:,2)=primera;
 imagee(:,:,3)=primera;
 imagee(coord)=1;
%figure(7),imshow(imagee)%para ver como se ajusta el mapa bordes a la imagen original

[u,v]=GVF(-imt,0.1,15);%20-30 iteraciones
figure(8),quiver(u,v)
 %seleccion manual de puntos alrededor del contorno
figure(9),imshow(imagee),hold on

[x,y]=snakeinit(0.1,imagee); %parametro delta=0.1, esta adaptada para borrar tambien!!

snakedisp(x,y,'b');
 
maxiter=100;
 but=1;
 iter=0;
 while (iter<maxiter) & (but==1)
    [x,y]=snakedeform2(x,y,1,1.8,1.3,-1,0.1,u,v,1);%kappa negativo para que se expanda por igual, y no se expanda mas en unas dirs que en otras!!
     if ( rem(iter,25)==0 & iter ~= 0 )%PRUEBA
         msgbox(['SEGUIR ADAPTACION (IZQUIERDO)<-->TERMINAR ADAPTACION(DERECHO)']); %PRUEBA
         pause(3); %despues crear un boton en la misma ventana que permita frenar proceso
         [ro,so,but]=ginput(1); %PRUEBA
         %con el boton derecho termino de adaptar( me da tres oportunidades
         %para no tragarme todas las iteraciones )
    end    
     iter=iter+1;
     snakedisp(x,y,'b'),title(['ADAPTACION ITERATIVA AL CONTORNO EN LA ITERACION ' num2str(iter)])
     pause(0.25);
 end
 iter=0;
 %solo al final interpolo
 primera2=imresize(primera,6);%debiera filtrarse paso bajo para que no se noten los pixeles....

%cuando pase la x y la y al siguiente frame las paso sin multiplicar por 6
%porque sino las operaciones que debo hacer son demasiadas!!!

figure(10),imshow(primera),hold on,plot([x;x(1,1)],[y;y(1,1)]),title(['FIGURA SNAKE FINAL PRIMER FRAME'])
  hold off;

