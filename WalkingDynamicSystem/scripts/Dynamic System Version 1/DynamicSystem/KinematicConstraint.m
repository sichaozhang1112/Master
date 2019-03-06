function [ X,Y,X_dot,Y_dot ] = KinematicConstraint( x,y,x_dot,y_dot,thet,thet_dot )

% LoadParameter
mH = 38.0; lH(1) = 0.4; lH(2) = 0.3;
IH = 1.1399; mp = 10.0; lp = 0.1; Ip = 0.05;
mt = 7.0; lt = 0.2; It = 0.0933; ms = 3.0;
ls = 0.2; Is = 0.0399;
mf = 1.0; lf(1) = 0.08; lf(2) = 0.12; lf(3) = 0.10;
Alpha(1) = 1.22; Alpha(2) = 2.44; If = 0.0032;

x(1) = x(2) - lp*cos(thet(2)) - lH(2)*cos(thet(1));
y(1) = y(2) + lp*sin(thet(2)) + lH(2)*sin(thet(1));
x(3) = x(2) + lp*cos(thet(2)) + lt*cos(thet(3));
y(3) = y(2) - lp*sin(thet(2)) - lt*sin(thet(3));
x(4) = x(2) + lp*cos(thet(2)) + lt*cos(thet(4));
y(4) = y(2) - lp*sin(thet(2)) - lt*sin(thet(4));
x(5) = x(3) + lt*cos(thet(3)) + ls*cos(thet(5));
y(5) = y(3) - lt*sin(thet(3)) - ls*sin(thet(5));
x(6) = x(4) + lt*cos(thet(4)) + ls*cos(thet(6));
y(6) = y(4) - lt*sin(thet(4)) - ls*sin(thet(6));
x(7) = x(5) + ls*cos(thet(5)) + lf(1)*cos(thet(7));
y(7) = y(5) - ls*sin(thet(5)) - lf(1)*sin(thet(7));
x(8) = x(6) + ls*cos(thet(6)) + lf(1)*cos(thet(8));
y(8) = y(6) - ls*sin(thet(6)) - lf(1)*sin(thet(8));

x_dot(1) = x_dot(2) + lp*sin(thet(2))*thet_dot(2) + lH(2)*sin(thet(1))*thet_dot(1);
y_dot(1) = y_dot(2) + lp*cos(thet(2))*thet_dot(2) + lH(2)*cos(thet(1))*thet_dot(1);
x_dot(3) = x_dot(2) - lp*sin(thet(2))*thet_dot(2) - lt*sin(thet(3))*thet_dot(3);
y_dot(3) = y_dot(2) - lp*cos(thet(2))*thet_dot(2) - lt*cos(thet(3))*thet_dot(3);
x_dot(4) = x_dot(2) - lp*sin(thet(2))*thet_dot(2) - lt*sin(thet(4))*thet_dot(4);
y_dot(4) = y_dot(2) - lp*cos(thet(2))*thet_dot(2) - lt*cos(thet(4))*thet_dot(4);
x_dot(5) = x_dot(3) - lt*sin(thet(3))*thet_dot(3) - ls*sin(thet(5))*thet_dot(5);
y_dot(5) = y_dot(3) - lt*cos(thet(3))*thet_dot(3) - ls*cos(thet(5))*thet_dot(5);
x_dot(6) = x_dot(4) - lt*sin(thet(4))*thet_dot(4) - ls*sin(thet(6))*thet_dot(6);
y_dot(6) = y_dot(4) - lt*cos(thet(4))*thet_dot(4) - ls*cos(thet(6))*thet_dot(6);
x_dot(7) = x_dot(5) - ls*sin(thet(5))*thet_dot(5) - lf(1)*sin(thet(7))*thet_dot(7);
y_dot(7) = y_dot(5) - ls*cos(thet(5))*thet_dot(5) - lf(1)*cos(thet(7))*thet_dot(7);
x_dot(8) = x_dot(6) - ls*sin(thet(6))*thet_dot(6) - lf(1)*sin(thet(8))*thet_dot(8);
y_dot(8) = y_dot(6) - ls*cos(thet(6))*thet_dot(6) - lf(1)*cos(thet(8))*thet_dot(8);

X = x;
Y = y;
X_dot = x_dot;
Y_dot = y_dot;

end

