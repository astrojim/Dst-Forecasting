
% set start and stop times for daily average subsets 
% !!! (not used in the sampling but still needs to be set) !!!
SubSetstart = 298057; %01-Jan-1997 00:30:00
SubSetstop = 341880; %31-Dec-2001 23:30:00

% load Bz and Dst and time steps
[bz,bzr,dst,tau] = SolarDataSets(SubSetstart,SubSetstop);

% sampling parameters
sublength = 1500;
% numsubs = floor(length(dst.hourly)/sublength);
maxStartIndex = length(dst.hourly)-sublength;

% number of samples
% numsamps = 1e4;

% preallocate storage
TEsamp = nan(numsamps,1);
GCsamp = nan(numsamps,1);
PAIsamp = nan(numsamps,1);
Lsamp = nan(numsamps,1);
LCCsamp = nan(numsamps,1);
TErsamp = nan(numsamps,1);
GCrsamp = nan(numsamps,1);
PAIrsamp = nan(numsamps,1);
Lrsamp = nan(numsamps,1);
LCCrsamp = nan(numsamps,1);

% run
for iter = 1:1:numsamps,
    
    tic;
    fprintf('\n\n ===>Sampling TS %i/%i [%.4f] ... ',iter,numsamps,iter/numsamps);
    
    % sampled subset of the time series
    rndStartIndex = floor(rand(1)*maxStartIndex)+1;
    tIndex = rndStartIndex:1:(rndStartIndex+sublength-1);
    d_samp = dst.hourly(tIndex);
    bz_samp = bz.hourly(tIndex);
    bzr_samp = bzr.hourly(tIndex);
    
    % check missing data
    skipsample = false;
    Dnans = isnan(d_samp);
    Bnans = isnan(bz_samp);
    if( sum(Dnans) ~= 0 ),
        skipsample = true;
    else
        if( sum(Bnans) ~= 0 ),
            skipsample = true;
        end;
    end;
    
    % store everything
    if( ~skipsample ),
    
        % set 1/4-width tolerances
        Dtol = (max(d_samp)-min(d_samp))/4;
        Bztol = (max(bz_samp)-min(bz_samp))/4;
        Bzrtol = (max(bzr_samp)-min(bzr_samp))/4;

        % find autocorr length to set lags
        alags = 1:1:floor(length(d_samp)/4);
        autocorrD = nan(length(alags),1);
        for liter = 1:1:length(alags),
            temp = abs(corr(d_samp((alags(liter)+1):end)',d_samp(1:(end-alags(liter)))'))^2;
            if( isnan(temp) ),
                autocorrD(liter,1) = 0;
            else
                autocorrD(liter,1) = temp;
            end;
        end;
        Llags = 1:1:(find(autocorrD == min(autocorrD)));
    
        y = d_samp';
        x = bz_samp';
        [TE_dbz,GC_dbz,PAI_dbz,L_dbz,LCC_dbz,g_dbz] = ECA(x,y,Bztol,Dtol,Llags,50,1,true,false);

        TEsamp(iter,1) = TE_dbz.D_TE;
        GCsamp(iter,1) = GC_dbz.diff;
        PAIsamp(iter,1) = PAI_dbz.diff;
        Lsamp(iter,1) = L_dbz.testlean;
        LCCsamp(iter,1) = LCC_dbz.testcorr;

        xr = bzr_samp';
        [TE_dbzr,GC_dbzr,PAI_dbzr,L_dbzr,LCC_dbzr,g_dbzr] = ECA(xr,y,Bzrtol,Dtol,Llags,50,1,true,false);

        TErsamp(iter,1) = TE_dbzr.D_TE;
        GCrsamp(iter,1) = GC_dbzr.diff;
        PAIrsamp(iter,1) = PAI_dbzr.diff;
        Lrsamp(iter,1) = L_dbzr.testlean;
        LCCrsamp(iter,1) = LCC_dbzr.testcorr;
    end;
    
    fprintf('done. [%.4f] \n',toc);
end;


