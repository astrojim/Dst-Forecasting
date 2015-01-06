function leanout = lean(x,y,xtol,ytol)
% This is constructed such that a positive leaning means x drives y more 
% than y drives x (and vice versa for a negative leaning).

leanout = mean(pen(x,y,xtol,ytol)-pen(y,x,xtol,ytol));