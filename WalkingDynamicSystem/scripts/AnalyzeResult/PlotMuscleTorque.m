[MatFile,MatFolder] = ...
    uigetfile('*.mat','Pick the file');
load([MatFolder filesep MatFile]);

%%
Color = [0 0.5 1];Pattern = '-'; % normal
% Color = [1 0.5 0];Pattern = '-'; % footdrop
% Color = [1 0 0.5];Pattern = 'o';
%%
for ii = 1 : EndNum

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
figure(1);
for ii = 1:20
    hold on;
    subplot(4,5,ii)
    plot(t(1:EndNum),Tm(1:EndNum,ii),Pattern,'color',Color);
    ylabel(['Tm',num2str(ii)]);
end

clear;