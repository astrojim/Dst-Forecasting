function [] = LeaningReport(X,Y,TolOption,MaxLag)

if(length(X) < 20),
    error('LeaningReport error: X must have at least 20 data points.\n');
end;

if(length(Y) < 20),
    error('LeaningReport error: Y must have at least 20 data points.\n');
end;

if( strcmp(TolOption,'std') ),
    xtol = std(X);
    ytol = std(Y);
elseif( strcmp(TolOption,'norm std') ),
    xtol = std(X-mean(X));
    ytol = std(Y-mean(Y));
elseif( strcmp(TolOption,'linear lag 1') ),
    absnoiseiny = zeros(length(y),1);
    absnoiseinx = zeros(length(x),1);
    for iter = 1:1:(length(x)-1),
        absnoiseiny(iter) = abs(y(iter+1,1)-x(1,iter));
        absnoiseinx(iter) = abs(x(1,iter+1)-y(iter,1));
    end;
    xtol = mean(absnoiseinx);
    ytol = mean(absnoiseiny);
elseif( strcmp(TolOption,'10-bin mean std') ),    
    [Xtsteps_struct,counts] = hist_extra(X,10);
    [Ytsteps_struct,counts] = hist_extra(Y,10);
    Xbinstds = zeros(1,10);
    Ybinstds = zeros(1,10);
    for iter = 1:1:10,
        if( isnan(Xtsteps_struct(iter).tsteps) ),
            Xbinstds(iter) = nan;
        else
            Xbinstds(iter) = std(X(Xtsteps_struct(iter).tsteps));
        end;
        if( isnan(Ytsteps_struct(iter).tsteps) ),
            Ybinstds(iter) = nan;
        else
            Ybinstds(iter) = std(Y(Ytsteps_struct(iter).tsteps));
        end;
    end;
    xtol = nanmean(Xbinstds);
    ytol = nanmean(Ybinstds);
 elseif( strcmp(TolOption,'20-bin mean std') ),    
    [Xtsteps_struct,counts] = hist_extra(X,20);
    [Ytsteps_struct,counts] = hist_extra(Y,20);
    Xbinstds = zeros(1,20);
    Ybinstds = zeros(1,20);
    for iter = 1:1:20,
        if( isnan(Xtsteps_struct(iter).tsteps) ),
            Xbinstds(iter) = nan;
        else
            Xbinstds(iter) = std(X(Xtsteps_struct(iter).tsteps));
        end;
        if( isnan(Ytsteps_struct(iter).tsteps) ),
            Ybinstds(iter) = nan;
        else
            Ybinstds(iter) = std(Y(Ytsteps_struct(iter).tsteps));
        end;
    end;
    xtol = nanmean(Xbinstds);
    ytol = nanmean(Ybinstds);   
else
    xtol = 0;
    ytol = 0;
end;

% fprintf('Self Leanings:\n');
% fprintf('(X or Y) lag: leaning\n');
% for iter = 1:1:MaxLag,
%     leans_temp = leans_lagged(X,X,xtol,xtol,iter);
%     fprintf('(X) %i:%.15f\n',iter,leans_temp(1,2));
%     
%     leans_temp = leans_lagged(Y,Y,ytol,ytol,iter);
%     fprintf('(Y) %i:%.15f\n',iter,leans_temp(1,2));
% end;

fprintf('Leanings:\n');
fprintf('lag: leaning (X or Y) --> (X or Y)\n');
for iter = 1:1:MaxLag,
    leans_temp = leans_lagged(X,Y,xtol,ytol,iter);
    fprintf('%i:%.15f   ',iter,leans_temp(1,2));
    
    if( leans_temp(1,2) < 0 ),
        fprintf('Y --> X\n');
    elseif( leans_temp(1,2) > 0 ),
        fprintf('X --> Y\n');
    else
        fprintf('???\n');
    end;
    
end;