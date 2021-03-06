function [xi,yi] = snakeinterp(x,y,dmax,dmin)
%SNAKEINTERP  Interpolate the snake adaptively
%   [xi,yi] = snakeinterp(x,y,dmax,dmin)
%
%   dmax: the maximum distance between two snake points
%   dmin: the maximum distance between two snake points
%   d(i,i+1)>dmax, then a new point is added between i and i+1
%   d(i,i+1)<dmin, then either i or i+1 is removed 
%  
%   NOTE: the spacing of original curve must be close to the 
%         range defined by dmax and dmin. For arbitrary spacing,
%         try snakeinterp1.
% 
%   See also SNAKEINTERP1

%    there is a bug in the program for points removal

%   Chenyang Xu and Jerry L. Prince, 4/1/95, 6/17/97
%   Copyright (c) 1995-97 by Chenyang Xu and Jerry L. Prince
%   Image Analysis and Communications Lab, Johns Hopkins University

% convert to column vector
x = x(:); y = y(:);

N = length(x);

d = abs(x([2:N 1])- x(:)) + abs(y([2:N 1])- y(:));

% remove the points which distance to neighbor points is shorter than dmin
IDX = (d<dmin); %IDX vale 0 o 1, si vale 1 borrare elementos de x

%ejemplo:
%IDX= [1 2 0.3 4]< 0.5
%IDX = 0 0  1  0 para dada valor saca un 1 o un 0 segun sea o no menor

idx = find(IDX==0); %me quedo con los indices donde d es mayor a dmin
x = x(idx); % y borro aquellos indices donde d es menor a dmin
y = y(idx);

N = length(x);
d = abs(x([2:N 1])- x(:)) + abs(y([2:N 1])- y(:));

IDX = (d>dmax); %me interesan los puntos donde d > dmax

z = snakeindex(IDX);

p = 1:N+1;

xi = interp1(p,[x;x(1)],z');
yi = interp1(p,[y;y(1)],z');

N = length(xi);
d = abs(xi([2:N 1])- xi(:)) + abs(yi([2:N 1])- yi(:));

while (max(d)>dmax),

    IDX = (d>dmax);
    z = snakeindex(IDX);

    p = 1:N+1;

    xi = interp1(p,[xi;xi(1)],z');
    yi = interp1(p,[yi;yi(1)],z');

    N = length(xi);
    d = abs(xi([2:N 1])- xi(:)) + abs(yi([2:N 1])- yi(:));
end
