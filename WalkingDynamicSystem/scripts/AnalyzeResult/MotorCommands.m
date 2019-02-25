function [ Tm ] = MotorCommands( theta,theta_dot,u,Sron,Sroff,Slon,Sloff,Srst,Slst )

% LoadParameter;

% the magnitude of the coefficients in the rythmic force controller
p(1) = 5.0; p(2) = 10.0; p(3) = 4.0; p(4) = 2.0; p(5) = 15.0;
p(6) = 4.0; p(7) = 3.0; p(8) = 2.0; p(9) = 15.0;
p(10) = 8.0; p(11) = 2.0; p(12) = 3.0;
p(13) = 2.0; p(14) = 8.0; p(15) = 1.5; 
p(16) = 12.0; p(17) = 1.0; p(18) = 7.0;
% the impedance parameters
p_i(1) = 500.0; p_i(2) = 10.0; p_i(3) = 800.0;
p_i(4) = 20.0; p_i(5) = 150.0; p_i(6) = 10.0; p_i(7) = 10.0; 

Tmr(1) = p(1)*fun(u(1));
Tmr(2) = p(2)*fun(u(2));
Tmr(3) = (Sron*p(3)+Sroff*p(4))*fun(u(3));
Tmr(4) = (Sron*p(5)+Sroff*p(6))*fun(u(4));
Tmr(5) = (Slon*p(3)+Sloff*p(4))*fun(u(5));
Tmr(6) = (Slon*p(5)+Sloff*p(6))*fun(u(6));
Tmr(7) = (Sron*p(7)+Sroff*p(8))*fun(u(3));
Tmr(8) = (Sron*p(9)+Sroff*p(10))*fun(u(4));
Tmr(9) = (Slon*p(7)+Sloff*p(8))*fun(u(5));
Tmr(10) = (Slon*p(9)+Sloff*p(10))*fun(u(6));
Tmr(11) = Slst*p(11)*fun(u(7));
Tmr(12) = (Sron*p(12)+Sroff*p(13))*fun(u(8));
Tmr(13) = Srst*p(11)*fun(u(9));
Tmr(14) = (Slon*p(12)+Sloff*p(13))*fun(u(10));
Tmr(15) = (Sron*p(14)+Sroff*p(15))*fun(u(11));
Tmr(16) = (Sron*p(16)+Sroff*p(17))*fun(u(12));
Tmr(17) = (Slon*p(14)+Sloff*p(15))*fun(u(13));
Tmr(18) = (Slon*p(16)+Sloff*p(17))*fun(u(14));
Tmr(19) = Sron*p(18)*fun(u(12));
Tmr(20) = Slon*p(18)*fun(u(14));

Tmi(1) = p_i(1)*fun(theta(2)-theta(1))+p_i(2)*(theta_dot(2)-theta_dot(1));
Tmi(2) = p_i(1)*fun(theta(1)-theta(2))+p_i(2)*(theta_dot(1)-theta_dot(2));
Tmi(3) = Sron*p_i(3)*fun(0.55*pi-theta(2)) ...
    +Sron*p_i(4)*fun(-theta_dot(2));
Tmi(4) = Sron*p_i(3)*fun(theta(2)-0.55*pi) ...
    +Sron*p_i(4)*fun(theta_dot(2));
Tmi(5) = Slon*p_i(3)*fun(0.55*pi-theta(2)) ...
    +Slon*p_i(4)*fun(-theta_dot(2));
Tmi(6) = Slon*p_i(3)*fun(theta(2)-0.55*pi) ...
    +Slon*p_i(4)*fun(theta_dot(2));
Tmi(7) = 0.0;
Tmi(8) = 0.0;
Tmi(9) = 0.0;
Tmi(10) = 0.0;
Tmi(11) = 0.0;
Tmi(12) = Srst*p_i(5)*fun(theta(5)-theta(3)) ...
    +Srst*p_i(6)*fun(theta_dot(5)-theta_dot(3));
Tmi(13) = 0.0;
Tmi(14) = Slst*p_i(5)*fun(theta(6)-theta(4)) ...
    +Slst*p_i(6)*fun(theta_dot(6)-theta_dot(4));
Tmi(15) = Srst*p_i(7)*fun(theta_dot(7)-theta_dot(5));
Tmi(16) = Srst*p_i(7)*fun(theta_dot(5)-theta_dot(7));
Tmi(17) = Slst*p_i(7)*fun(theta_dot(8)-theta_dot(6));
Tmi(18) = Slst*p_i(7)*fun(theta_dot(6)-theta_dot(8));
Tmi(19) = 0.0;
Tmi(20) = 0.0;

Tm = Tmr + Tmi;
%
% Tm(15)=0;
%
end

