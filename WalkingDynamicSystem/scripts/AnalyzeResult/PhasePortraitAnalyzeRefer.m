[MatFile,MatFolder] = ...
    uigetfile('*.mat','Pick the file');
load([MatFolder filesep MatFile]);

%%
% BodyName = ['ankle';'knee';'hip'];
BodyJoint = [];
BodyJoint = [BodyJoint;spline(ankle_normal(:,1),-ankle_normal(:,2),0:0.1:100)];
BodyJoint = [BodyJoint;spline(ankle_footdrop(:,1),-ankle_footdrop(:,2),0:0.1:100)];
BodyJoint = [BodyJoint;spline(knee_normal(:,1),-knee_normal(:,2),0:0.1:100)];
BodyJoint = [BodyJoint;spline(knee_footdrop(:,1),-knee_footdrop(:,2),0:0.1:100)];
BodyJoint = [BodyJoint;spline(hip_normal(:,1),-hip_normal(:,2),0:0.1:100)];
BodyJoint = [BodyJoint;spline(hip_footdrop(:,1),-hip_footdrop(:,2),0:0.1:100)];

BodyJoint = -BodyJoint;
%%
for ii = 1 : 3
    for jj = 1 : 2
        Angletemp = BodyJoint(2*(ii-1)+jj,:);
        Angletemp_dot = diff(Angletemp)/0.1;
        figure(ii);
        hold on;
        plot(Angletemp(2:end),Angletemp_dot);
        grid on;
        clear temp temp_dot;
    end
end
