function [lags_xcorrs] = crosscorr(X,Y,nlags)

lags_xcorrs = zeros(2*nlags+1,2);
if( length(X) < 2*nlags ),
	fprintf('Throw Error crosscorr(): Requested %i lags (which requires %i time steps), but length(X) = %i\n',nlags,2*nlags,length(X));
end;
if( length(Y) < 2*nlags ),
	fprintf('Throw Error crosscorr(): Requested %i lags (which requires %i time steps), but length(Y) = %i\n',nlags,2*nlags,length(Y));
end;

for lag = 1:1:nlags,
	lags_xcorrs(lag,1) = -1*(nlags-lag+1);
    lags_xcorrs(nlags+lag+1,1) = lag;
end;

starting_pnt = nlags+1;
ending_pnt = length(X)-nlags-1;
for lag=1:1:size(lags_xcorrs,1),
    lags_xcorrs(lag,2) = (corr(X(starting_pnt+lags_xcorrs(lag,1):ending_pnt+lags_xcorrs(lag,1))',Y(starting_pnt:ending_pnt)'))^2;
end;