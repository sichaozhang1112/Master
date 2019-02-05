function [ Fgy ] = GroundReactionForceY( x,theta,xf,xf_dot,yf,yf_dot )

% LoadParameter;
kg = 30000.0; bg = 1000.0;
lf(1) = 0.08; lf(2) = 0.12; lf(3) = 0.10;
Alpha(1) = 1.22; Alpha(2) = 2.44;

% if yf(1)<=0 && yf(3)<=0
%     xft(1) = xf(3);
%     xft(3) = xf(1);
% else
%     xft(1) = xf(1);
%     xft(3) = xf(3);
% end
% 
% if yf(2)<=0 && yf(4)<=0
%     xft(2) = xf(4);
%     xft(4) = xf(2);
% else
%     xft(2) = xf(2);
%     xft(4) = xf(4);
% end

% xft = 0.01*zeros(4,1);
for ii = 1 : 4
%     Fgx(ii) = (-kg*(xf(ii)-xft(ii))-bg*xf_dot(ii))*lun(-yf(ii));
    Fgy(ii) = (-kg*(yf(ii))+bg*fun(-yf_dot(ii)))*lun(-yf(ii));
end

end