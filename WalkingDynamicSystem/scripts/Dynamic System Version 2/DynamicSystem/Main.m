% LoadInitialCondition;
% x(2),y(2),x_dot(2),y_dot(2),theta,theta_dot,u,v
% state0 = [x;x_dot;y;y_dot;theta;theta_dot;u;v];

% from stage 2 
state0 = [1.24362325889711,0.654609600934644,0.979021358816158,0.326745197591223,1.57765352593445,1.68343799460158,1.32286929696047,1.36572646925309,1.39692623429492,2.23159987914807,1.11295432721357,2.06139278406697,0.813197382250498,-0.247247472077839,0.665907240768355,-11.7342517017326,0.777315543956241,7.53058909299040,0.479045439014638,2.50477585544920,-1.66410850697707,2.62205661729426,-7.44589702733607,2.58517377722306,3.35456942201613,-7.35854807902637,1.78039301647172,-2.62160062052483,-1.64524946353386,1.18903357533893,-2.28162736268444,1.24537433713206,-3.15665476543248,3.21016807091439,0.716021161325233,2.37541456266206,0.683154999729023,1.92274545342131,1.65035943745531,0.701719425665201,1.55010508048616,0.683154999729023,0.683154999729023,1.50126738478166,0.717473814841430,1.82989807991098,0.875585149905189,1.28124813257018];

tspan = linspace(0,10,6000);

% state = state0;
% state_dot = [];
% for ii = 1 : length(tspan)-1
%     state_dot_temp = EquationOfMotion( tspan(ii),state(:,ii) );
%     state_dot(:,ii) = state_dot_temp;
%     state(:,ii+1) = 0.01*state_dot_temp+state(:,ii);
% end

[t,state] = Mode45(@EquationOfMotion,tspan,state0);

%%
x(:,2) = state(:,1);
x_dot(:,2) = state(:,2);
y(:,2) = state(:,3);
y_dot(:,2) = state(:,4);
theta = state(:,5:12);
theta_dot = state(:,13:20);

u = state(:,21:34);
v = state(:,35:48);

%%
LoadParameter;

x(:,1) = x(:,2) - lp*cos(theta(:,2)) - lH(2)*cos(theta(:,1));
y(:,1) = y(:,2) + lp*sin(theta(:,2)) + lH(2)*sin(theta(:,1));
x(:,3) = x(:,2) + lp*cos(theta(:,2)) + lt*cos(theta(:,3));
y(:,3) = y(:,2) - lp*sin(theta(:,2)) - lt*sin(theta(:,3));
x(:,4) = x(:,2) + lp*cos(theta(:,2)) + lt*cos(theta(:,4));
y(:,4) = y(:,2) - lp*sin(theta(:,2)) - lt*sin(theta(:,4));
x(:,5) = x(:,3) + lt*cos(theta(:,3)) + ls*cos(theta(:,5));
y(:,5) = y(:,3) - lt*sin(theta(:,3)) - ls*sin(theta(:,5));
x(:,6) = x(:,4) + lt*cos(theta(:,4)) + ls*cos(theta(:,6));
y(:,6) = y(:,4) - lt*sin(theta(:,4)) - ls*sin(theta(:,6));
x(:,7) = x(:,5) + ls*cos(theta(:,5)) + lf(1)*cos(theta(:,7));
y(:,7) = y(:,5) - ls*sin(theta(:,5)) - lf(1)*sin(theta(:,7));
x(:,8) = x(:,6) + ls*cos(theta(:,6)) + lf(1)*cos(theta(:,8));
y(:,8) = y(:,6) - ls*sin(theta(:,6)) - lf(1)*sin(theta(:,8));

x_dot(:,1) = x_dot(:,2) + lp.*sin(theta(:,2)).*theta_dot(:,2) + lH(2).*sin(theta(:,1)).*theta_dot(:,1);
y_dot(:,1) = y_dot(:,2) + lp.*cos(theta(:,2)).*theta_dot(:,2) + lH(2).*cos(theta(:,1)).*theta_dot(:,1);
x_dot(:,3) = x_dot(:,2) - lp.*sin(theta(:,2)).*theta_dot(:,2) - lt.*sin(theta(:,3)).*theta_dot(:,3);
y_dot(:,3) = y_dot(:,2) - lp.*cos(theta(:,2)).*theta_dot(:,2) - lt.*cos(theta(:,3)).*theta_dot(:,3);
x_dot(:,4) = x_dot(:,2) - lp.*sin(theta(:,2)).*theta_dot(:,2) - lt.*sin(theta(:,4)).*theta_dot(:,4);
y_dot(:,4) = y_dot(:,2) - lp.*cos(theta(:,2)).*theta_dot(:,2) - lt.*cos(theta(:,4)).*theta_dot(:,4);
x_dot(:,5) = x_dot(:,3) - lt.*sin(theta(:,3)).*theta_dot(:,3) - ls.*sin(theta(:,5)).*theta_dot(:,5);
y_dot(:,5) = y_dot(:,3) - lt.*cos(theta(:,3)).*theta_dot(:,3) - ls.*cos(theta(:,5)).*theta_dot(:,5);
x_dot(:,6) = x_dot(:,4) - lt.*sin(theta(:,4)).*theta_dot(:,4) - ls.*sin(theta(:,6)).*theta_dot(:,6);
y_dot(:,6) = y_dot(:,4) - lt.*cos(theta(:,4)).*theta_dot(:,4) - ls.*cos(theta(:,6)).*theta_dot(:,6);
x_dot(:,7) = x_dot(:,5) - ls.*sin(theta(:,5)).*theta_dot(:,5) - lf(1).*sin(theta(:,7)).*theta_dot(:,7);
y_dot(:,7) = y_dot(:,5) - ls.*cos(theta(:,5)).*theta_dot(:,5) - lf(1).*cos(theta(:,7)).*theta_dot(:,7);
x_dot(:,8) = x_dot(:,6) - ls.*sin(theta(:,6)).*theta_dot(:,6) - lf(1).*sin(theta(:,8)).*theta_dot(:,8);
y_dot(:,8) = y_dot(:,6) - ls.*cos(theta(:,6)).*theta_dot(:,6) - lf(1).*cos(theta(:,8)).*theta_dot(:,8);


