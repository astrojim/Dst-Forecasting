function [penout,extra] = pen_lagged_extra(x,y,xtol,ytol,lag)
% x and y are assumed to be the same length
% x is cause C
% y is effect E

% extra[1].ytol is the points within the ytol of the first point, etc.
% extra[1].xtol is the points within the ytol of the first point, etc.

for iter = 1:1:(length(y)-lag),
	extra(iter).ytolsamp = [];
    extra(iter).xtolsamp = [];
end;

% Calculate the conditional P(E|C), i.e. P(y_t|x_{t-lag}) along with P(E) and P(C), i.e. P(y_t) and P(x_{t-lag}), [given that C _must preceed_ E in time???]
pEyesCvec = nan(1,length(y)-lag);
pyesCvec = nan(1,length(y)-lag);
pEvec = nan(1,length(y)-lag);

pEyesC_count = 0;
pyesC_count = 0;
pE_count = 0;
extraflag = true;
for iterYcompare = (1+lag):1:length(y),
    for iterYcheck = (1+lag):1:length(y),
        if( tolcheck(y(iterYcheck),y(iterYcompare),ytol) && tolcheck(x(iterYcheck-lag),x(iterYcompare-lag),xtol) ),
            pEyesC_count = pEyesC_count + 1;
        end;
        if( tolcheck(x(iterYcheck-lag),x(iterYcompare-lag),xtol) ),
            if( extraflag ), 
                extra(iterYcompare-lag).xtolsamp(1) = x(iterYcheck-lag);
            else
                extra(iterYcompare-lag).xtolsamp(end+1) = x(iterYcheck-lag);
            end;
            pyesC_count = pyesC_count + 1;
        end;
        if( tolcheck(y(iterYcheck),y(iterYcompare),ytol) ),
            if( extraflag ), 
                extra(iterYcompare-lag).ytolsamp(1) = y(iterYcheck);
            else
                extra(iterYcompare-lag).ytolsamp(end+1) = y(iterYcheck);
            end;
            pE_count = pE_count + 1;
        end;

    end;
    
    pEyesCvec(1,iterYcompare-lag) = pEyesC_count;
    pyesCvec(1,iterYcompare-lag) = pyesC_count;
    pEvec(1,iterYcompare-lag) = pE_count;
    pEyesC_count = 0;
    pyesC_count = 0;
    pE_count = 0;
    extraflag = false;
end;

pEgC = nan(1,length(y)-lag);
pC = nan(1,length(y)-lag);
pE = nan(1,length(y)-lag);
for iter = 1:1:length(pEgC),
    
    if( pyesCvec(1,iter) ~= 0 )
        pEgC(1,iter) = pEyesCvec(1,iter)/pyesCvec(1,iter);
    end;
    pC(1,iter) = pyesCvec(1,iter)/(length(x)-lag);
    pE(1,iter) = pEvec(1,iter)/(length(x)-lag);

end;

% Calculate penchants
penout = nan(1,length(pEgC));
for iter = 1:1:length(pEgC),
	penout(1,iter) = pEgC(iter)*(1+(pC(iter)/(1-pC(iter))))-(pE(iter)/(1-pC(iter)));
    if(pC(iter) == 1), warning('P(C) = 1; Division by zero in penchant calculation %i',iter); end;
end;