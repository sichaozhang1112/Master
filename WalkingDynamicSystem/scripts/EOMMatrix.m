function [ DMatrix,CMatrix,GMatrix,TMatrix,TauMatrix ] = EOMMatrix( x,x_dot,y,y_dot,theta,theta_dot,u,v )

% phi: x(1:8),y(9:16),theta(17:24)
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
[ Ta,Tp,Fgx,Fgy,Q,S ] = NeuroMusculoSkeletal( x,x_dot,y,y_dot,theta,theta_dot,u,v );

%%
DMatrix(1,1) = mH+mp+2*mt+2*ms+2*mf;
DMatrix(1,2) = 0;
DMatrix(1,3) = mH*lH(2)*sin(theta(1));
DMatrix(1,4) = (mH-2*mt-2*ms-2*mf)*lp*sin(theta(2));
DMatrix(1,5) = (-mt-2*ms-2*mf)*lt*sin(theta(3));
DMatrix(1,6) = (-mt-2*ms-2*mf)*lt*sin(theta(4));
DMatrix(1,7) = (-ms-2*mf)*ls*sin(theta(5));
DMatrix(1,8) = (-ms-2*mf)*ls*sin(theta(6));
DMatrix(1,9) = (-mf)*lf(1)*sin(theta(7));
DMatrix(1,10) = (-mf)*lf(1)*sin(theta(8));

CMatrix(1,1) = 0;
CMatrix(1,2) = 0;
CMatrix(1,3) = mH*lH(2)*cos(theta(1))*theta_dot(1);
CMatrix(1,4) = (mH-2*mt-2*ms-2*mf)*lp*cos(theta(2))*theta_dot(2);
CMatrix(1,5) = (-mt-2*ms-2*mf)*lt*cos(theta(3))*theta_dot(3);
CMatrix(1,6) = (-mt-2*ms-2*mf)*lt*cos(theta(4))*theta_dot(4);
CMatrix(1,7) = (-ms-2*mf)*ls*cos(theta(5))*theta_dot(5);
CMatrix(1,8) = (-ms-2*mf)*ls*cos(theta(6))*theta_dot(6);
CMatrix(1,9) = (-mf)*lf(1)*cos(theta(7))*theta_dot(7);
CMatrix(1,10) = (-mf)*lf(1)*cos(theta(8))*theta_dot(8);

TMatrix(1,:) = 0;

GMatrix(1,:) = 0;

TauMatrix(1,:) = Fgx(1)+Fgx(2)+Fgx(3)+Fgx(4);

%
DMatrix(2,1) = 0;
DMatrix(2,2) = mH+mp+2*mt+2*ms+2*mf;
DMatrix(2,3) = mH*lH(2)*cos(theta(1));
DMatrix(2,4) = (mH-2*mt-2*ms-2*mf)*lp*cos(theta(2));
DMatrix(2,5) = (-mt-2*ms-2*mf)*lt*cos(theta(3));
DMatrix(2,6) = (-mt-2*ms-2*mf)*lt*cos(theta(4));
DMatrix(2,7) = (-ms-2*mf)*ls*cos(theta(5));
DMatrix(2,8) = (-ms-2*mf)*ls*cos(theta(6));
DMatrix(2,9) = (-mf)*lf(1)*cos(theta(7));
DMatrix(2,10) = (-mf)*lf(1)*cos(theta(8));

CMatrix(2,1) = 0;
CMatrix(2,2) = 0;
CMatrix(2,3) = -mH*lH(2)*sin(theta(1))*theta_dot(1);
CMatrix(2,4) = -(mH-2*mt-2*ms-2*mf)*lp*sin(theta(2))*theta_dot(2);
CMatrix(2,5) = -(-mt-2*ms-2*mf)*lt*sin(theta(3))*theta_dot(3);
CMatrix(2,6) = -(-mt-2*ms-2*mf)*lt*sin(theta(4))*theta_dot(4);
CMatrix(2,7) = -(-ms-2*mf)*ls*sin(theta(5))*theta_dot(5);
CMatrix(2,8) = -(-ms-2*mf)*ls*sin(theta(6))*theta_dot(6);
CMatrix(2,9) = mf*lf(1)*sin(theta(7))*theta_dot(7);
CMatrix(2,10) = mf*lf(1)*sin(theta(8))*theta_dot(8);

