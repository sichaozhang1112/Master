function [ phi,phi_dot ] = GlobalAngle( x,x_dot,y,y_dot,theta,Fgy )

% LoadParameter;
mH = 38.0; lH(1) = 0.4; lH(2) = 0.3;
IH = 1.1399; mp = 10.0; lp = 0.1; Ip = 0.05;
mt = 7.0; lt = 0.2; It = 0.0933; ms = 3.0;
ls = 0.2; Is = 0.0399;
mf = 1.0; lf(1) = 0.08; lf(2) = 0.12; lf(3) = 0.10;
Alpha(1) = 1.22; Alpha(2) = 2.44; If = 0.0032;

m = zeros(8,1);
m(1) = mH; 
m(3) = mt; m(4) = mt;
m(2) = mp;
m(5) = ms; m(6) = ms;
m(7) = mf; m(8) = mf;

xcg = sum(m.*x)/sum(m);
ycg = sum(m.*y)/sum(m);

xcg_dot = sum(m.*x_dot)/sum(m);
ycg_dot = sum(m.*y_dot)/sum(m);

xr(1) = x(7)-lf(2)*cos(Alpha(1)-theta(7));
xr(2) = x(8)-lf(2)*cos(Alpha(1)-theta(8));
xr(3) = x(7)+lf(3)*cos(Alpha(2)+theta(7)-pi);
xr(4) = x(8)+lf(3)*cos(Alpha(2)+theta(8)-pi);

xcp = sum(Fgy.*xr)/sum(Fgy);
ycp = 0;

phi = acos((xcp-xcg)/(((xcp-xcg)^2+(ycp-ycg)^2)^0.5));
phi_dot = ((ycg-ycp)*xcg_dot+(xcp-xcg)*ycg_dot)/((xcp-xcg)^2+(ycp-ycg)^2);

end

