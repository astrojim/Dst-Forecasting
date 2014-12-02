function [x y] = wTS(L,B,hittimes,hitpnts)

x = zeros(L,1);
y = x;

step = 1;
for iter = 1:1:L,
    if( step <= length(hittimes) && iter == hittimes(step) ),
        x(iter) = hitpnts(step);
        step = step+1;
    end;
    
    if( iter == 1 ),
        y(iter) = B*randn();
    else
        y(iter) = x(iter-1)+B*randn();
    end;
end;