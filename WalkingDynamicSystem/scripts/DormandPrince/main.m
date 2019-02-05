y0 = [0,1];
trange = [0;100];
[t,y] = Mode45(@gua,trange,y0); 

plot(y)

function [dy] = gua(t,y)
dy(1,1) = y(2);
dy(2,1) = sin(t);
end