TMatrix(2,:) = 0;

GMatrix(2,:) = mH*g+mp*g+2*mt*g+2*ms*g+2*mf*g;

TauMatrix(2,:) = Fgy(1)+Fgy(2)+Fgy(3)+Fgy(4);

%
DMatrix(3,1) = mH*lH(2)*sin(theta(1));
DMatrix(3,2) = mH*lH(2)*cos(theta(1));
DMatrix(3,3) = (IH+mH*lH(2)^2);
DMatrix(3,4) = mH*lH(2)*lp*cos(theta(1)-theta(2));
DMatrix(3,5) = 0;
DMatrix(3,6) = 0;
DMatrix(3,7) = 0;
DMatrix(3,8) = 0;
DMatrix(3,9) = 0;
DMatrix(3,10) = 0;

CMatrix(3,1) = 0;
CMatrix(3,2) = 0;
CMatrix(3,3) = 0;
CMatrix(3,4) = mH*lH(2)*lp*sin(theta(1)-theta(2))*theta_dot(2);
CMatrix(3,5) = 0;
CMatrix(3,6) = 0;
CMatrix(3,7) = 0;
CMatrix(3,8) = 0;
CMatrix(3,9) = 0;
CMatrix(3,10) = 0;

TMatrix(3,:) = Ta(1)+Tp(1);

GMatrix(3,:) = mH*lH(2)*cos(theta(1))*g;

TauMatrix(3,:) = 0;

%
DMatrix(4,1) = (mH-2*mt-2*ms-2*mf)*lp*sin(theta(2));
DMatrix(4,2) = (mH-2*mt-2*ms-2*mf)*lp*cos(theta(2));
DMatrix(4,3) = mH*lH(2)*lp*cos(theta(1)-theta(2));
DMatrix(4,4) = (Ip+mH*lp^2+2*mt*lp^2+2*ms*lp^2+2*mf*lp^2);
DMatrix(4,5) = (mt+2*ms+2*mf)*lp*lt*cos(theta(2)-theta(3));
DMatrix(4,6) = (mt+2*ms+2*mf)*lp*lt*cos(theta(2)-theta(4));
DMatrix(4,7) = (ms+2*mf)*lp*ls*cos(theta(2)-theta(5));
DMatrix(4,8) = (ms+2*mf)*lp*ls*cos(theta(2)-theta(6));
DMatrix(4,9) = mf*lp*lf(1)*cos(theta(2)-theta(7));
DMatrix(4,10) = mf*lp*lf(1)*cos(theta(2)-theta(8));

CMatrix(4,1) = 0;
CMatrix(4,2) = 0;
CMatrix(4,3) = -mH*lH(2)*lp*sin(theta(1)-theta(2))*theta_dot(1);
CMatrix(4,4) = 0;
CMatrix(4,5) = (mt+2*ms+2*mf)*lp*lt*sin(theta(2)-theta(3))*theta_dot(3);
CMatrix(4,6) = (mt+2*ms+2*mf)*lp*lt*sin(theta(2)-theta(4))*theta_dot(4);
CMatrix(4,7) = (ms+2*mf)*lp*ls*sin(theta(2)-theta(5))*theta_dot(5);
CMatrix(4,8) = (ms+2*mf)*lp*ls*sin(theta(2)-theta(6))*theta_dot(6);
CMatrix(4,9) = mf*lp*lf(1)*sin(theta(2)-theta(7))*theta_dot(7);
CMatrix(4,10) = mf*lp*lf(1)*sin(theta(2)-theta(8))*theta_dot(8);