%% joint position

head(:,1) = x(:,1) - lH(2)*cos(theta(:,1));
head(:,2) = y(:,1) + lH(2)*sin(theta(:,1));

waist(:,1) = x(:,2) - lp*cos(theta(:,2));
waist(:,2) = y(:,2) + lp*sin(theta(:,2));

hip(:,1) = x(:,4) - lt*cos(theta(:,4));
hip(:,2) = y(:,4) + lt*sin(theta(:,4));

knee_right(:,1) = x(:,6) - ls*cos(theta(:,6));
knee_right(:,2) = y(:,6) + ls*sin(theta(:,6));

ankle_right(:,1) = x(:,8) - lf(1)*cos(theta(:,8));
ankle_right(:,2) = y(:,8) + lf(1)*sin(theta(:,8));

knee_left(:,1) = x(:,5) - ls*cos(theta(:,5));
knee_left(:,2) = y(:,5) + ls*sin(theta(:,5));

ankle_left(:,1) = x(:,7) - lf(1)*cos(theta(:,7));
ankle_left(:,2) = y(:,7) + lf(1)*sin(theta(:,7));

heel_right(:,1) = x(:,8) - lf(2)*cos(Alpha(1)-theta(:,8));
heel_right(:,2) = y(:,8) - lf(2)*sin(Alpha(1)-theta(:,8));

heel_left(:,1) = x(:,7) - lf(2)*cos(Alpha(1)-theta(:,7));
heel_left(:,2) = y(:,7) - lf(2)*sin(Alpha(1)-theta(:,7));

toe_right(:,1) = x(:,8) + lf(3)*cos(Alpha(2)+theta(:,8)-pi);
toe_right(:,2) = y(:,8) - lf(3)*sin(Alpha(2)+theta(:,8)-pi);

toe_left(:,1) = x(:,7) + lf(3)*cos(Alpha(2)+theta(:,7)-pi);
toe_left(:,2) = y(:,7) - lf(3)*sin(Alpha(2)+theta(:,7)-pi);


% xr(1) = x(7)-lf(2)*cos(Alpha(1)-theta(7));
% xr(2) = x(8)-lf(2)*cos(Alpha(1)-theta(8));
% xr(3) = x(7)+lf(3)*cos(Alpha(2)+theta(7)-pi);
% xr(4) = x(8)+lf(3)*cos(Alpha(2)+theta(8)-pi);

clear Alpha b Beta bg Epsilon g lf lg lH ii lp ls lt k kg If IH Ip Is It ...
    mf mH mp ms mt p p_i q tau tau_prime u0 w w_0
