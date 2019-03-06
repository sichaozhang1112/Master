%% normal
[MatFile,MatFolder] = ...
    uigetfile('*.mat','Pick the file');
load([MatFolder filesep MatFile]);

Color = [0 0.5 1];Pattern = '-'; % normal

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
figure();
plot(linspace(0,100,EndNum),[(Tm(SwingEndNum+1:EndNum,17));(Tm(1:SwingStartNum,17));(Tm(SwingStartNum+1:SwingEndNum,17))],'color',Color);

clear;

%% foot drop with device
[MatFile,MatFolder] = ...
    uigetfile('*.mat','Pick the file');
load([MatFolder filesep MatFile]);

Color = [1 0 0.5];Pattern = '-'; % foot drop with device Tau
hold on;
plot(linspace(0,100,EndNum),[(TM17(SwingEndNum+1:EndNum));(TM17(1:SwingStartNum));(TM17(SwingStartNum+1:SwingEndNum))],'color',Color);
clear;

