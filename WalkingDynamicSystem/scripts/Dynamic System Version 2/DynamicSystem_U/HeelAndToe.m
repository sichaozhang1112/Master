function [ xf,xf_dot,yf,yf_dot ] = HeelAndToe( x,x_dot,y,y_dot,theta,theta_dot )

% LoadParameter;
Alpha(1) = 1.22; Alpha(2) = 2.44;
lf(1) = 0.08; lf(2) = 0.12; lf(3) = 0.10;

xf(1) = x(7) - lf(2)*cos(Alpha(1)-theta(7));
yf(1) = y(7) - lf(2)*sin(Alpha(1)-theta(7));
xf_dot(1) = x_dot(7) - lf(2)*sin(Alpha(1)-theta(7))*theta_dot(7);
yf_dot(1) = y_dot(7) + lf(2)*cos(Alpha(1)-theta(7))*theta_dot(7);

xf(3) = x(7) + lf(3)*cos(Alpha(2)+theta(7)-pi);
yf(3) = y(7) - lf(3)*sin(Alpha(2)+theta(7)-pi);
xf_dot(3) = x_dot(7) - lf(3)*sin(Alpha(2)+theta(7)-pi);
yf_dot(3) = y_dot(7) - lf(3)*cos(Alpha(2)+theta(7)-pi);

xf(2) = x(8) - lf(2)*cos(Alpha(1)-theta(8));
yf(2) = y(8) - lf(2)*sin(Alpha(1)-theta(8));
xf_dot(2) = x_dot(2) - lf(2)*sin(Alpha(1)-theta(8));
yf_dot(2) = y_dot(2) + lf(2)*cos(Alpha(1)-theta(8));

xf(4) = x(8) + lf(3)*cos(Alpha(2)+theta(8)-pi);
yf(4) = y(8) - lf(3)*sin(Alpha(2)+theta(8)-pi);
xf_dot(4) = x_dot(8) - lf(3)*sin(Alpha(2)+theta(8)-pi);
yf_dot(4) = y_dot(8) - lf(3)*cos(Alpha(2)+theta(8)-pi);

end

