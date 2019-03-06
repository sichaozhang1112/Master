function [ S ] = StateDependentInput( theta,theta_dot,phi,phi_dot,Sg,Srst,Slst,Sroff,Sloff )

% LoadParameter;

% the strength of the sensory inputs
q(1) = 6.0; q(2) = 0.9; q(3) = 1.5;
q(4) = 1.5; q(5) = 3.0; q(6) = 3.0;
q(7) = 0.1; q(8) = 0.2;

S(1) = -q(1)*(theta(1)-0.55*pi)-q(2)*theta_dot(1);
S(2) = -S(1);
S(3) = q(3)*(theta(3)-pi/2)+Slst*q(4)*(theta(5)-pi/2) ...
    +(Srst-Slst)*q(5)*(phi-pi/2);
S(4) = -S(3);
S(5) = q(3)*(theta(4)-pi/2)+Srst*q(4)*(theta(6)-pi/2) ...
    +(Slst-Srst)*q(5)*(phi-pi/2);
S(6) = -S(5);
S(7) = q(4)*(theta(5)-pi/2)+(-Srst+Slst)*q(5)*fun(pi/2-phi);
S(8) = -S(7);
S(9) = q(4)*(theta(6)-pi/2)+(-Slst+Srst)*q(5)*fun(pi/2-phi);
S(10) = -S(9);
S(11) = Sroff*q(6)*(theta(7)-0.9948)-Srst*q(4)*(theta(5)-pi/2) ...
    -(Srst+Sg(5)+Sg(6))*q(5)*(phi-pi/2)-Sg(4)*q(5)*fun(pi/2-phi) ...
    -(Sg(1)*q(7)+Sg(3)*q(8))*phi_dot;
S(12) = -S(11);
S(13) = Sloff*q(6)*(theta(8)-0.9948)-Slst*q(4)*(theta(6)-pi/2) ...
    -(Slst+Sg(2)+Sg(3))*q(5)*(phi-pi/2)-Sg(1)*q(5)*fun(pi/2-phi) ...
    -(Sg(4)*q(7)+Sg(6)*q(8))*phi_dot;
S(14) = -S(13);


end

