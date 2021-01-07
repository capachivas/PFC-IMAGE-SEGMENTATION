function [im_matched_o,theta,I,J,K]=image_registr_MI_COR_o(tono_original,im2_o,image1,image2,image2_original,angle);

image1=im2double(image1);
image2=im2double(image2);    

im1=image1;
[m,n]=size(image1);
b=length(angle);

COR=zeros(b,m,n);
CORbase=corr2(image1,image2_original); %sera la correlacion base

maxcor=zeros(1,b);
for k=1:b
    J =imrotate(image2,angle(k),'bilinear'); %rota para todos los angulos
    [m1,n1]=size(J);% al girarla sera de un tamaño mayor asi que m1,n1>m,n
 %   para cada angulo
    for i=1:(m1-m) %m1-m veces
      for j=1:(n1-n) %n1-n veces
               im2=J(i:(i+m-1),j:(j+n-1)); % selecting part of IMAGE2 matching the size of IMAGE1
               %correlacion entre frames consecutivos
               CORvalor=corr2(im1,im2);
               if CORvalor>CORbase
                COR(k,i,j)=CORvalor; % calculating MI
               else
                COR(k,i,j)=0;   
               end
      end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     COR=xcorr2(image1,J);
%     [maximo posicion]=max(COR(:));%maximo para cada angulo
%     posmaxcor(1,k)=posicion;
%     maxcor(1,k)=maximo;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
% maxfinal=max(maxcor(:)); %sera el indice k
% K=find(maxcor==maxfinal);%encuentro el angulo para el que hay maximo
% imrot=imrotate(im2_o,angle(K),'bilinear');
% I=0;
% J=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 [a, b] = max(COR(:)); % maximo de las correlaciones
 [K,I,J] = ind2sub(size(COR),b);  
  theta=angle(K);

 im_rot =imrotate(image2,theta,'bilinear');
 im_matched=im_rot(I:(I+m-1),J:(J+n-1));

% %originales
 im_rot_o=imrotate(im2_o,theta,'bilinear');
 im_matched_o=im_rot_o(I:(I+m-1),J:(J+n-1));
