%% normal
[MatFile,MatFolder] = ...
    uigetfile('*.mat','Pick the file');
load([MatFolder filesep MatFile]);

Color = [0 0.5 1];Pattern = '-'; % normal

figure();
plot(linspace(0,100,EndNum),[fun(u(SwingEndNum+1:EndNum,13));fun(u(1:SwingStartNum,13));fun(u(SwingStartNum+1:SwingEndNum,13))],'color',Color);

clear;

%% foot drop with device
[MatFile,MatFolder] = ...
    uigetfile('*.mat','Pick the file');
load([MatFolder filesep MatFile]);

Color = [1 0 0.5];Pattern = '-'; % foot drop with device Tau
hold on;
plot(linspace(0,100,EndNum),[fun(U13(SwingEndNum+1:EndNum));fun(U13(1:SwingStartNum));fun(U13(SwingStartNum+1:SwingEndNum))],'color',Color);
clear;

