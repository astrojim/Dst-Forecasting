function [XYvar YXvar] = LIRvariance4(X_unnorm,Y_unnorm,deltabinnum,drivebinnum,respbinnum)
% descriptive comments

% normalize the TS data to make the variance comparison
%X = (X_unnorm-mean(X_unnorm))./std(X_unnorm);
%Y = (Y_unnorm-mean(Y_unnorm))./std(Y_unnorm);
X = X_unnorm;
Y = Y_unnorm;

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
[X_tstruct,X_cnts] = hist_extra(X(1:end-1),drivebinnum);
[Y_tstruct,Y_cnts] = hist_extra(Y(1:end-1),respbinnum);

% mean calulcation parameters
XYrunningsum = 0;
XYcount = 0;
YXrunningsum = 0;
YXcount = 0;

%Calculate LIR XY variance
XYvar_vec = zeros(drivebinnum,deltabinnum,respbinnum);
for iter = 1:1:length(X_tstruct),
    if( X_tstruct(iter).tcount ~= 0 ),
        [Xbin_tstruct,Xbin_cnts] = hist_extra(deltaX(X_tstruct(iter).tsteps),deltabinnum);
        for subiter = 1:1:length(Xbin_tstruct),
            if( Xbin_tstruct(subiter).tcount ~= 0 ),
            	[dXbin_tstruct,dXbin_cnts] = hist_extra(Y(Xbin_tstruct(subiter).tsteps),respbinnum);
            	for subsubiter = 1:1:length(dXbin_tstruct),
                	if( dXbin_tstruct(subsubiter).tcount ~= 0 ),
            	    	XYvar_vec(iter,subiter,subsubiter) = var(Y(dXbin_tstruct(subsubiter).tsteps+2));
                        XYrunningsum = XYrunningsum + var(Y(dXbin_tstruct(subsubiter).tsteps+2));
                        XYcount = XYcount + 1;
                        %Y(dXbin_tstruct(subsubiter).tsteps+2)
            		else
            			XYvar_vec(iter,subiter,subsubiter) = nan;
            		end;
        		end;
            else
            	for subsubiter = 1:1:respbinnum,
                	XYvar_vec(iter,subiter,subsubiter) = nan;
           	    end;
            end;
        end;
    else
    	for subiter = 1:1:deltabinnum,
        	for subsubiter = 1:1:respbinnum,
               	XYvar_vec(iter,subiter,subsubiter) = nan;
            end;
        end;
    end;
end;

%Calculate LIR YX variance
YXvar_vec = zeros(drivebinnum,deltabinnum,respbinnum);
for iter = 1:1:length(Y_tstruct),
    if( Y_tstruct(iter).tcount ~= 0 ),
        [Ybin_tstruct,Ybin_cnts] = hist_extra(deltaY(Y_tstruct(iter).tsteps),deltabinnum);
        for subiter = 1:1:length(Ybin_tstruct),
            if( Ybin_tstruct(subiter).tcount ~= 0 ),
            	[dYbin_tstruct,dYbin_cnts] = hist_extra(X(Ybin_tstruct(subiter).tsteps),respbinnum);
            	for subsubiter = 1:1:length(dYbin_tstruct),
                	if( dYbin_tstruct(subsubiter).tcount ~= 0 ),
            	    	YXvar_vec(iter,subiter,subsubiter) = var(X(dYbin_tstruct(subsubiter).tsteps+2));
                        YXrunningsum = YXrunningsum + var(X(dYbin_tstruct(subsubiter).tsteps+2));
                        YXcount = YXcount + 1;
                        %X(dYbin_tstruct(subsubiter).tsteps+2)
            		else
            			YXvar_vec(iter,subiter,subsubiter) = nan;
            		end;
        		end;
            else
            	for subsubiter = 1:1:respbinnum,
                	YXvar_vec(iter,subiter,subsubiter) = nan;
           	    end;
            end;
        end;
    else
    	for subiter = 1:1:deltabinnum,
        	for subsubiter = 1:1:respbinnum,
               	YXvar_vec(iter,subiter,subsubiter) = nan;
            end;
        end;
    end;
end;

fprintf('XYvar = %.20f\n',XYrunningsum/XYcount);
fprintf('YXvar = %.20f\n',YXrunningsum/YXcount);
XYvar = XYvar_vec;
YXvar = YXvar_vec;

