function [ Sron,Sroff,Slon,Sloff,Sg,Srst,Slst ] = GlobalState( Fgy,xf,yf,phi )

Sron = LargeThanZero(Fgy(1)+Fgy(3));
Sroff = 1 - Sron;
Slon = LargeThanZero(Fgy(2)+Fgy(4));
Sloff = 1 - Slon;
Sr = LargeThanZero(xf(1)-xf(2));
Sl = LargeThanZero(xf(2)-xf(1));

Sg(1) = Sron*Slon*Sr;
Sg(2) = Sron*Sloff*LargeThanZero(pi/2-phi);
Sg(3) = Sron*Sloff*LargeThanZero(phi-pi/2);
Sg(4) = Slon*Sron*Sl;
Sg(5) = Slon*Sroff*LargeThanZero(pi/2-phi);
Sg(6) = Slon*Sroff*LargeThanZero(phi-pi/2);

Srst = Sg(1)+Sg(2)+Sg(3);
Slst = Sg(4)+Sg(5)+Sg(6);

end

function [output] = LargeThanZero(input)
if input > 0
    output = 1;
else
    output = 0;
end
end
