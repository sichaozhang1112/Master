%%
[MatFile,MatFolder] = ...
    uigetfile('*.mat','Pick the file');
load([MatFolder filesep MatFile]);

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
GroundPosition = 0.1;
for ii = 1 : 1 : EndNum
    if (toe_right(ii,2)>GroundPosition) && (heel_right(ii,2)>GroundPosition)
        StanceSeq(ii) = 4;
%         scatter(ii,4,'m','+');
    elseif (toe_right(ii,2)<=GroundPosition) && (heel_right(ii,2)>GroundPosition)
        StanceSeq(ii) = 3;
%         scatter(ii,3,'k','^');
    elseif (toe_right(ii,2)<=GroundPosition) && (heel_right(ii,2)<=GroundPosition)
        StanceSeq(ii) = 2;
%         scatter(ii,2,'b','d');
    elseif (toe_right(ii,2)>GroundPosition) && (heel_right(ii,2)<=GroundPosition)
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

clear;