TMatrix(4,:) = -(Ta(1)+Tp(1))+Ta(2)+Tp(2)+Ta(3)+Tp(3);

GMatrix(4,:) = (mH-2*mt-2*ms-2*mf)*lp*cos(theta(2))*g;

TauMatrix(4,:) = -(Fgx(1)+Fgx(2)+Fgx(3)+Fgx(4))*lp*sin(theta(2))-(Fgy(1)+Fgy(2)+Fgy(3)+Fgy(4))*lp*cos(theta(2));

%
DMatrix(5,1) = (-mt-2*ms-2*mf)*lt*sin(theta(3));
DMatrix(5,2) = (-mt-2*ms-2*mf)*lt*cos(theta(3));
DMatrix(5,3) = 0;
DMatrix(5,4) = (mt+2*ms+2*mf)*lp*lt*cos(theta(2)-theta(3));
DMatrix(5,5) = (It+mt*lt^2+4*ms*lt^2+4*mf*lt^2);
DMatrix(5,6) = 0;
DMatrix(5,7) = (2*ms+4*mf)*lt*ls*cos(theta(3)-theta(5));
DMatrix(5,8) = 0;
DMatrix(5,9) = 2*mf*lt*lf(1)*cos(theta(3)-theta(7));
DMatrix(5,10) = 0;

CMatrix(5,1) = 0;
CMatrix(5,2) = 0;
CMatrix(5,3) = 0;
CMatrix(5,4) = (-mt-2*ms-2*mf)*lp*lt*sin(theta(2)-theta(3))*theta_dot(2);
CMatrix(5,5) = 0;
CMatrix(5,6) = 0;
CMatrix(5,7) = (2*ms+4*mf)*lt*ls*sin(theta(3)-theta(5))*theta_dot(5);
CMatrix(5,8) = 0;
CMatrix(5,9) = 2*mf*lt*lf(1)*sin(theta(3)-theta(7))*theta_dot(7);
CMatrix(5,10) = 0;

TMatrix(5,:) = -(Ta(2)+Tp(2))-(Ta(4)+Tp(4));

GMatrix(5,:) = (-mt-2*ms-2*mf)*lt*cos(theta(3))*g;

TauMatrix(5,:) = -2*(Fgx(1)+Fgx(3))*lt*sin(theta(3))-2*(Fgy(1)+Fgy(3))*lt*cos(theta(3));

%
DMatrix(6,1) = (-mt-2*ms-2*mf)*lt*sin(theta(4));
DMatrix(6,2) = (-mt-2*ms-2*mf)*lt*cos(theta(4));
DMatrix(6,3) = 0;
DMatrix(6,4) = (mt+2*ms+2*mf)*lp*lt*cos(theta(2)-theta(4));
DMatrix(6,5) = 0;
DMatrix(6,6) = (It+mt*lt^2+4*ms*lt^2+4*mf*lt^2);
DMatrix(6,7) = 0;
DMatrix(6,8) = (2*ms+4*mf)*lt*ls*cos(theta(4)-theta(6));
DMatrix(6,9) = 0;
DMatrix(6,10) = 2*mf*lt*lf(1)*cos(theta(4)-theta(8));

CMatrix(6,1) = 0;
CMatrix(6,2) = 0;
CMatrix(6,3) = 0;
CMatrix(6,4) = (-mt-2*ms-2*mf)*lp*lt*sin(theta(2)-theta(4))*theta_dot(2);
CMatrix(6,5) = 0;
CMatrix(6,6) = 0;
CMatrix(6,7) = 0;
CMatrix(6,8) = (2*ms+4*mf)*lt*ls*sin(theta(4)-theta(6))*theta_dot(6);
CMatrix(6,9) = 0;
CMatrix(6,10) = 2*mf*lt*lf(1)*sin(theta(4)-theta(8))*theta_dot(8);

TMatrix(6,:) = -(Ta(3)+Tp(3))-(Ta(5)+Tp(5));