%%
figure()
lin = linspace(0,1,10);
for ii = 1 : 50 : 800
    scatter(head(ii,1),head(ii,2),'k');
    hold on;
    scatter(waist(ii,1),waist(ii,2),'k');
    hold on;
    scatter(hip(ii,1),hip(ii,2),'k');
    hold on;
    scatter(knee_right(ii,1),knee_right(ii,2),'k');
    hold on;
    scatter(ankle_right(ii,1),ankle_right(ii,2),'k');
    hold on;
    scatter(knee_left(ii,1),knee_left(ii,2),'k');
    hold on;
    scatter(ankle_left(ii,1),ankle_left(ii,2),'k');
    hold on;
    plot(waist(ii,1)+(head(ii,1)-waist(ii,1))*lin,waist(ii,2)+(head(ii,2)-waist(ii,2))*lin,'m');
    hold on;
    plot(hip(ii,1)+(waist(ii,1)-hip(ii,1))*lin,hip(ii,2)+(waist(ii,2)-hip(ii,2))*lin,'m');
    hold on;
    plot(knee_right(ii,1)+(hip(ii,1)-knee_right(ii,1))*lin,knee_right(ii,2)+(hip(ii,2)-knee_right(ii,2))*lin,'r');
    hold on;
    plot(ankle_right(ii,1)+(knee_right(ii,1)-ankle_right(ii,1))*lin,ankle_right(ii,2)+(knee_right(ii,2)-ankle_right(ii,2))*lin,'r');
    hold on;
    plot(toe_right(ii,1)+(ankle_right(ii,1)-toe_right(ii,1))*lin,toe_right(ii,2)+(ankle_right(ii,2)-toe_right(ii,2))*lin,'r');
    hold on;
    plot(heel_right(ii,1)+(ankle_right(ii,1)-heel_right(ii,1))*lin,heel_right(ii,2)+(ankle_right(ii,2)-heel_right(ii,2))*lin,'r');
    hold on;
    plot(toe_right(ii,1)+(heel_right(ii,1)-toe_right(ii,1))*lin,toe_right(ii,2)+(heel_right(ii,2)-toe_right(ii,2))*lin,'r');
    hold on;
    plot(knee_left(ii,1)+(hip(ii,1)-knee_left(ii,1))*lin,knee_left(ii,2)+(hip(ii,2)-knee_left(ii,2))*lin,'b');
    hold on;
    plot(ankle_left(ii,1)+(knee_left(ii,1)-ankle_left(ii,1))*lin,ankle_left(ii,2)+(knee_left(ii,2)-ankle_left(ii,2))*lin,'b');
    hold on;
    plot(toe_left(ii,1)+(ankle_left(ii,1)-toe_left(ii,1))*lin,toe_left(ii,2)+(ankle_left(ii,2)-toe_left(ii,2))*lin,'b');
    hold on;
    plot(heel_left(ii,1)+(ankle_left(ii,1)-heel_left(ii,1))*lin,heel_left(ii,2)+(ankle_left(ii,2)-heel_left(ii,2))*lin,'b');
    hold on;
    plot(toe_left(ii,1)+(heel_left(ii,1)-toe_left(ii,1))*lin,toe_left(ii,2)+(heel_left(ii,2)-toe_left(ii,2))*lin,'b');
    hold on;
end

plot(lin*6,Yg(0)*ones(10,1),'k')
% xlim([0.8 1.8]);
axis equal
axis([0,4,-0.05,1.8]);

%% analysis
% for ii = 1 : size(state,1)
% 
% [ xf(ii,:),xf_dot(ii,:),yf(ii,:),yf_dot(ii,:) ] = HeelAndToe( x(ii,:)',x_dot(ii,:)',y(ii,:)',y_dot(ii,:)',theta(ii,:)',theta_dot(ii,:)' );
% 
% [ Fgy(ii,:) ] = GroundReactionForceY( x(ii,:)',theta(ii,:)',xf(ii,:),xf_dot(ii,:),yf(ii,:),yf_dot(ii,:) );
% % [ Fgx(ii,:),Fgy(ii,:) ] = GroundReactionForce( x(ii,:)',theta(ii,:)',xf(ii,:),xf_dot(ii,:),yf(ii,:),yf_dot(ii,:) );
% 
% [ phi(ii,:),phi_dot(ii,:) ] = GlobalAngle( x(ii,:)',x_dot(ii,:)',y(ii,:)',y_dot(ii,:)',theta(ii,:)',Fgy(ii,:) );
% 
% [ Sron(ii,:),Sroff(ii,:),Slon(ii,:),Sloff(ii,:),Sg(ii,:),Srst(ii,:),Slst(ii,:) ] = GlobalState( Fgy(ii,:),xf(ii,:),yf(ii,:),phi(ii,:) );
% 
% % [ Fgx(ii,:) ] = GroundReactionForceX( x(ii,:)',theta(ii,:)',xf(ii,:),xf_dot(ii,:),yf(ii,:),yf_dot(ii,:),Sg(ii,:) );
% 
% [ Tp(ii,:) ] = PassiveJointTorque( theta(ii,:)',theta_dot(ii,:)' );
% 
% [ Tm(ii,:) ] = MotorCommands( theta(ii,:)',theta_dot(ii,:)',u(ii,:)',Sron(ii,:),Sroff(ii,:),Slon(ii,:),Sloff(ii,:),Srst(ii,:),Slst(ii,:) );
% 
% [ Ta(ii,:) ] = ActiveJointTorque( Tm(ii,:) );

% end
%%
% figure();
% 
% subplot(2,2,1)
% plot(Ta(:,5))
% xlim([10 50])
% ylim([-100,100])
% subplot(2,2,2)
% plot(Tp(:,5))
% xlim([10 50])
% ylim([-20,20])
% subplot(2,2,3)
% plot(Ta(:,7))
% xlim([10 50])
% ylim([-100,100])
% subplot(2,2,4)
% plot(Tp(:,7))
% xlim([10 50])
% ylim([-20,20])