
years = 1988:1:2014;
datadir = 'moontidedata';
basefilename = 'CO-OPS__8774770__hr';

step = 1;
for yiter = 1:1:length(years),
    importTideCSVfile(sprintf('%s/%s_%i.csv',datadir,basefilename,years(yiter)));
    
    for diter = 1:1:length(data),
        tidedata(step,1) = datenum(textdata{diter+1,1});
        tidedata(step,2) = data(diter,1);
        step = step + 1;
    end;
    
    clear('data','textdata');
end;