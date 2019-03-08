%% the musculoskeletal system
x = zeros(8,1);
y = zeros(8,1);
x_dot = zeros(8,1);
y_dot = zeros(8,1);
theta = zeros(8,1);
theta_dot = zeros(8,1);
u = zeros(14,1);
v = zeros(14,1);

x(2) = 1.000; 
y(2) = 0.984;
x_dot(2) = 0.7; y_dot(2) = 0.0;
theta(1) = 1.714; 
theta(2) = 1.588;
theta(4) = 1.618;
theta(6) = 1.623;
theta(3) = 0.653; 
theta(5) = 1.418;
theta(7) = 0.543; 
theta(8) = 0.984;
theta_dot(1) = 0.0; theta_dot(2) = 0.0;
theta_dot(3) = -1.0; theta_dot(4) = 1.0;
theta_dot(5) = -5.0; theta_dot(6) = 2.0;
theta_dot(7) = -8.0; theta_dot(8) = 0.0;

%%
% [ x,y,x_dot,y_dot ] = KinematicConstraint( x,y,x_dot,y_dot,thet,thet_dot );

% LoadParameter;
% 
% x(1) = x(2) - lp*cos(theta(2)) - lH(2)*cos(theta(1));
% y(1) = y(2) + lp*sin(theta(2)) + lH(2)*sin(theta(1));
% x(3) = x(2) + lp*cos(theta(2)) + lt*cos(theta(3));
% y(3) = y(2) - lp*sin(theta(2)) - lt*sin(theta(3));
% x(4) = x(2) + lp*cos(theta(2)) + lt*cos(theta(4));
% y(4) = y(2) - lp*sin(theta(2)) - lt*sin(theta(4));
% x(5) = x(3) + lt*cos(theta(3)) + ls*cos(theta(5));
% y(5) = y(3) - lt*sin(theta(3)) - ls*sin(theta(5));
% x(6) = x(4) + lt*cos(theta(4)) + ls*cos(theta(6));
% y(6) = y(4) - lt*sin(theta(4)) - ls*sin(theta(6));
% x(7) = x(5) + ls*cos(theta(5)) + lf(1)*cos(theta(7));
% y(7) = y(5) - ls*sin(theta(5)) - lf(1)*sin(theta(7));
% x(8) = x(6) + ls*cos(theta(6)) + lf(1)*cos(theta(8));
% y(8) = y(6) - ls*sin(theta(6)) - lf(1)*sin(theta(8));
% 
% x_dot(1) = x_dot(2) + lp*sin(theta(2))*theta_dot(2) + lH(2)*sin(theta(1))*theta_dot(1);
% y_dot(1) = y_dot(2) + lp*cos(theta(2))*theta_dot(2) + lH(2)*cos(theta(1))*theta_dot(1);
% x_dot(3) = x_dot(2) - lp*sin(theta(2))*theta_dot(2) - lt*sin(theta(3))*theta_dot(3);
% y_dot(3) = y_dot(2) - lp*cos(theta(2))*theta_dot(2) - lt*cos(theta(3))*theta_dot(3);
% x_dot(4) = x_dot(2) - lp*sin(theta(2))*theta_dot(2) - lt*sin(theta(4))*theta_dot(4);
% y_dot(4) = y_dot(2) - lp*cos(theta(2))*theta_dot(2) - lt*cos(theta(4))*theta_dot(4);
% x_dot(5) = x_dot(3) - lt*sin(theta(3))*theta_dot(3) - ls*sin(theta(5))*theta_dot(5);
% y_dot(5) = y_dot(3) - lt*cos(theta(3))*theta_dot(3) - ls*cos(theta(5))*theta_dot(5);
% x_dot(6) = x_dot(4) - lt*sin(theta(4))*theta_dot(4) - ls*sin(theta(6))*theta_dot(6);
% y_dot(6) = y_dot(4) - lt*cos(theta(4))*theta_dot(4) - ls*cos(theta(6))*theta_dot(6);
% x_dot(7) = x_dot(5) - ls*sin(theta(5))*theta_dot(5) - lf(1)*sin(theta(7))*theta_dot(7);
% y_dot(7) = y_dot(5) - ls*cos(theta(5))*theta_dot(5) - lf(1)*cos(theta(7))*theta_dot(7);
% x_dot(8) = x_dot(6) - ls*sin(theta(6))*theta_dot(6) - lf(1)*sin(theta(8))*theta_dot(8);
% y_dot(8) = y_dot(6) - ls*cos(theta(6))*theta_dot(6) - lf(1)*cos(theta(8))*theta_dot(8);

%% the neural rythm generator
u(1) = 1.0; u(2) = -1.0; u(3) = -1.0; u(4) = 1.0;
u(5) = 1.0; u(6) = 1.0; u(7) = 1.0; u(8) = -1.0;
u(9) = -1.0; u(10) = 1.0; 
u(11) = 1.0; u(12) = -1.0; 
u(13) = 1.0; u(14) = -1.0;

for ii = 1 : 14
    v(ii) = 1.0;
end

%%
% state0 = [x;x_dot;y;y_dot;theta;theta_dot;u;v];
state0 = [x(2);x_dot(2);y(2);y_dot(2);theta;theta_dot;u;v];

%%
clear Alpha b Beta bg Epsilon g lf lg lH ii lp ls lt k kg If IH Ip Is It ...
    mf mH mp ms mt p p_i q tau tau_prime u0 w w_0 x y x_dot y_dot theta theta_dot u v 