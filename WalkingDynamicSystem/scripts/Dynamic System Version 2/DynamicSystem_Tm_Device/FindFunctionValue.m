function [ f_tofind ] = FindFunctionValue( t,f,t_tofind )

for ii = 1 : max(size(t))-1
    JudgeValue(ii) = abs(t(ii)-t_tofind)+abs(t(ii+1)-t_tofind);
end

Position = find(JudgeValue==min(JudgeValue));

position = Position(1);

f_tofind = f(position)+(f(position+1)-f(position))*(t_tofind-t(position))/(t(position+1)-t(position));

end