GMatrix(6,:) = (-mt-2*ms-2*mf)*lt*cos(theta(4))*g;

TauMatrix(6,:) = -2*(Fgx(2)+Fgx(4))*lt*sin(theta(4))-2*(Fgy(2)+Fgy(4))*lt*cos(theta(4));

%
DMatrix(7,1) = (-ms-2*mf)*ls*sin(theta(5));
DMatrix(7,2) = (-ms-2*mf)*ls*cos(theta(5));
DMatrix(7,3) = 0;
DMatrix(7,4) = (ms+2*mf)*lp*ls*cos(theta(2)-theta(5));
DMatrix(7,5) = (2*ms+4*mf)*lt*ls*cos(theta(3)-theta(5));
DMatrix(7,6) = 0;
DMatrix(7,7) = (Is+ms*ls^2+4*mf*ls^2);
DMatrix(7,8) = 0;
DMatrix(7,9) = 2*mf*ls*lf(1)*cos(theta(5)-theta(7));
DMatrix(7,10) = 0;

CMatrix(7,1) = 0;
CMatrix(7,2) = 0;
CMatrix(7,3) = 0;
CMatrix(7,4) = (-ms-2*mf)*lp*ls*sin(theta(2)-theta(5))*theta_dot(2);
CMatrix(7,5) = -(2*ms+4*mf)*lt*ls*sin(theta(3)-theta(5))*theta_dot(3);
CMatrix(7,6) = 0;
CMatrix(7,7) = 0;
CMatrix(7,8) = 0;
CMatrix(7,9) = 2*mf*ls*lf(1)*sin(theta(5)-theta(7))*theta_dot(7);
CMatrix(7,10) = 0;

TMatrix(7,:) = (Ta(4)+Tp(4))+(Ta(6)+Tp(6));

GMatrix(7,:) = (-ms-2*mf)*ls*cos(theta(5))*g;

TauMatrix(7,:) = -2*(Fgx(1)+Fgx(3))*ls*sin(theta(5))-2*(Fgy(1)+Fgy(3))*ls*cos(theta(5));

%
DMatrix(8,1) = (-ms-2*mf)*ls*sin(theta(6));
DMatrix(8,2) = (-ms-2*mf)*ls*cos(theta(6));
DMatrix(8,3) = 0;
DMatrix(8,4) = (ms+2*mf)*lp*ls*cos(theta(2)-theta(6));
DMatrix(8,5) = 0;
DMatrix(8,6) = (2*ms+4*mf)*lt*ls*cos(theta(4)-theta(6));
DMatrix(8,7) = 0;
DMatrix(8,8) = (Is+ms*ls^2+4*mf*ls^2);
DMatrix(8,9) = 0;
DMatrix(8,10) = 2*mf*ls*lf(1)*cos(theta(6)-theta(8));

CMatrix(8,1) = 0;
CMatrix(8,2) = 0;
CMatrix(8,3) = 0;
CMatrix(8,4) = (-ms-2*mf)*lp*ls*sin(theta(2)-theta(6))*theta_dot(2);
CMatrix(8,5) = 0;
CMatrix(8,6) = -(2*ms+4*mf)*lt*ls*sin(theta(4)-theta(6))*theta_dot(4);
CMatrix(8,7) = 0;
CMatrix(8,8) = 0;
CMatrix(8,9) = 0;
CMatrix(8,10) = 2*mf*ls*lf(1)*sin(theta(6)-theta(8))*theta_dot(8);

TMatrix(8,:) = (Ta(5)+Tp(5))+(Ta(7)+Tp(7));

GMatrix(8,:) = (-ms-2*mf)*ls*cos(theta(6))*g;

TauMatrix(8,:) = -2*(Fgx(2)+Fgx(4))*ls*sin(theta(6))-2*(Fgy(2)+Fgy(4))*ls*cos(theta(6));

