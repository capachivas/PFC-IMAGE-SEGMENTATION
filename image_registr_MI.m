function [COR,im_matched, theta,I,J]=image_registr_MI(image1, image2, image2_original, angle);


image1=double(image1);
image2=double(image2);    

[m,n]=size(image1);
b=length(angle);
im1=round(image1); 

CORbase=corr2(image1,image2_original); %sera la correlacion base
for k=1:b
    J =imrotate(image2,angle(k),'bilinear'); %rota para todos los angulos
    J=round(J);
    [m1,n1]=size(J);% al girarla sera de un tamaño mayor asi que m1,n1>m,n
    %para cada angulo
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
    
end

[a, b] = max(COR(:)); % maximo de las correlaciones
[K,I,J] = ind2sub(size(COR),b);  
theta=angle(K);
im_rot =imrotate(image2,theta,'bilinear');
im_matched=im_rot(I:(I+m-1),J:(J+n-1));
im_matched=uint8(im_matched);
