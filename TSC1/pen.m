function penout = pen(x,y,xtol,ytol)
% x and y are assumed to be the same length
% x is cause C
% y is effect E

% Calculate the conditional P(E|C), i.e. P(y_t|x_{t-1}) along with P(E) and P(C), i.e. P(y_t) and P(x_{t-1}), [given that C _must preceed_ E in time???]
pEyesCvec = nan(1,length(y)-1);
pyesCvec = nan(1,length(y)-1);
pEvec = nan(1,length(y)-1);

pEyesC_count = 0;
pyesC_count = 0;
pE_count = 0;
for iterYcompare = 2:1:length(y),
    for iterYcheck = 2:1:length(y),
        if( tolcheck(y(iterYcheck),y(iterYcompare),ytol) && tolcheck(x(iterYcheck-1),x(iterYcompare-1),xtol) ),
            pEyesC_count = pEyesC_count + 1;
        end;
        if( tolcheck(x(iterYcheck-1),x(iterYcompare-1),xtol) ),
            pyesC_count = pyesC_count + 1;
        end;
        if( tolcheck(y(iterYcheck),y(iterYcompare),ytol) ),
            pE_count = pE_count + 1;
        end;

    end;
    
    pEyesCvec(1,iterYcompare-1) = pEyesC_count;
    pyesCvec(1,iterYcompare-1) = pyesC_count;
    pEvec(1,iterYcompare-1) = pE_count;
    pEyesC_count = 0;
    pyesC_count = 0;
    pE_count = 0;
end;

pEgC = pEyesCvec./pyesCvec;
pC = pyesCvec./(length(x)-1);
pE = pEvec./(length(x)-1);

% Calculate penchants
penout = nan(1,length(pEgC));
for iter = 1:1:length(pEgC),
	penout(1,iter) = pEgC(iter)*(1+(pC(iter)/(1-pC(iter))))-(pE(iter)/(1-pC(iter)));
end;