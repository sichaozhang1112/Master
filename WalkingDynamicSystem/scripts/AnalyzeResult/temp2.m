fs=200;N=1024;n=0:N-1;t=n/fs;y=sin(2*pi*60*t);
Y=fft(y,N);
A=abs(Y);f=n*fs/N;
ph=2*angle(Y(1:N/2));
ph=ph*180/pi;
plot(f(1:N/2),ph(1:N/2));
xlabel('??/hz'),ylabel('??'),title('???');
grid on;