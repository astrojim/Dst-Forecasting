function [XYvar YXvar] = LIRvariance(X_unnorm,Y_unnorm,deltabinnum,compbinnum)
% descriptive comments

% normalize the TS data to make the variance comparison
X = (X_unnorm-mean(X_unnorm))./std(X_unnorm);
Y = (Y_unnorm-mean(Y_unnorm))./std(Y_unnorm);

% create and bin the delta TS data
deltaX = zeros(length(X)-1,1);
for iter = 1:1:(length(X)-1),
	deltaX(iter,1) = X(iter+1)-X(iter);
end;

deltaY = zeros(length(Y)-1,1);
for iter = 1:1:(length(Y)-1),
	deltaY(iter,1) = Y(iter+1)-Y(iter);
end;

[deltaX_tstruct,deltaX_cnts] = hist_extra(deltaX(1:end-1),deltabinnum);
[deltaY_tstruct,deltaY_cnts] = hist_extra(deltaY(1:end-1),deltabinnum);

%Calculate LIR XY variance
XYvar_vec = zeros(deltabinnum,compbinnum);
for iter = 1:1:length(deltaX_tstruct),
    if( deltaX_tstruct(iter).tcount ~= 0 ),
        [deltaXbin_tstruct,deltaXbin_cnts] = hist_extra(Y(deltaX_tstruct(iter).tsteps),compbinnum);
        for subiter = 1:1:length(deltaXbin_tstruct),
            if( deltaXbin_tstruct(subiter).tcount ~= 0 ),
                XYvar_vec(iter,subiter) = var(Y(deltaXbin_tstruct(subiter).tsteps+2));
            end;
        end;
    end;
end;

%Calculate LIR YX variance
YXvar_vec = zeros(deltabinnum,compbinnum);
for iter = 1:1:length(deltaY_tstruct),
    if( deltaY_tstruct(iter).tcount ~= 0 ),
        [deltaYbin_tstruct,deltaYbin_cnts] = hist_extra(X(deltaY_tstruct(iter).tsteps),compbinnum);
        for subiter = 1:1:length(deltaYbin_tstruct),
            if( deltaYbin_tstruct(subiter).tcount ~= 0 ),
                YXvar_vec(iter,subiter) = var(X(deltaYbin_tstruct(subiter).tsteps+2));
            end;
        end;
    end;
end;

XYvar = XYvar_vec;
YXvar = YXvar_vec;
