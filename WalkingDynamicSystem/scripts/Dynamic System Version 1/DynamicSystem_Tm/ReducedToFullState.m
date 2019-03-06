function [ x,x_dot,y,y_dot,theta,theta_dot ] = ReducedToFullState( ReducedState )

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

%%
x = zeros(8,1);
y = zeros(8,1);
x_dot = zeros(8,1);
y_dot = zeros(8,1);

x(2) = ReducedState(1);
x_dot(2) = ReducedState(2);
y(2) = ReducedState(3);
y_dot(2) = ReducedState(4);
theta = ReducedState(5:12);
theta_dot = ReducedState(13:20);

u = ReducedState(21:34);
v = ReducedState(35:48);

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

end