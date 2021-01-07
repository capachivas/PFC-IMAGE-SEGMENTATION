function [x,y] = snakeinit(delta,im)
%esta mejorado para poder borrar puntos que metiste erroneamente

%SNAKEINIT  Manually initialize a 2-D, closed snake 
%   [x,y] = SNAKEINIT(delta)
%
%   delta: interpolation step

%   Chenyang Xu and Jerry L. Prince, 4/1/95, 6/17/97
%   Copyright (c) 1995-97 by Chenyang Xu and Jerry L. Prince
%   Image Analysis and Communications Lab, Johns Hopkins University

hold on

x = [];
y = [];
n =0;

% Loop, picking up the points
disp('Left mouse button picks points.')
disp('Right mouse button picks last point.')

but = 1;
while but == 1
    
      [s, t, but] = ginput(1);
      
      if but == 98  %pulso tecla borrar(b) borra el ultimo x e y introducido
          hold off;
          
             if n == 0 %si la n=0 no decremento
               x = [];
               y = [];
               but = 1;
               imshow(im);
             else   %si n>0 puedo decrementar
               close;  
               n = n - 1;
               but = 1;
               x = x(1:n);
               y = y(1:n);   
               imshow(im),hold on,plot(x(1:n),y(1:n),'g-'),plot(x(1:n),y(1:n),'rx'),plot(x(1:n),y(1:n),'bo'); 
               set(gcf,'Position',[1 31 1280 696]); %maximizo automaticamente la ventana (a toda la pantalla disponible)--->mejorar para first.m
             end
             
      else  
          n = n + 1;
          x(n,1) = s;
          y(n,1) = t;
          plot(x,y,'g-'),hold on, plot(x,y,'rx'),plot(x(1:n),y(1:n),'bo');
      end
end   

plot([x;x(1,1)],[y;y(1,1)],'g-');plot([x;x(1,1)],[y;y(1,1)],'rx'),plot(x(1:n),y(1:n),'bo');
hold off

% sampling and record number to N
x = [x;x(1,1)];
y = [y;y(1,1)];
t = 1:n+1;
ts = [1:delta:n+1]';
xi = interp1(t,x,ts);
yi = interp1(t,y,ts);
n = length(xi);
x = xi(1:n-1);
y = yi(1:n-1);
