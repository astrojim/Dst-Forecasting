function lenmat = laggedlean(C,E,nbins,tol,lags)

%lenmat = nan(length(lags),2);
lenmat = nan(length(lags),1);

for iter = 1:1:length(lags),
    
    penvecCE = laggedpen(C,E,nbins,lags(iter));
    penvecEC = laggedpen(E,C,nbins,lags(iter));
    lenmat(iter,1) = mean_ignorezero(penvecCE,tol) - mean_ignorezero(penvecEC,tol);
    
    %penvec = laggedpen(E,C,nbins,tol,lags(iter));
    %lenmat(iter,2) = penvec(1,1) - penvec(1,2);
    
end;