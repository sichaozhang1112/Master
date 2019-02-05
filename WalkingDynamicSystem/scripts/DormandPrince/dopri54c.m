function [y,stad]=dopri54c(funcion,t0,t1,y0) 
% DOPRI54 solves system of ODEs with the Dormand and Prince 54 code. 
% INPUT 
% funcion - String containing name of user-supplied 
% problem description. 
% Call: yprime = fun(t,y,rpar) where funcion = 'fun'. 
% t - Time (scalar). 
% y - Solution column-vector. 
% rpar - parameters possibly needed in buinding yprime 
% yprime - Returned derivative column-vector; yprime(i) 
% = dy(i)/dt. 
% t0 - Initial value of t. 
% t1 - Final value of t (must be t1 > t0). 
% y0 - Initial value column-vector. 
% tol - tolerance for the local error 
% OUTPUT 
% y - computed solution at y=t1. 
% stad - vector containing number of steps, rejections and 
% function calls 
t=t0; 
y=y0; 
tol=0.0001;
h=tol^(1/5)/4; 
step=0; 
nrej=0; 
fcall=1; 
a4=[44/45 -56/15 32/9]'; 
a5=[19372/6561 -25360/2187 64448/6561 -212/729]'; 
a6=[9017/3168 -355/33 46732/5247 49/176 -5103/18656]'; 
a7=[35/384 0 500/1113 125/192 -2187/6784 11/84]'; 
e=[71/57600 -1/40 -71/16695 71/1920 -17253/339200 22/525]'; 
k1=feval(funcion,t,y); 

while t < t1 
    if t+h > t0
        h=t1-t; 
    end 
    k2=feval(funcion,t+h/5,y+h*k1/5); 
    k3=feval(funcion,t+3*h/10,y+h*(3*k1+9*k2)/40); 
    k4=feval(funcion,t+4*h/5,y+h*(a4(1)*k1+a4(2)*k2+a4(3)*k3)); 
    k5=feval(funcion,t+8*h/9,y+h*(a5(1)*k1+a5(2)*k2+a5(3)*k3+... 
    a5(4)*k4)); 
    k6=feval(funcion,t+h,y+h*(a6(1)*k1+a6(2)*k2+a6(3)*k3+a6(4)*k4+... 
    a6(5)*k5)); 
    yt=y+h*(a7(1)*k1+a7(3)*k3+a7(4)*k4+a7(5)*k5+a7(6)*k6); 
    k2=feval(funcion,t+h,yt); 
    est=norm(h*(e(1)*k1+e(2)*k2+e(3)*k3+e(4)*k4+e(5)*k5+... 
    e(6)*k6),inf); 
    fcall=fcall+6; 
% [t h est] 

    if est < tol 
        t=t+h; 
        k1=k2; 
        step=step+1; 
        y=yt; 
    else 
        nrej=nrej+1; 
    end 
    h=.9*min((tol/(est+eps))^(1/5),10)*h; 

end 
if nargout > 1 
stad=[step nrej fcall]; 
end 