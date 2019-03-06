%% normal
[MatFile,MatFolder] = ...
    uigetfile('*.mat','Pick the file');
load([MatFolder filesep MatFile]);

Color = [0 0.5 1];Pattern = '-'; % normal

figure();
plot(linspace(0,100,EndNum),[fun(u(SwingEndNum+1:EndNum,13));fun(u(1:SwingStartNum,13));fun(u(SwingStartNum+1:SwingEndNum,13))],'color',Color);

clear;