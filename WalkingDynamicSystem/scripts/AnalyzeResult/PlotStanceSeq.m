%% foot drop
[MatFile,MatFolder] = ...
    uigetfile('*.mat','Pick the file');
load([MatFolder filesep MatFile]);
%%
StepNum = 595;
EndNum = round(StepNum/0.94);
SwingNum = round(EndNum*0.4);
% for ii = 1 : StepNum
%     Theta(ii,:) = theta(ii,:);
% end

x(EndNum,:) = x(1,:);
x_dot(EndNum,:) = x_dot(1,:);
y(EndNum,:) = y(1,:);
y_dot(EndNum,:) = y_dot(1,:);
theta(EndNum,:) = theta(1,:);
theta_dot(EndNum,:) = theta_dot(1,:);

for ii = 1 : 8
    x_temp = spline([StepNum,EndNum],[x(StepNum,ii),x(EndNum,ii)],StepNum:EndNum);
    x(StepNum:EndNum,ii) = x_temp';
    x_dot_temp = spline([StepNum,EndNum],[x_dot(StepNum,ii),x_dot(EndNum,ii)],StepNum:EndNum);
    x_dot(StepNum:EndNum,ii) = x_dot_temp';
    y_temp = spline([StepNum,EndNum],[y(StepNum,ii),y(EndNum,ii)],StepNum:EndNum);
    y(StepNum:EndNum,ii) = y_temp';
    y_dot_temp = spline([StepNum,EndNum],[y_dot(StepNum,ii),y_dot(EndNum,ii)],StepNum:EndNum);
    y_dot(StepNum:EndNum,ii) = y_dot_temp';
    theta_temp = spline([StepNum,EndNum],[theta(StepNum,ii),theta(EndNum,ii)],StepNum:EndNum);
    theta(StepNum:EndNum,ii) = theta_temp';
    theta_dot_temp = spline([StepNum,EndNum],[theta_dot(StepNum,ii),theta_dot(EndNum,ii)],StepNum:EndNum);
    theta_dot(StepNum:EndNum,ii) = theta_dot_temp';
end

% theta = theta*180/pi;
%%

for ii = 1 : EndNum
    [ xf(ii,:),xf_dot(ii,:),yf(ii,:),yf_dot(ii,:) ] = HeelAndToe( x(ii,:)',x_dot(ii,:)',y(ii,:)',y_dot(ii,:)',theta(ii,:)',theta_dot(ii,:)' );
end

%%
figure();
for ii = 1 : 10 : EndNum
    hold on;
    if (yf(ii,1)>0) && (yf(ii,3)>0)
        scatter(ii,4);
    elseif (yf(ii,1)<=0) && (yf(ii,3)>0)
        scatter(ii,3);
    elseif (yf(ii,1)<=0) && (yf(ii,3)<=0)
        scatter(ii,2);
    elseif (yf(ii,1)>0) && (yf(ii,3)<=0)
        scatter(ii,1);
    end
end
