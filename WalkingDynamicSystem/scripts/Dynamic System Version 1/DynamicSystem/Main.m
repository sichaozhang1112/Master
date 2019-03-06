LoadInitialCondition;
% x(2),y(2),x_dot(2),y_dot(2),theta,theta_dot,u,v
% state0 = [x;x_dot;y;y_dot;theta;theta_dot;u;v];

% from stage 1
% state0 = [1.23071256995671,1.56417709560143,0.976581362580517,0.227607918954957,1.56734940913545,1.66407398844351,1.27167344501037,1.83632056780471,1.41844734294901,1.86239678573901,1.04735167955819,1.41868477004676,-1.58665612098669,-0.842780518451415,7.16182301851594,0.383112681083317,4.19119512720938,2.28213049879307,15.4373866594594,5.15303980946651,-2.32859556785453,2.94176611488193,-10.9342269869630,4.00249044858728,3.56318846354716,-8.62504326517471,3.15969275951159,-6.35427242196342,-6.01709011910381,2.98962389207949,-7.60076523342364,3.62639543792040,-3.76865310153250,3.74714821104065,0.709052338739424,2.54022604836917,0.705634338580542,1.97597942414193,1.59735179694550,0.725536968664847,1.58927603712058,0.705634338580542,0.705634338580542,1.56539459333847,0.743218628117627,1.90496874234268,0.934359195990941,1.17665786478781];

% from stage 2 
% state0 = [1.29531877210694,0.691436552105798,0.993774410311465,0.458972683423047,1.54949152005421,1.67096787484412,1.40541057644895,1.49540811660383,1.39378522165889,2.17046742899485,1.13626285851030,2.26771104083059,1.10013824054827,-0.187223770183373,0.197454167577433,-10.1770888352627,0.924363490790118,1.90291437570240,1.40560294995883,39.4474524915725,1.45452083024663,0.716624676908848,-7.02445543337681,2.17307713911162,3.20435181926403,-7.26234632109786,1.73782167725216,-2.81569472678899,-1.86170944126301,1.16319384802976,-1.82988516384222,1.09172657172857,-3.70608076135380,3.11649167904451,0.668271071241004,2.42417490158865,0.648345061504595,2.05515043568201,1.75292124522637,0.666072931869913,1.64582318586635,0.648345061504595,0.648345061504595,1.59290240631472,0.681915938414800,1.90986057863902,0.825730230107310,1.42424067704040];
% state0(33) = 0;

% state0 = [2.52771548085684,0.697874809480220,0.976804947456291,-0.293749077169773,1.56027504555099,1.65533994211545,1.44011406528143,1.64183341493103,1.40429167313075,2.16913241019865,1.07825121208696,2.47193271968603,1.62021569987325,1.18231059633869,0.770315068544864,-5.85178970792954,1.07625353283531,1.54472158685594,-3.21360603011879,2.67261052947295,2.99229314958329,-2.04506344786673,-10.2028206923837,2.10746529770891,3.66515581249824,-10.6872717133585,0.813894740390381,0.184790075359767,0.641682094609757,0.181922007476972,-3.01355169562167,0.312013079502246,0,0.317372100998148,1.00448308331570,2.54274390415080,1.15002343714970,2.41021740381201,1.81688679889482,1.28940807068151,1.75248900514976,0.718563298531294,0.786445119302844,1.77721297611474,1.26520936177165,2.27245180980920,0.178069235763704,1.76810332158357];

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