%% foot drop
load('Gait_DisableTm17_FromSg2.mat');
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
lf(1) = 0.08; lf(2) = 0.12; lf(3) = 0.10;
Alpha(1) = 1.22; Alpha(2) = 2.44;

heel_right(:,1) = x(:,8) - lf(2)*cos(Alpha(1)-theta(:,8));
heel_right(:,2) = y(:,8) - lf(2)*sin(Alpha(1)-theta(:,8));

heel_left(:,1) = x(:,7) - lf(2)*cos(Alpha(1)-theta(:,7));
heel_left(:,2) = y(:,7) - lf(2)*sin(Alpha(1)-theta(:,7));

toe_right(:,1) = x(:,8) + lf(3)*cos(Alpha(2)+theta(:,8)-pi);
toe_right(:,2) = y(:,8) - lf(3)*sin(Alpha(2)+theta(:,8)-pi);

toe_left(:,1) = x(:,7) + lf(3)*cos(Alpha(2)+theta(:,7)-pi);
toe_left(:,2) = y(:,7) - lf(3)*sin(Alpha(2)+theta(:,7)-pi);

%%
for ii = 1 : 1 : EndNum
    if (toe_right(ii,2)>0) && (heel_right(ii,2)>0)
        StanceSeq(ii) = 4;
%         scatter(ii,4,'m','+');
    elseif (toe_right(ii,2)<=0) && (heel_right(ii,2)>0)
        StanceSeq(ii) = 3;
%         scatter(ii,3,'k','^');
    elseif (toe_right(ii,2)<=0) && (heel_right(ii,2)<=0)
        StanceSeq(ii) = 2;
%         scatter(ii,2,'b','d');
    elseif (toe_right(ii,2)>0) && (heel_right(ii,2)<=0)
        StanceSeq(ii) = 1;
%         scatter(ii,1,'r','o');
    end
end

figure(1);
StanceSeq_Double = [StanceSeq StanceSeq];
plot(linspace(1,200,2*EndNum),StanceSeq_Double);
hold on;
for ii = 1 : 10 : 2*EndNum
    if StanceSeq_Double(ii) == 1
        scatter(200*ii/(2*EndNum),1,'r','o','DisplayName','Heel Strike');
    elseif StanceSeq_Double(ii) == 2
        scatter(200*ii/(2*EndNum),2,'b','d','DisplayName','Flat Foot');
    elseif StanceSeq_Double(ii) == 3
        scatter(200*ii/(2*EndNum),3,'k','^','DisplayName','Heel Off');
    elseif StanceSeq_Double(ii) == 4
        scatter(200*ii/(2*EndNum),4,'m','+','DisplayName','Swing');
    end 
end
hold off;
% legend('HeelStrike','Flat Foot','Heel Off','Swing')
grid on;
ylim([0 5]);
xlabel('Gait(%)');

%%
clear StanceSeq StanceSeq_Double
%% normal
load('GaitNormal_FromSg2.mat');

StepNum = 577;
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
lf(1) = 0.08; lf(2) = 0.12; lf(3) = 0.10;
Alpha(1) = 1.22; Alpha(2) = 2.44;

heel_right(:,1) = x(:,8) - lf(2)*cos(Alpha(1)-theta(:,8));
heel_right(:,2) = y(:,8) - lf(2)*sin(Alpha(1)-theta(:,8));

heel_left(:,1) = x(:,7) - lf(2)*cos(Alpha(1)-theta(:,7));
heel_left(:,2) = y(:,7) - lf(2)*sin(Alpha(1)-theta(:,7));

toe_right(:,1) = x(:,8) + lf(3)*cos(Alpha(2)+theta(:,8)-pi);
toe_right(:,2) = y(:,8) - lf(3)*sin(Alpha(2)+theta(:,8)-pi);

toe_left(:,1) = x(:,7) + lf(3)*cos(Alpha(2)+theta(:,7)-pi);
toe_left(:,2) = y(:,7) - lf(3)*sin(Alpha(2)+theta(:,7)-pi);

for ii = 1 : 1 : EndNum
    if (toe_right(ii,2)>0) && (heel_right(ii,2)>0)
        StanceSeq(ii) = 4;
%         scatter(ii,4,'m','+');
    elseif (toe_right(ii,2)<=0) && (heel_right(ii,2)>0)
        StanceSeq(ii) = 3;
%         scatter(ii,3,'k','^');
    elseif (toe_right(ii,2)<=0) && (heel_right(ii,2)<=0)
        StanceSeq(ii) = 2;
%         scatter(ii,2,'b','d');
    elseif (toe_right(ii,2)>0) && (heel_right(ii,2)<=0)
        StanceSeq(ii) = 1;
%         scatter(ii,1,'r','o');
    end
end
StanceSeq(266:291) = ones(1,291-266+1);
StanceSeq(292:332) = ones(1,332-292+1);
figure(2);
StanceSeq_Double = [StanceSeq StanceSeq];
plot(linspace(1,200,2*EndNum),StanceSeq_Double);
hold on;
for ii = 1 : 10 : 2*EndNum
    if StanceSeq_Double(ii) == 1
        scatter(200*ii/(2*EndNum),1,'r','o','DisplayName','Heel Strike');
    elseif StanceSeq_Double(ii) == 2
        scatter(200*ii/(2*EndNum),2,'b','d','DisplayName','Flat Foot');
    elseif StanceSeq_Double(ii) == 3
        scatter(200*ii/(2*EndNum),3,'k','^','DisplayName','Heel Off');
    elseif StanceSeq_Double(ii) == 4
        scatter(200*ii/(2*EndNum),4,'m','+','DisplayName','Swing');
    end 
end
hold off;
grid on;
% legend([]);
ylim([0 5]);
xlabel('Gait(%)');
