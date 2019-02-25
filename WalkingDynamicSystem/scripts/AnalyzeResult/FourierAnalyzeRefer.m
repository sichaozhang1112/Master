%%
[MatFile,MatFolder] = ...
    uigetfile('*.mat','Pick the file');
load([MatFolder filesep MatFile]);
%%
% BodyName = ['ankle';'knee';'hip'];
figure(1);
hold on;
Ankletemp = spline(ankle_normal(:,1),-ankle_normal(:,2),0:0.1:100);
plot(0:0.1:100,Ankletemp,'Color',[0 0.5 1]);
xlabel('Gait(%)');
grid on;

figure(2);
hold on;
w=fftshift(fft(Ankletemp));
n=0:20;
% subplot(2,1,1),
plot(n,abs(w(501:521)),'Color',[0 0.5 1]);
hold on;
scatter(n,abs(w(501:521)),'b');
ylabel('Frequency Spectrum');
grid on;
% hold on;
% subplot(2,1,2),plot(n,angle(w(501:601)),'Color',[0 0.5 1]);
% ylabel('Phase Spectrum');
% grid on;

figure(1);
hold on;
Ankletemp = spline(ankle_footdrop(:,1),-ankle_footdrop(:,2),0:0.1:100);
plot(0:0.1:100,Ankletemp,'Color',[1 0.5 0]);
xlabel('Gait(%)');
grid on;

figure(2);
w=fftshift(fft(Ankletemp));
n=0:20;
% figure,plot(n,abs(w));
% figure,plot(n,angle(w));
hold on;
% subplot(2,1,1),
plot(n,abs(w(501:521)),'Color',[1 0.5 0]);
hold on;
scatter(n,abs(w(501:521)),'r');
ylabel('Frequency Spectrum');
grid on;
hold on;
% subplot(2,1,2),
% figure();
% plot(0:100,angle(w(501:601)),'Color',[1 0.5 0]);
% ylabel('Phase Spectrum');
% grid on;

%%
figure(3);
hold on;
Kneetemp = spline(knee_normal(:,1),-knee_normal(:,2),0:0.1:100);
plot(0:0.1:100,Kneetemp,'Color',[0 0.5 1]);
xlabel('Gait(%)');
grid on;

figure(4);
w=fftshift(fft(Kneetemp));
n=0:20;
hold on;
% subplot(2,1,1),
plot(n,abs(w(501:521)),'Color',[0 0.5 1]);
hold on;
scatter(n,abs(w(501:521)),'b');
ylabel('Frequency Spectrum');
grid on;
% hold on;
% subplot(2,1,2),plot(n,angle(w(501:601)),'Color',[0 0.5 1]);
% ylabel('Phase Spectrum');
% grid on;

figure(3);
hold on;
Kneetemp = spline(knee_footdrop(:,1),-knee_footdrop(:,2),0:0.1:100);
plot(0:0.1:100,Kneetemp,'Color',[1 0.5 0]);
xlabel('Gait(%)');
grid on;

figure(4);
w=fftshift(fft(Kneetemp));
n=0:20;
hold on;
% subplot(2,1,1),
plot(n,abs(w(501:521)),'Color',[1 0.5 0]);
hold on;
scatter(n,abs(w(501:521)),'r');
ylabel('Frequency Spectrum');
grid on;
% hold on;
% subplot(2,1,2),plot(n,angle(w(501:601)),'Color',[1 0.5 0]);
% ylabel('Phase Spectrum');
% grid on;


%%
figure(5);
hold on;
Hiptemp = spline(hip_normal(:,1),-hip_normal(:,2),0:0.1:100);
plot(0:0.1:100,Hiptemp,'Color',[0 0.5 1]);
xlabel('Gait(%)');
grid on;

figure(6);
w=fftshift(fft(Hiptemp));
n=0:20;
hold on;
% subplot(2,1,1),
plot(n,abs(w(501:521)),'Color',[0 0.5 1]);
hold on;
scatter(n,abs(w(501:521)),'b');
ylabel('Frequency Spectrum');
grid on;
% hold on;
% subplot(2,1,2),plot(n,angle(w(501:601)),'Color',[0 0.5 1]);
% ylabel('Phase Spectrum');
% grid on;

figure(5);
hold on;
Hiptemp = spline(hip_footdrop(:,1),-hip_footdrop(:,2),0:0.1:100);
plot(0:0.1:100,Hiptemp,'Color',[1 0.5 0]);
xlabel('Gait(%)');
grid on;

figure(6);
w=fftshift(fft(Hiptemp));
n=0:20;
hold on;
% subplot(2,1,1),
plot(n,abs(w(501:521)),'Color',[1 0.5 0]);
hold on;
scatter(n,abs(w(501:521)),'r');
ylabel('Frequency Spectrum');
grid on;
% hold on;
% subplot(2,1,2),plot(n,angle(w(501:601)),'Color',[1 0.5 0]);
% grid on;
% ylabel('Phase Spectrum');