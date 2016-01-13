
% load X and Y
[x,y] = CoolingSystemTemps();


addpath('leans_exec');
xtol = (max(x)-min(x))/4;
ytol = (max(y)-min(y))/4;

leans_stored = nan(50,1);
for iter = 1:1:50,
    
    fprintf('working %i ...',iter);
    LCClags = 1:1:iter;
    leanings = nan(length(LCClags),1);
    for lag_iter = 1:1:length(LCClags),
        leantemp = leans_lagged(x,y,xtol,ytol,LCClags(lag_iter));
        leanings(lag_iter,1) = leantemp(1,2);
    end;

    leans_stored(iter,1) = mean(leanings);
    fprintf(' done.\n');
end;
