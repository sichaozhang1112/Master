[MatFile,MatFolder] = ...
    uigetfile('*.mat','Pick the file');
load([MatFolder filesep MatFile]);

%%
for ii = 1 : 1000

[ xf(ii,:),xf_dot(ii,:),yf(ii,:),yf_dot(ii,:) ] = HeelAndToe( x(ii,:)',x_dot(ii,:)',y(ii,:)',y_dot(ii,:)',theta(ii,:)',theta_dot(ii,:)' );

[ Fgy(ii,:) ] = GroundReactionForceY( x(ii,:)',theta(ii,:)',xf(ii,:),xf_dot(ii,:),yf(ii,:),yf_dot(ii,:) );
% [ Fgx(ii,:),Fgy(ii,:) ] = GroundReactionForce( x(ii,:)',theta(ii,:)',xf(ii,:),xf_dot(ii,:),yf(ii,:),yf_dot(ii,:) );

[ phi(ii,:),phi_dot(ii,:) ] = GlobalAngle( x(ii,:)',x_dot(ii,:)',y(ii,:)',y_dot(ii,:)',theta(ii,:)',Fgy(ii,:) );

[ Sron(ii,:),Sroff(ii,:),Slon(ii,:),Sloff(ii,:),Sg(ii,:),Srst(ii,:),Slst(ii,:) ] = GlobalState( Fgy(ii,:),xf(ii,:),yf(ii,:),phi(ii,:) );

[ Fgx(ii,:) ] = GroundReactionForceX( x(ii,:)',theta(ii,:)',xf(ii,:),xf_dot(ii,:),yf(ii,:),yf_dot(ii,:),Sg(ii,:),Xft(ii,:)' );

[ Tp(ii,:) ] = PassiveJointTorque( theta(ii,:)',theta_dot(ii,:)' );

[ Tm(ii,:) ] = MotorCommands( theta(ii,:)',theta_dot(ii,:)',u(ii,:)',Sron(ii,:),Sroff(ii,:),Slon(ii,:),Sloff(ii,:),Srst(ii,:),Slst(ii,:) );

[ Ta(ii,:) ] = ActiveJointTorque( Tm(ii,:) );

end
%%
% figure();
% 
% 
%     plot(linspace(1,613,613),(theta(1:613,5)-theta(1:613,7))*180/pi);
%     xlabel('t');

%%
figure(1);

for ii = 1 : 2
    hold on;
    subplot(3,2,ii)
    plot(linspace(1,94,595),theta(1:595,2)-theta(1:595,ii+2));
    xlabel('gait');
    ylabel(['hip_',num2str(ii)]);
    hold on;
    subplot(3,2,ii+2)
    plot(linspace(1,94,595),theta(1:595,ii+2)-theta(1:595,ii+4));
    xlabel('gait');
    ylabel(['knee_',num2str(ii)]);
    hold on;
    subplot(3,2,ii+4)
    plot(linspace(1,94,595),theta(1:595,ii+4)-theta(1:595,ii+6));
    xlabel('gait');
    ylabel(['ankle_',num2str(ii)]);
end
%%
figure(2);

for ii = 1:7
    subplot(2,4,ii)
    plot(t(1:300),Ta(1:300,ii));
    xlabel('t');
    ylabel(['Ta',num2str(ii)]);
end

figure(3);

for ii = 1:7
    subplot(2,4,ii)
    plot(t(1:300),Tp(1:300,ii));
    xlabel('t');
    ylabel(['Tp',num2str(ii)]);
end
%%
figure(4);

for ii = 1:6
    subplot(6,1,ii)
    plot(t(1:1000),Sg(1:1000,ii));
    xlabel('t');
    ylabel(['Sg',num2str(ii)]);
end
