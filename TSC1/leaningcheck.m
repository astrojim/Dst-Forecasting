function report = leaningcheck(x,y,xtol,ytol,lags,truth)
% The mean lean is checked for truth comparison

% truth := 1 if x->y
% truth := -1 if y->x
% truth := 0 if undefined

if( truth ~= 0 && truth ~= 1 && truth ~= -1 ),
    error('Truth is not formatted correctly.');
end;

leansout = leans_lagged(x,y,xtol,ytol,lags);

leansoutmean = mean(leansout(:,2));
guess = nan;
if( leansoutmean > 0  ),
    guess = 1;
end;
if( leansoutmean < 0  ),
    guess = -1;
end;
if( leansoutmean == 0 ),
    guess = 0;
end;

if( guess == truth ),
    report = true;
else
    report = false;
end;