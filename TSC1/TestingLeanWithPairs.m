function checkresults = TestingLeanWithPairs(lags)

basedir = 'PairsForTesting/pairs/';
fprefix = 'pair';
ftype = '.txt';
numpairs = 88;
% lags = [0];

truth = nan;
checkresults = nan(numpairs,1);
for fiter = 1:1:numpairs,
    
    tic;
    
    %read in data
    ftemp = sprintf('%s%s%04d%s',basedir,fprefix,fiter,ftype);
    XY = dlmread(ftemp);
    
    %extract truth for description 
    ftemp1 = sprintf('%s%s%04d_des%s',basedir,fprefix,fiter,ftype);
    syscmd = sprintf('cat %s | grep -e --',ftemp1);
    [sysflag sysout] = system(syscmd);
    if( numel(sysout) ~= 0 ),
        if( strcmp(sysout(1),'x') ),
            truth = 1;
        elseif( strcmp(sysout(1),'y') ),
            truth = -1;
        else
            truth = 0;
        end;
    else
        truth = 0;
    end;
    
    %set tolerance
    xtol = mean(XY(:,1))*0.001;
    ytol = mean(XY(:,2))*0.001;
    
    %find, check, save, and report leaning
    checkresults(fiter) = leaningcheck(XY(:,1),XY(:,2),xtol,ytol,lags,truth);
    fprintf('%i - %i [%.5f]\n',fiter,checkresults(fiter),toc);
    
end;