function penvec = laggedpen(C,E,nbins,lag)

if( lag >= 0 ),
    tempC = C(1:(end-lag));
    tempE = E((1+lag):end);
else
    tempC = C((1-lag):end);
    tempE = E(1:(end+lag));
end;
penvec = penchants(tempC,tempE,nbins);
%penvec(1,2) = mean_ignorezero(penchants(tempE,tempC,nbins),tol);
