basedir = 'PairsForTesting/pairs/';
fprefix = 'pair';
ftype = '.txt';

lags = [0:1:20];
pc = 0.1;

% stock data
ftemp = sprintf('%s%s%04d%s',basedir,fprefix,65,ftype);
XY1 = dlmread(ftemp);

ftemp = sprintf('%s%s%04d%s',basedir,fprefix,66,ftype);
XY2 = dlmread(ftemp);

ftemp = sprintf('%s%s%04d%s',basedir,fprefix,67,ftype);
XY3 = dlmread(ftemp);

% sunspot data
ftemp = sprintf('%s%s%04d%s',basedir,fprefix,72,ftype);
SuS = dlmread(ftemp);

% temp data
ftemp = sprintf('%s%s%04d%s',basedir,fprefix,48,ftype);
IOT = dlmread(ftemp);

% snowfall data
ftemp = sprintf('%s%s%04d%s',basedir,fprefix,87,ftype);
SF = dlmread(ftemp);

StockleansXY1 = nan(1,length(lags));
StockleansXY2 = nan(1,length(lags));
StockleansXY3 = nan(1,length(lags));
Sunleans = nan(1,length(lags));
Templeans = nan(1,length(lags));
Snowleans = nan(1,length(lags));
StockleansXY11 = nan(1,length(lags));
StockleansXY21 = nan(1,length(lags));
StockleansXY31 = nan(1,length(lags));
Sunleans1 = nan(1,length(lags));
Templeans1 = nan(1,length(lags));
Snowleans1 = nan(1,length(lags));

nb = floor(pc*length(XY1(:,1)));
cleanX = (XY1(:,1)-mean(XY1(:,1)))./std(XY1(:,1));
cleanY = (XY1(:,2)-mean(XY1(:,2)))./std(XY1(:,2));
[Xtsteps_struct,counts] = hist_extra(cleanX,nb);
[Ytsteps_struct,counts] = hist_extra(cleanY,nb);
Xbinstds = zeros(1,nb);
Ybinstds = zeros(1,nb);
for iter = 1:1:nb,
    if( isnan(Xtsteps_struct(iter).tsteps) ),
        Xbinstds(iter) = nan;
    else
        Xbinstds(iter) = std(cleanX(Xtsteps_struct(iter).tsteps,1));
    end;
    if( isnan(Ytsteps_struct(iter).tsteps) ),
        Ybinstds(iter) = nan;
    else
        Ybinstds(iter) = std(cleanY(Ytsteps_struct(iter).tsteps,1));
    end;
end;
xtolXY1 = max(Xbinstds);
ytolXY1 = max(Ybinstds);

clear Xbinstds Ybinstds

nb = floor(pc*length(XY2(:,1)));
cleanX = (XY2(:,1)-mean(XY2(:,1)))./std(XY2(:,1));
cleanY = (XY2(:,2)-mean(XY2(:,2)))./std(XY2(:,2));
[Xtsteps_struct,counts] = hist_extra(cleanX,nb);
[Ytsteps_struct,counts] = hist_extra(cleanY,nb);
Xbinstds = zeros(1,nb);
Ybinstds = zeros(1,nb);
for iter = 1:1:nb,
    if( isnan(Xtsteps_struct(iter).tsteps) ),
        Xbinstds(iter) = nan;
    else
        Xbinstds(iter) = std(cleanX(Xtsteps_struct(iter).tsteps,1));
    end;
    if( isnan(Ytsteps_struct(iter).tsteps) ),
        Ybinstds(iter) = nan;
    else
        Ybinstds(iter) = std(cleanY(Ytsteps_struct(iter).tsteps,1));
    end;
end;
xtolXY2 = max(Xbinstds);
ytolXY2 = max(Ybinstds);

clear Xbinstds Ybinstds

nb = floor(pc*length(XY3(:,1)));
cleanX = (XY3(:,1)-mean(XY3(:,1)))./std(XY3(:,1));
cleanY = (XY3(:,2)-mean(XY3(:,2)))./std(XY3(:,2));
[Xtsteps_struct,counts] = hist_extra(cleanX,nb);
[Ytsteps_struct,counts] = hist_extra(cleanY,nb);
Xbinstds = zeros(1,nb);
Ybinstds = zeros(1,nb);
for iter = 1:1:nb,
    if( isnan(Xtsteps_struct(iter).tsteps) ),
        Xbinstds(iter) = nan;
    else
        Xbinstds(iter) = std(cleanX(Xtsteps_struct(iter).tsteps,1));
    end;
    if( isnan(Ytsteps_struct(iter).tsteps) ),
        Ybinstds(iter) = nan;
    else
        Ybinstds(iter) = std(cleanY(Ytsteps_struct(iter).tsteps,1));
    end;
end;
xtolXY3 = max(Xbinstds);
ytolXY3 = max(Ybinstds);

clear Xbinstds Ybinstds

nb = floor(pc*length(SuS(:,1)));
cleanX = (SuS(:,1)-mean(SuS(:,1)))./std(SuS(:,1));
cleanY = (SuS(:,2)-mean(SuS(:,2)))./std(SuS(:,2));
[Xtsteps_struct,counts] = hist_extra(cleanX,nb);
[Ytsteps_struct,counts] = hist_extra(cleanY,nb);
Xbinstds = zeros(1,nb);
Ybinstds = zeros(1,nb);
for iter = 1:1:nb,
    if( isnan(Xtsteps_struct(iter).tsteps) ),
        Xbinstds(iter) = nan;
    else
        Xbinstds(iter) = std(cleanX(Xtsteps_struct(iter).tsteps,1));
    end;
    if( isnan(Ytsteps_struct(iter).tsteps) ),
        Ybinstds(iter) = nan;
    else
        Ybinstds(iter) = std(cleanY(Ytsteps_struct(iter).tsteps,1));
    end;
