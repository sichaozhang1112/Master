function [ u13,Tm17 ] = CalculateU13andTm17FromStates( x,x_dot,y,y_dot,theta,theta_dot )

load('PhiToU13.mat');

[ xf,xf_dot,yf,yf_dot ] = HeelAndToe( x,x_dot,y,y_dot,theta,theta_dot );

[ Fgx,Fgy ] = GroundReactionForce( x,theta,xf,xf_dot,yf,yf_dot );

[ phi,phi_dot ] = GlobalAngle( x,x_dot,y,y_dot,theta,Fgy );

[ Sron,Sroff,Slon,Sloff,Sg,Srst,Slst ] = GlobalState( Fgy,xf,yf,phi );

if sum(Sg) == 0
    fprintf('Warning: Sg are all zeros!\n');
    u13 = 0;
end

for ii = 1 : 6
    if Sg(ii) == 1
        phitou13 = PhiToU13{ii};
        u13 = (FindFunctionValue(phitou13(:,1),phitou13(:,2),phi));
    end
end

%%
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

%%

Tm17 = (Slon*p(14)+Sloff*p(15))*fun(u13)+Slst*p_i(7)*fun(theta_dot(8)-theta_dot(6));

end

