%%
[MatFile,MatFolder] = ...
    uigetfile('*.mat','Pick the file');
load([MatFolder filesep MatFile]);

%%
%%
for ii = 1 : 6000

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
for ii = 1:6
    subplot(6,1,ii)
    plot((1:6000),Sg(1:6000,ii));
    xlabel('t');
    ylabel(['Sg',num2str(ii)]);
end
%%
% SgNum = [];
% for ii = 111 : 5856
%     for jj = 1 : 6
%         if abs(Sg(ii,jj)-Sg(ii+1,jj))==1
%             SgNum(jj,end+1) = ii;
%         end
%     end
% end
%%
% SgStartNum(1) = 2401; SgEndNum(1) = 2430;
% SgStartNum(2) = 2431; SgEndNum(2) = 2583;
% SgStartNum(3) = 2584; SgEndNum(3) = 2687;
% SgStartNum(4) = 2688; SgEndNum(4) = 2718;
% SgStartNum(5) = 2719; SgEndNum(5) = 2860;
% SgStartNum(6) = 2861; SgEndNum(6) = 2974;




