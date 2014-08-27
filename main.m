addpath('./TSC1');

t = [0:0.01:500];
x = sin(t);

A = 1.0;
B = [0.1,0.5,0.9];

for Bstep = 1:1:length(B),
    
    fprintf('-- B = %.3f --------------------------------\n',B(Bstep));
    
    y = zeros(length(x),1);
    for iter = 2:1:length(x),
        y(iter) = A*x(iter-1) + B(Bstep)*rand();
    end

    xd = zeros(length(x)-1,1);
    for iter = 1:1:(length(x)-1),
        xd(iter,1) = x(iter+1)-x(iter);
    end;

    yd = zeros(length(y)-1,1);
    for iter = 1:1:(length(y)-1),
        yd(iter,1) = y(iter+1)-y(iter);
    end;

    binnum = 50;
    smallhistbinnum = 100;

    [xd_tstruct,xd_cnts] = hist_extra(xd,binnum);
    [yd_tstruct,yd_cnts] = hist_extra(yd,binnum);

    %{
    tempX = autocorr(x,500);
    tempY = autocorr(y,500);
    tempCros = crosscorr(x,y,500);

    plot(tempX(:,1),tempX(:,2),'x');
    plot(tempY(:,1),tempY(:,2),'o');
    plot(tempCros(:,1),tempCros(:,2),'.');
    %}

    yExpFreq = hist(y,smallhistbinnum);
    xExpFreq = hist(x,smallhistbinnum);

    yChiStat = 0;
    xChiStat = 0;

    yChiStat_Uni = 0;
    xChiStat_Uni = 0;

    for iter = 1:1:length(xd_tstruct),
        if( xd_tstruct(iter).tcount ~= 0 ),
            yUniFreq = xd_tstruct(iter).tcount/smallhistbinnum;
            yObsFreq = hist(y(xd_tstruct(iter).tsteps),smallhistbinnum);
            for step = 1:1:smallhistbinnum,
                yChiStat = yChiStat + ((yObsFreq(step)-yExpFreq(step))^2)/yExpFreq(step);
                yChiStat_Uni = yChiStat_Uni + ((yObsFreq(step)-yUniFreq)^2)/yUniFreq;
            end;
        end;
    end;

    for iter = 1:1:length(yd_tstruct),
        if( yd_tstruct(iter).tcount ~= 0 ),
           xUniFreq = yd_tstruct(iter).tcount/smallhistbinnum;
           xObsFreq = hist(x(yd_tstruct(iter).tsteps),smallhistbinnum);
           for step = 1:1:smallhistbinnum,
                xChiStat = xChiStat + ((xObsFreq(step)-xExpFreq(step))^2)/xExpFreq(step);
                xChiStat_Uni = xChiStat_Uni + ((xObsFreq(step)-xUniFreq)^2)/xUniFreq;
           end;
        end;
    end;

    fprintf('xChiStat = %.15f\n',xChiStat);
    fprintf('yChiStat = %.15f\n',yChiStat);
    if( xChiStat < yChiStat ),
        fprintf('The y-binned x values are closer to the unbinned histrogram of x than\n the x-binned y values are to the unbinned histrogram of y.\n');
        fprintf('==> Propose X DRIVES Y\n\n');
    end;
    if( yChiStat < xChiStat ),
        fprintf('The x-binned y values are closer to the unbinned histrogram of y than\n the y-binned x values are to the unbinned histrogram of x.\n');
        fprintf('==> Propose Y DRIVES X\n\n');
    end;

    fprintf('xChiStat_Uni = %.15f\n',xChiStat_Uni);
    fprintf('yChiStat_Uni = %.15f\n',yChiStat_Uni);
    if( xChiStat_Uni < yChiStat_Uni ),
        fprintf('The y-binned x values are closer to a uniform binning of x than\n the x-binned y values are to a uniform binning of y.\n');
        fprintf('==> Propose X DRIVES Y\n\n');
    end;
    if( yChiStat_Uni < xChiStat_Uni ),
        fprintf('The x-binned y values are closer to a uniform binning of y than\n the y-binned x values are to a uniform binning of x.\n');
        fprintf('==> Propose Y DRIVES X\n\n');
    end;
end;