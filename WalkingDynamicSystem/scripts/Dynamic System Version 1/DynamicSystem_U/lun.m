function [ lx ] = lun( x )

if x < 0
    lx = 0;
elseif x > 0.01
    lx = 1;
else
    lx = 100*x;
end

end