%
DMatrix(9,1) = (-mf)*lf(1)*sin(theta(7));
DMatrix(9,2) = (-mf)*lf(1)*cos(theta(7));
DMatrix(9,3) = 0;
DMatrix(9,4) = mf*lp*lf(1)*cos(theta(2)-theta(7));
DMatrix(9,5) = 2*mf*lt*lf(1)*cos(theta(3)-theta(7));
DMatrix(9,6) = 0;
DMatrix(9,7) = 2*mf*ls*lf(1)*cos(theta(5)-theta(7));
DMatrix(9,8) = 0;
DMatrix(9,9) = (If+mf*lf(1)^2);
DMatrix(9,10) = 0;

CMatrix(9,1) = 0;
CMatrix(9,2) = 0;
CMatrix(9,3) = 0;
CMatrix(9,4) = (-mf)*lp*lf(1)*sin(theta(2)-theta(7))*theta_dot(2);
CMatrix(9,5) = (-2*mf)*lt*lf(1)*sin(theta(3)-theta(7))*theta_dot(3);
CMatrix(9,6) = 0;
CMatrix(9,7) = (-2*mf)*ls*lf(1)*sin(theta(5)-theta(7))*theta_dot(5);
CMatrix(9,8) = 0;
CMatrix(9,9) = 0;
CMatrix(9,10) = 0;

TMatrix(9,:) = -(Ta(6)+Tp(6));

GMatrix(9,:) = (-mf)*lf(1)*cos(theta(7))*g;

TauMatrix(9,:) = (lf(1)*sin(theta(7))-lf(2)*sin(Alpha(1)-theta(7)))*Fgx(1) ...
                +(lf(1)*cos(theta(7))+lf(2)*cos(Alpha(1)-theta(7)))*Fgy(1) ...
                +(lf(1)*sin(theta(7))+lf(3)*sin(Alpha(2)+theta(7)))*Fgx(3) ...
                +(lf(1)*cos(theta(7))+lf(3)*cos(Alpha(2)+theta(7)))*Fgy(3); 

%
DMatrix(10,1) = (-mf)*lf(1)*sin(theta(8));
DMatrix(10,2) = (-mf)*lf(1)*cos(theta(8));
DMatrix(10,3) = 0;
DMatrix(10,4) = mf*lp*lf(1)*cos(theta(2)-theta(8));
DMatrix(10,5) = 0;
DMatrix(10,6) = 2*mf*lt*lf(1)*cos(theta(4)-theta(8));
DMatrix(10,7) = 0;
DMatrix(10,8) = 2*mf*ls*lf(1)*cos(theta(6)-theta(8));
DMatrix(10,9) = 0;
DMatrix(10,10) = (If+mf*lf(1)^2);

CMatrix(10,1) = 0;
CMatrix(10,2) = 0;
CMatrix(10,3) = 0;
CMatrix(10,4) = (-mf)*lp*lf(1)*sin(theta(2)-theta(8))*theta_dot(2);
CMatrix(10,5) = 0;
CMatrix(10,6) = (-2*mf)*lt*lf(1)*sin(theta(4)-theta(8))*theta_dot(4);
CMatrix(10,7) = 0;
CMatrix(10,8) = (-2*mf)*ls*lf(1)*sin(theta(6)-theta(8))*theta_dot(6);
CMatrix(10,9) = 0;
CMatrix(10,10) = 0;

TMatrix(10,:) = -(Ta(7)+Tp(7));

GMatrix(10,:) = (-mf)*lf(1)*cos(theta(8))*g;

TauMatrix(10,:) = (lf(1)*sin(theta(8))-lf(2)*sin(Alpha(1)-theta(8)))*Fgx(2) ...
                +(lf(1)*cos(theta(8))+lf(2)*cos(Alpha(1)-theta(8)))*Fgy(2) ...
                +(lf(1)*sin(theta(8))+lf(3)*sin(Alpha(2)+theta(8)))*Fgx(4) ...
                +(lf(1)*cos(theta(8))+lf(3)*cos(Alpha(2)+theta(8)))*Fgy(4); 
%

end

