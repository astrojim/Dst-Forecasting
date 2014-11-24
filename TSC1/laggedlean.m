function lenmat = laggedlean(C,E,nbins,tol,lags)

lenmat = nan(length(lags),2);

for iter = 1:1:length(lags),
    
    penvec = laggedpen(C,E,nbins,tol,lags(iter));
    lenmat(iter,1) = penvec(1,1) - penvec(1,2);
    
    penvec = laggedpen(E,C,nbins,tol,lags(iter));
    lenmat(iter,2) = penvec(1,1) - penvec(1,2);
    
end;