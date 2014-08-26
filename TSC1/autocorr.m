function [lags_acorrs] = autocorr(X,nlags)

lags_acorrs = zeros(2*nlags+1,2);
if( length(X) < 2*nlags ),
	fprintf('Throw Error autocorr(): Requested %i lags (which requires %i time steps), but length(X) = %i\n',nlags,2*nlags,length(X));
end;

for lag = 1:1:nlags,
	lags_acorrs(lag,1) = -1*(nlags-lag+1);
    lags_acorrs(nlags+lag+1,1) = lag;
end;

starting_pnt = nlags+1;
ending_pnt = length(X)-nlags-1;
for lag=1:1:size(lags_acorrs,1),
    lags_acorrs(lag,2) = (corr(X(starting_pnt+lags_acorrs(lag,1):ending_pnt+lags_acorrs(lag,1))',X(starting_pnt:ending_pnt)'))^2;
end;