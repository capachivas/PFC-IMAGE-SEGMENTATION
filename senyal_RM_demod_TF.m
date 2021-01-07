%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Señal de RM demodulada
%     Explicación Tranformada de Fourier
%
%          (c) David Moratal, 2009
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clc
clear all

pas=0.1;
limit=10;
punts_FFT=2048;

% *******************************************************

figure(1)
% Cas 1
t = (-limit:pas:limit);
y1 = sin(-2*pi*t/8+pi/2);
subplot(2,2,1)
plot(t,y1,'LineWidth',2);
title('Senyal 1')
grid on
xlabel('Tiempo');
ylabel('Amplitud'); 
axis([-limit limit -2 2])
%FFT
fft_y1=(1/20)*fft(y1,punts_FFT+1);        % el factor reductor 1/20 es per visualitzar-ho guapet
shift_fft_y1=abs(fftshift(fft_y1));
subplot(2,2,2)
plot([-punts_FFT/2:1:punts_FFT/2],shift_fft_y1,'b','LineWidth',1);
xlabel('Posición');
axis([-punts_FFT/4 punts_FFT/4 0 4])

% *******************************************************

% Cas 2
t = (-limit:pas:limit);
y2 = 0.75 * sin(2*pi*t/4);
subplot(2,2,3)
plot(t,y2,'LineWidth',2);
title('Senyal 2')
grid on
xlabel('Tiempo');
ylabel('Amplitud'); 
axis([-limit limit -2 2])
%FFT
fft_y2=(1/20)*fft(y2,punts_FFT+1);        % el factor reductor 1/20 es per visualitzar-ho guapet
shift_fft_y2=abs(fftshift(fft_y2));
subplot(2,2,4)
plot([-punts_FFT/2:1:punts_FFT/2],shift_fft_y2,'b','LineWidth',1);
xlabel('Posición');
axis([-punts_FFT/4 punts_FFT/4 0 4])

% *******************************************************

figure(2)
% Cas 3
t = (-limit:pas:limit);
y3 = 0.5 * sin(-2*pi*t/2+pi);
subplot(2,2,1)
plot(t,y3,'LineWidth',2);
title('Senyal 3')
grid on
xlabel('Tiempo');
ylabel('Amplitud'); 
axis([-limit limit -2 2])
%FFT
fft_y3=(1/20)*fft(y3,punts_FFT+1);        % el factor reductor 1/20 es per visualitzar-ho guapet
shift_fft_y3=abs(fftshift(fft_y3));
subplot(2,2,2)
plot([-punts_FFT/2:1:punts_FFT/2],shift_fft_y3,'b','LineWidth',1);
xlabel('Posición');
axis([-punts_FFT/4 punts_FFT/4 0 4])

% *******************************************************

% Cas 4
t = (-limit:pas:limit);
y4 = y1 + y2 + y3;
subplot(2,2,3)
plot(t,y4,'LineWidth',2);
title('Senyal suma de Senyal 1 + Senyal 2 + Senyal 3')
grid on
xlabel('Tiempo');
ylabel('Amplitud'); 
axis([-limit limit -2 2])
%FFT
fft_y4=(1/20)*fft(y4,punts_FFT+1);        % el factor reductor 1/20 es per visualitzar-ho guapet
shift_fft_y4=abs(fftshift(fft_y4));
subplot(2,2,4)
plot([-punts_FFT/2:1:punts_FFT/2],shift_fft_y4,'b','LineWidth',1);
xlabel('Posición');
axis([-punts_FFT/4 punts_FFT/4 0 4])

% *******************************************************

