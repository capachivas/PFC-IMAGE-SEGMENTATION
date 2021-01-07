function senoprueba(Fo,T,Fs,N)

%señal analogica
Fsim=100*1000;
t=0:1/Fsim:T;
yt=sin(2*pi*Fo*t);

subplot(311),plot(t,yt),grid on,title(['SEÑAL TEMPORAL CONTINUA'])

%señal discreta
 Ts=1/Fs;
 n=1:T*Fs;
 yn=sin(2*pi*Fo*n/Fs); %en el proyecto tengo una señal discreta a cierta Fs
 subplot(312),stem(n,yn),title(['SEÑAL TEMPORAL DISCRETA'])
 
 DFT=fft(yn,N+1);
 DFT=fftshift(DFT);
 
 subplot(313),plot((-N/2:N/2)*(Fs/N),abs(DFT))
 
 %Aunque varia Fs no varia la TF discreta ya que en la secuencia discreta
 %tambien está implicita la Fs y digamos que se anulan. 
 
 %En el caso del proyecto no sé la Fs, la que sé es Tvideo/(frames-1) y si
 %varío Tvideo (varia fps) varia Fs 