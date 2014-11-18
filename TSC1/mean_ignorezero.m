function ret = mean_ignorezero(vec,tol)

step = 0;
for iter = 1:1:length(vec),
    if( vec(iter) >= tol ),
        step = step+1;
    end;
end;

if( step == 0 ),
    ret = 0;
else
    ret = sum(vec)/step;
end;