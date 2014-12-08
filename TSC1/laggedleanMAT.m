function lenmat = laggedleanMAT(C,E,nbins,tol,lags)

% lenmat = nan(length(lags),2);

for iter = 1:1:length(lags),
    
    penvecCE = laggedpen(C,E,nbins,lags(iter));
    penvecEC = laggedpen(E,C,nbins,lags(iter));
    lenmat(iter,1,:) = penvecCE;
    lenmat(iter,2,:) = penvecEC;
    
end;