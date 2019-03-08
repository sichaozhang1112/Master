function [ state_dot ] = EquationOfMotion( t,state )

% LoadParameter;
%% parameters
% the body parameters and the ground parameters
mH = 38.0; lH(1) = 0.4; lH(2) = 0.3;
IH = 1.1399; mp = 10.0; lp = 0.1; Ip = 0.05;
mt = 7.0; lt = 0.2; It = 0.0933; ms = 3.0;
ls = 0.2; Is = 0.0399;
mf = 1.0; lf(1) = 0.08; lf(2) = 0.12; lf(3) = 0.10;
Alpha(1) = 1.22; Alpha(2) = 2.44; If = 0.0032;
k(1) = 1000.0; k(2) = 500.0;
b(1) = 10.0; b(2) = 1.0; b(3) = 100.0; b(4) = 1000.0;
Epsilon(1) = 1.0; Epsilon(2) = 0.5; Epsilon(3) = 1.0;
g = 9.8; kg = 30000.0; bg = 1000.0;
% the parameters in the neural oscialltors
tau(1) = 1/32; tau(2) = 1/32;
tau(3:14) = 1/18*ones(1,14-3+1);
tau_prime(1) = 1/2.656; tau_prime(2) = 1/2.656;
tau_prime(3:14) = 1/1.494*ones(1,14-3+1);
for ii = 1 : 7
    w_0(2*ii-1,2*ii) = -2.0;
    w_0(2*ii,2*ii-1) = -2.0;
end
Beta = 2.5; u0 = 6.0;
% the strength of the neural connections
w_0(3,5) = -1.0; w_0(5,3) = -1.0;
w_0(4,6) = -1.0; w_0(6,4) = -1.0;
w_0(7,9) = -1.0; w_0(9,7) = -1.0;
w_0(8,10) = -1.0; w_0(10,8) = -1.0;
w_0(11,13) = -0.2; w_0(13,11) = -0.2;
w_0(12,14) = -0.2; w_0(14,12) = -0.2;
w_0(2,4) = 1.0; w_0(2,6) = 1.0;
w(1) = 0.1; w(2) = 0.2;
% the magnitude of the coefficients in the rythmic force controller
p(1) = 5.0; p(2) = 10.0; p(3) = 4.0; p(4) = 2.0; p(5) = 15.0;
p(6) = 4.0; p(7) = 3.0; p(8) = 2.0; p(9) = 15.0;
p(10) = 8.0; p(11) = 2.0; p(12) = 3.0;
p(13) = 2.0; p(14) = 8.0; p(15) = 1.5; 
p(16) = 12.0; p(17) = 1.0; p(18) = 7.0;
% the strength of the sensory inputs
q(1) = 6.0; q(2) = 0.9; q(3) = 1.5;
q(4) = 1.5; q(5) = 3.0; q(6) = 3.0;
q(7) = 0.1; q(8) = 0.2;
% the impedance parameters
p_i(1) = 500.0; p_i(2) = 10.0; p_i(3) = 800.0;
p_i(4) = 20.0; p_i(5) = 150.0; p_i(6) = 10.0; p_i(7) = 10.0; 

%%
x = zeros(8,1);
y = zeros(8,1);
x_dot = zeros(8,1);
y_dot = zeros(8,1);

x(2) = state(1);
x_dot(2) = state(2);
y(2) = state(3);
y_dot(2) = state(4);
theta = state(5:12);
theta_dot = state(13:20);

u = state(21:34);
v = state(35:48);

%%
x(1) = x(2) - lp*cos(theta(2)) - lH(2)*cos(theta(1));
y(1) = y(2) + lp*sin(theta(2)) + lH(2)*sin(theta(1));
x(3) = x(2) + lp*cos(theta(2)) + lt*cos(theta(3));
y(3) = y(2) - lp*sin(theta(2)) - lt*sin(theta(3));
x(4) = x(2) + lp*cos(theta(2)) + lt*cos(theta(4));
y(4) = y(2) - lp*sin(theta(2)) - lt*sin(theta(4));
x(5) = x(3) + lt*cos(theta(3)) + ls*cos(theta(5));
y(5) = y(3) - lt*sin(theta(3)) - ls*sin(theta(5));
x(6) = x(4) + lt*cos(theta(4)) + ls*cos(theta(6));
y(6) = y(4) - lt*sin(theta(4)) - ls*sin(theta(6));
x(7) = x(5) + ls*cos(theta(5)) + lf(1)*cos(theta(7));
y(7) = y(5) - ls*sin(theta(5)) - lf(1)*sin(theta(7));
x(8) = x(6) + ls*cos(theta(6)) + lf(1)*cos(theta(8));
y(8) = y(6) - ls*sin(theta(6)) - lf(1)*sin(theta(8));

