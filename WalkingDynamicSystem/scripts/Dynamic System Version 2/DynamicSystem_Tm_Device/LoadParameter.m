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
