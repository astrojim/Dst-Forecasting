
lag = 1;
ytol = [1e-8,1e-6,1e-5,1e-4,1e-3,1e-2,0.1:0.1:1];
liblength = [10,150,500,1500,3000,5000];

leansXY = nan(length(liblength),length(ytol));

hitspace = 5;
hititer = 0;
    
for Liter = 1:1:length(liblength),
    
    L = liblength(Liter);
    x = zeros(1,L);
    x(1) = 2;
    for xiter = 2:1:L,
        if( hititer > hitspace ),
            x(xiter) = 2;
            hititer = 0;
        end;
        hititer = hititer + 1;
    end;

    y = randn(1,length(x));

    for Toliter = 1:1:length(ytol),

        fprintf('L = %i [%i/%i] : tol %i of %i ...',L,Liter,length(liblength),Toliter,length(ytol));
        tic;
        temp = leans_lagged(x,y,0,ytol(Toliter),1);
        leansXY(Liter,Toliter) = temp(1,2);
        fprintf(' done. [%.4f s]\n',toc);

    end;
end;

% from http://www.tylervigen.com/view_correlation?id=97
% arcade revenue
xX = [1196,1176,1269,1240,1307,1435,1601,1654,1803,1734];
% CS PhDs
yY = [861,830,809,867,948,1129,1453,1656,1787,1611];

DrCScorr = corr(xX,yY);
DrCSlean = leans_lagged(xX,yY,0.05*std(abs(xX-mean(xX))),0.05*std(abs(yY-mean(yY))),1);