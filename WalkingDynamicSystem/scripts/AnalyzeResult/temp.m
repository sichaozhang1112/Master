%%
[MatFile,MatFolder] = ...
    uigetfile('*.mat','Pick the file');
load([MatFolder filesep MatFile]);
%%
figure();
Ankletemp = spline(ankle_normal(:,1),-ankle_normal(:,2),0:0.1:100);
plot(0:0.1:100,Ankletemp);
hold on;
Ankletemp = spline(ankle_footdrop(:,1),-ankle_footdrop(:,2),0:0.1:100);
plot(0:0.1:100,Ankletemp);
%%
figure();
Kneetemp = spline(knee_normal(:,1),-knee_normal(:,2),0:0.1:100);
plot(0:0.1:100,Kneetemp);
hold on;
Kneetemp = spline(knee_footdrop(:,1),-knee_footdrop(:,2),0:0.1:100);
plot(0:0.1:100,Kneetemp);
%%
figure();
Hiptemp = spline(hip_normal(:,1),-hip_normal(:,2),0:0.1:100);
plot(0:0.1:100,Hiptemp);
hold on;
Hiptemp = spline(hip_footdrop(:,1),-hip_footdrop(:,2),0:0.1:100);
plot(0:0.1:100,Hiptemp);