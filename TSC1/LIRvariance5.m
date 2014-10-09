function [XYvar YXvar] = LIRvariance5(X_unnorm,Y_unnorm,deltabinnum,drivebinnum,respbinnum)
% descriptive comments

% normalize the TS data to make the variance comparison
%X = (X_unnorm-mean(X_unnorm))./std(X_unnorm);
%Y = (Y_unnorm-mean(Y_unnorm))./std(Y_unnorm);
X = X_unnorm;
Y = Y_unnorm;

% create and bin the delta TS data
deltaX = zeros(length(X)-1,1);
for iter = 2:1:length(X),
	deltaX(iter,1) = X(iter)-X(iter-1);
end;

deltaY = zeros(length(Y)-1,1);
for iter = 2:1:length(Y),
	deltaY(iter,1) = Y(iter)-Y(iter-1);
end;

% bin normalized data (pay attention to the time steps)
[X_tstruct,X_cnts] = hist_extra(X(2:end),drivebinnum);
[Y_tstruct,Y_cnts] = hist_extra(Y(2:end),respbinnum);

% mean calulcation parameters
XYrunningsum = 0;
XYcount = 0;
YXrunningsum = 0;
YXcount = 0;

%Calculate LIR XY variance
XYvar_vec = zeros(drivebinnum,deltabinnum,respbinnum);
for iter = 1:1:length(Y_tstruct),
    if( Y_tstruct(iter).tcount ~= 0 ),
        [Ybin_tstruct,Ybin_cnts] = hist_extra(deltaX(Y_tstruct(iter).tsteps),deltabinnum);
        for subiter = 1:1:length(Ybin_tstruct),
            if( Ybin_tstruct(subiter).tcount ~= 0 ),
            	[dYbin_tstruct,dYbin_cnts] = hist_extra(Y(Ybin_tstruct(subiter).tsteps(Ybin_tstruct(subiter).tsteps~=1)-1),drivebinnum);
            	for subsubiter = 1:1:length(dYbin_tstruct),
                	if( dYbin_tstruct(subsubiter).tcount ~= 0 ),
            	    	if( ~isempty(dYbin_tstruct(subsubiter).tsteps(dYbin_tstruct(subsubiter).tsteps~=1)-1) ),
                        	XYvar_vec(iter,subiter,subsubiter) = var(X(dYbin_tstruct(subsubiter).tsteps(dYbin_tstruct(subsubiter).tsteps~=1)-1));
                        	XYrunningsum = XYrunningsum + var(X(dYbin_tstruct(subsubiter).tsteps(dYbin_tstruct(subsubiter).tsteps~=1)-1));
                        	XYcount = XYcount + 1;
                        end;
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
for iter = 1:1:length(X_tstruct),
    if( X_tstruct(iter).tcount ~= 0 ),
        [Xbin_tstruct,Xbin_cnts] = hist_extra(deltaY(Y_tstruct(iter).tsteps),deltabinnum);
        for subiter = 1:1:length(Xbin_tstruct),
            if( Xbin_tstruct(subiter).tcount ~= 0 ),
            	[dXbin_tstruct,dXbin_cnts] = hist_extra(X(Xbin_tstruct(subiter).tsteps(Xbin_tstruct(subiter).tsteps~=1)-1),drivebinnum);
            	for subsubiter = 1:1:length(dXbin_tstruct),
                	if( dXbin_tstruct(subsubiter).tcount ~= 0 ),
            	    	if( ~isempty(dXbin_tstruct(subsubiter).tsteps(dXbin_tstruct(subsubiter).tsteps~=1)-1) ),
                        	YXvar_vec(iter,subiter,subsubiter) = var(Y(dXbin_tstruct(subsubiter).tsteps(dXbin_tstruct(subsubiter).tsteps~=1)-1));
                        	YXrunningsum = YXrunningsum + var(Y(dXbin_tstruct(subsubiter).tsteps(dXbin_tstruct(subsubiter).tsteps~=1)-1));
                        	YXcount = YXcount + 1;
                        end;
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