function [x,y,x2,y2]=snakedeform_ex2(x,y,alpha,beta,gamma,kappa,kappap,fx,fy,iter,px3,py3)

N = length(x);

alpha = alpha*ones(1,N);
beta = beta*ones(1,N);

% produce the five diagnal vectors
alpham1 = [alpha(2:N) alpha(1)];
alphap1 = [alpha(N) alpha(1:N-1)];
betam1 = [beta(2:N) beta(1)];
betap1 = [beta(N) beta(1:N-1)];

a = betam1;
b = -alpha - 2*beta - 2*betam1;
c = alpha + alphap1 +betam1 + 4*beta + betap1;
d = -alphap1 - 2*beta - 2*betap1;
e = betap1;

% generate the parameters matrix
A = diag(a(1:N-2),-2) + diag(a(N-1:N),N-2);
A = A + diag(b(1:N-1),-1) + diag(b(N), N-1);
A = A + diag(c);
A = A + diag(d(1:N-1),1) + diag(d(N),-(N-1));
A = A + diag(e(1:N-2),2) + diag(e(N-1:N),-(N-2));

invAI = inv(A + gamma * diag(ones(1,N)));

for count = 1:iter,
vfx = interp2(fx,x,y,'*linear');
vfy = interp2(fy,x,y,'*linear');

pfx=interp2(px3,x,y,'*linear');
pfy=interp2(py3,x,y,'*linear');

temp_x=x;
temp_y=y;

%se agrega la fuerza de presion
xp=[x(2:N);x(1)]; yp=[y(2:N);y(1)];
xm=[x(N);x(1:N-1)]; ym=[y(N);y(1:N-1)];

qx=xp-xm; qy=yp-ym;
pmag=sqrt(qx.*qx+qy.*qy);
px=qy./pmag; py=-qx./pmag;


% deforma el modelo activo
x = invAI * (gamma* x + kappa*vfx+kappap.*px+1*pfx);
y = invAI * (gamma* y + kappa*vfy+kappap.*py+1*pfy);

x2=abs(temp_x-x);
y2=abs(temp_y-y);
x2=x2(:);
y2=y2(:);
end

