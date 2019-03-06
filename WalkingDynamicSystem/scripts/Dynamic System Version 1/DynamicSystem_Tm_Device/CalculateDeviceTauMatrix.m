function [ DeviceTauMatrix ] = CalculateDeviceTauMatrix( x,x_dot,y,y_dot,theta,theta_dot  )

[ u13,Tm17 ] = CalculateU13andTm17FromStates( x,x_dot,y,y_dot,theta,theta_dot );

Tau = [0;0;0;0;-Tm17;0;Tm17];

MatrixTau = [zeros(3,7);-diag(ones(1,7))];

DeviceTauMatrix = MatrixTau * Tau;

end