x_dot(1) = x_dot(2) + lp*sin(theta(2))*theta_dot(2) + lH(2)*sin(theta(1))*theta_dot(1);
y_dot(1) = y_dot(2) + lp*cos(theta(2))*theta_dot(2) + lH(2)*cos(theta(1))*theta_dot(1);
x_dot(3) = x_dot(2) - lp*sin(theta(2))*theta_dot(2) - lt*sin(theta(3))*theta_dot(3);
y_dot(3) = y_dot(2) - lp*cos(theta(2))*theta_dot(2) - lt*cos(theta(3))*theta_dot(3);
x_dot(4) = x_dot(2) - lp*sin(theta(2))*theta_dot(2) - lt*sin(theta(4))*theta_dot(4);
y_dot(4) = y_dot(2) - lp*cos(theta(2))*theta_dot(2) - lt*cos(theta(4))*theta_dot(4);
x_dot(5) = x_dot(3) - lt*sin(theta(3))*theta_dot(3) - ls*sin(theta(5))*theta_dot(5);
y_dot(5) = y_dot(3) - lt*cos(theta(3))*theta_dot(3) - ls*cos(theta(5))*theta_dot(5);
x_dot(6) = x_dot(4) - lt*sin(theta(4))*theta_dot(4) - ls*sin(theta(6))*theta_dot(6);
y_dot(6) = y_dot(4) - lt*cos(theta(4))*theta_dot(4) - ls*cos(theta(6))*theta_dot(6);
x_dot(7) = x_dot(5) - ls*sin(theta(5))*theta_dot(5) - lf(1)*sin(theta(7))*theta_dot(7);
y_dot(7) = y_dot(5) - ls*cos(theta(5))*theta_dot(5) - lf(1)*cos(theta(7))*theta_dot(7);
x_dot(8) = x_dot(6) - ls*sin(theta(6))*theta_dot(6) - lf(1)*sin(theta(8))*theta_dot(8);
y_dot(8) = y_dot(6) - ls*cos(theta(6))*theta_dot(6) - lf(1)*cos(theta(8))*theta_dot(8);

%%
xytheta_dot = [x_dot(2);y_dot(2);theta_dot];

%%
[ Ta,Tp,Fgx,Fgy,Q,S,Sg,Sron,Sroff,Slon,Sloff,Srst,Slst ] = NeuroMusculoSkeletal( x,x_dot,y,y_dot,theta,theta_dot,u,v );
[ DMatrix,CMatrix,GMatrix,TMatrix,TauMatrix ] = EOMMatrix( x,x_dot,y,y_dot,theta,theta_dot,u,v );

xytheta_dotdot = inv(DMatrix)*(TauMatrix-TMatrix-GMatrix-CMatrix*xytheta_dot);

x_dotdot(2) = xytheta_dotdot(1);
y_dotdot(2) = xytheta_dotdot(2);
theta_dotdot = xytheta_dotdot(3:10);

u_dot = zeros(14,1);
v_dot = zeros(14,1);

for ii = 1 : 14
    u_dot(ii) = (1/tau(ii))*(-u(ii)-Beta*fun(v(ii))+w_0(ii,:)*fun(u)+u0+Q(ii)+S(ii));
    v_dot(ii) = (1/tau_prime(ii))*(-v(ii)+fun(u(ii)));
end
%%
u_dot(13)=0.01*u_dot(13);
u_dot(14)=1*u_dot(14);
%%
state_dot = [x_dot(2);x_dotdot(2);y_dot(2);y_dotdot(2);theta_dot;theta_dotdot;u_dot;v_dot];

end

