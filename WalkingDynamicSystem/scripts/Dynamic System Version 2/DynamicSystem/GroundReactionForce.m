function [ Fgx,Fgy ] = GroundReactionForce( x,theta,xf,xf_dot,yf,yf_dot )
xft(1)= 11.598921 ;
xft(2)= 12.131843 ;
xft(3)= 11.796104 ;
xft(4)= 12.318854 ;
% LoadParameter;
kg = 30000.0; bg = 1000.0;lf(1) = 0.08; lf(2) = 0.12; lf(3) = 0.10;Alpha(1) = 1.22; Alpha(2) = 2.44;
for ii = 1 : 4
Fgx(ii) = (-kg*(xf(ii)-xft(ii))-bg*xf_dot(ii))*lun(Yg(xft(ii))-yf(ii));
Fgy(ii) = (-kg*(yf(ii)-Yg(xft(ii)))+bg*fun(-yf_dot(ii)))*lun(Yg(xft(ii))-yf(ii));
end
end
