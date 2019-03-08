%% normal
[MatFile,MatFolder] = ...
    uigetfile('*.mat','Pick the file');
load([MatFolder filesep MatFile]);

Color = [0 0.5 1];Pattern = '-'; % normal

figure();
StanceStartNum = 1;
SwingEndNum = 3000;
EndNum = SwingEndNum - StanceStartNum + 1;
plot(t(StanceStartNum:SwingEndNum),fun(u(StanceStartNum:SwingEndNum,13)),'color',Color);

clear;

%% foot drop
[MatFile,MatFolder] = ...
    uigetfile('*.mat','Pick the file');
load([MatFolder filesep MatFile]);

Color = [1 0 0.5];Pattern = '-'; % foot drop with device Tau

hold on;
StanceStartNum = 1;
SwingEndNum = 3000;
EndNum = SwingEndNum - StanceStartNum + 1;
plot(t(StanceStartNum:SwingEndNum),fun(U13(StanceStartNum:SwingEndNum)),'color',Color);

clear;

