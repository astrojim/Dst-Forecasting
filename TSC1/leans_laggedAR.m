function leanout = leans_laggedAR(x,y,xtol,ytol,lags,lagsAR)
% This is constructed such that a positive leaning means x drives y more 
% than y drives x (and vice versa for a negative leaning).

leans = nan(length(lags),2);

for liter = 1:1:length(lags),
    leans(liter,1) = lags(liter);
    leans(liter,2) = mean(pen_laggedAR(x,y,xtol,ytol,lags(liter),lagsAR(liter))-pen_laggedAR(y,x,ytol,xtol,lags(liter),lagsAR(liter)));
end;
    
leanout = leans;