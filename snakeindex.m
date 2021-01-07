function y = snakeindex(IDX)
% SNAKEINDEX  Create index for adaptative interpolating the snake 
%     y = snakeindex(IDX)
%

N = length(IDX); %IDX tiene ceros y unos para cada elemento de x, o sea que tiene su longitud
y=1:0.5:N+0.5;
x=1:N;
y(2*x(IDX==0))=[]; 