end;
xtolSuS = max(Xbinstds);
ytolSuS = max(Ybinstds);

clear Xbinstds Ybinstds

nb = floor(pc*length(IOT(:,1)));
cleanX = (IOT(:,1)-mean(IOT(:,1)))./std(IOT(:,1));
cleanY = (IOT(:,2)-mean(IOT(:,2)))./std(IOT(:,2));
[Xtsteps_struct,counts] = hist_extra(cleanX,nb);
[Ytsteps_struct,counts] = hist_extra(cleanY,nb);
Xbinstds = zeros(1,nb);
Ybinstds = zeros(1,nb);
for iter = 1:1:nb,
    if( isnan(Xtsteps_struct(iter).tsteps) ),
        Xbinstds(iter) = nan;
    else
        Xbinstds(iter) = std(cleanX(Xtsteps_struct(iter).tsteps,1));
    end;
    if( isnan(Ytsteps_struct(iter).tsteps) ),
        Ybinstds(iter) = nan;
    else
        Ybinstds(iter) = std(cleanY(Ytsteps_struct(iter).tsteps,1));
    end;
end;
xtolIOT = max(Xbinstds);
ytolIOT = max(Ybinstds);
% xtolIOT = std(IOT(:,1)-mean(IOT(:,1)));
% ytolIOT = std(IOT(:,2)-mean(IOT(:,2)));

clear Xbinstds Ybinstds

nb = floor(pc*length(SF(:,1)));
cleanX = (SF(:,1)-mean(SF(:,1)))./std(SF(:,1));
cleanY = (SF(:,2)-mean(SF(:,2)))./std(SF(:,2));
[Xtsteps_struct,counts] = hist_extra(cleanX,nb);
[Ytsteps_struct,counts] = hist_extra(cleanY,nb);
Xbinstds = zeros(1,nb);
Ybinstds = zeros(1,nb);
for iter = 1:1:nb,
    if( isnan(Xtsteps_struct(iter).tsteps) ),
        Xbinstds(iter) = nan;
    else
        Xbinstds(iter) = std(cleanX(Xtsteps_struct(iter).tsteps,1));
    end;
    if( isnan(Ytsteps_struct(iter).tsteps) ),
        Ybinstds(iter) = nan;
    else
        Ybinstds(iter) = std(cleanY(Ytsteps_struct(iter).tsteps,1));
    end;
end;
xtolSF = max(Xbinstds);
ytolSF = max(Ybinstds);

clear Xbinstds Ybinstds

for liter = 1:1:length(lags),

    fprintf(' lag %i/%i\n',liter,length(lags));
    temp = leans_lagged(XY1(:,1),XY1(:,2),xtolXY1,ytolXY1,lags(liter));
    StockleansXY1(1,liter) = temp(1,2);

    temp = leans_lagged(XY1(:,1),XY1(:,2),...
        std((XY1(:,1)-mean(XY1(:,1)))),...
        std((XY1(:,2)-mean(XY1(:,2)))),lags(liter));
    StockleansXY11(1,liter) = temp(1,2);
    
    temp = leans_lagged(XY2(:,1),XY2(:,2),xtolXY2,ytolXY2,lags(liter));
    StockleansXY2(1,liter) = temp(1,2);

    temp = leans_lagged(XY2(:,1),XY2(:,2),...
        std((XY2(:,1)-mean(XY2(:,1)))),...
        std((XY2(:,2)-mean(XY2(:,2)))),lags(liter));
    StockleansXY21(1,liter) = temp(1,2);

    temp = leans_lagged(XY3(:,1),XY3(:,2),xtolXY3,ytolXY3,lags(liter));
    StockleansXY3(1,liter) = temp(1,2);

    temp = leans_lagged(XY3(:,1),XY3(:,2),...
        std((XY3(:,1)-mean(XY3(:,1)))),...
        std((XY3(:,2)-mean(XY3(:,2)))),lags(liter));
    StockleansXY31(1,liter) = temp(1,2);

    temp = leans_lagged(SuS(:,1),SuS(:,2),xtolSuS,ytolSuS,lags(liter));
    Sunleans(1,liter) = temp(1,2);
    
    temp = leans_lagged(SuS(:,1),SuS(:,2),...
        std((SuS(:,1)-mean(SuS(:,1)))),...
        std((SuS(:,2)-mean(SuS(:,2)))),lags(liter));
    Sunleans1(1,liter) = temp(1,2);
    
    temp = leans_lagged(IOT(:,1),IOT(:,2),xtolIOT,ytolIOT,lags(liter));
    Templeans(1,liter) = temp(1,2);
    
    temp = leans_lagged(IOT(:,1),IOT(:,2),...
        std((IOT(:,1)-mean(IOT(:,1)))),...
        std((IOT(:,2)-mean(IOT(:,2)))),lags(liter));
    Templeans1(1,liter) = temp(1,2);
    
    temp = leans_lagged(SF(:,1),SF(:,2),xtolSF,ytolSF,lags(liter));
    Snowleans(1,liter) = temp(1,2);
    
    temp = leans_lagged(SF(:,1),SF(:,2),...
        std((SF(:,1)-mean(SF(:,1)))),...
        std((SF(:,2)-mean(SF(:,2)))),lags(liter));
    Snowleans1(1,liter) = temp(1,2);
        
end;

