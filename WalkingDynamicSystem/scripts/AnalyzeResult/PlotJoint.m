%%
[MatFile,MatFolder] = ...
    uigetfile('*.mat','Pick the file');
load([MatFolder filesep MatFile]);

%%
% StanceStartNum = 1;
% SwingEndNum = 500;
EndNum = SwingEndNum-StanceStartNum+1;
Theta = theta(StanceStartNum:SwingEndNum,:)*180/pi;
% Theta = [theta_temp(SwingEndNum+1:EndNum,:);theta_temp(1:SwingStartNum,:);theta_temp(SwingStartNum+1:SwingEndNum,:)];
% Color = [0 0.5 1];Pattern = '-'; % normal
% Color = [1 0.5 0];Pattern = '-'; % disable Tm17
% Color = [0.5 1 0];Pattern = '-'; % change u13, y14
Color = [1 0 0.5];Pattern = '-'; % disable Tm17 with device Tau
figure(1);
for ii = 1 : 2
    hold on;
    subplot(3,2,ii)
    plot(linspace(0,100,EndNum),Theta(:,ii+4)-Theta(:,ii+6)-0.576*180/pi,Pattern,'color',Color);
    grid on;
    xlabel('gait(%)');
    ylabel(['ankle_',num2str(ii)]);
    
    hold on;
    subplot(3,2,ii+2)
    plot(linspace(0,100,EndNum),Theta(:,ii+4)-Theta(:,ii+2),Pattern,'color',Color);
    grid on;
    xlabel('gait(%)');
    ylabel(['knee_',num2str(ii)]);
    
    hold on;
    subplot(3,2,ii+4)
    plot(linspace(0,100,EndNum),Theta(:,2)-Theta(:,ii+2),Pattern,'color',Color);
    grid on;
    xlabel('gait(%)');
    ylabel(['hip_',num2str(ii)]);
end
%%
clear;