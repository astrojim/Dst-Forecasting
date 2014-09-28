function [XYvar YXvar] = LIRvariance2(X_unnorm,Y_unnorm,deltabinnum,compbinnum)
% descriptive comments

% normalize the TS data to make the variance comparison
X = (X_unnorm-mean(X_unnorm))./std(X_unnorm);
Y = (Y_unnorm-mean(Y_unnorm))./std(Y_unnorm);

% create the delta TS data
deltaX = zeros(length(X)-1,1);
for iter = 1:1:(length(X)-1),
	deltaX(iter,1) = X(iter+1)-X(iter);
end;

deltaY = zeros(length(Y)-1,1);
for iter = 1:1:(length(Y)-1),
	deltaY(iter,1) = Y(iter+1)-Y(iter);
end;

% bin normalized data
[X_tstruct,X_cnts] = hist_extra(X(1:end-1),compbinnum);
[Y_tstruct,Y_cnts] = hist_extra(Y(1:end-1),compbinnum);

%Calculate LIR XY variance
XYvar_vec = zeros(deltabinnum,compbinnum);
for iter = 1:1:length(X_tstruct),
    if( X_tstruct(iter).tcount ~= 0 ),
        [Xbin_tstruct,Xbin_cnts] = hist_extra(deltaY(X_tstruct(iter).tsteps),deltabinnum);
        for subiter = 1:1:length(Xbin_tstruct),
            if( Xbin_tstruct(subiter).tcount ~= 0 ),
                XYvar_vec(subiter,iter) = var(Y(Xbin_tstruct(subiter).tsteps+2));
            end;
        end;
    end;
end;

%Calculate LIR YX variance
YXvar_vec = zeros(deltabinnum,compbinnum);
for iter = 1:1:length(Y_tstruct),
    if( Y_tstruct(iter).tcount ~= 0 ),
        [Ybin_tstruct,Ybin_cnts] = hist_extra(deltaX(Y_tstruct(iter).tsteps),deltabinnum);
        for subiter = 1:1:length(Ybin_tstruct),
            if( Ybin_tstruct(subiter).tcount ~= 0 ),
                YXvar_vec(subiter,iter) = var(X(Ybin_tstruct(subiter).tsteps+2));
            end;
        end;
    end;
end;

XYvar = XYvar_vec;
YXvar = YXvar_vec;
