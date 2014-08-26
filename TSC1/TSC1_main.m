t = 0:0.05:200;
x = sin(t);
%x = rand(length(t));
y = zeros(1,length(x));

A = 1;
B = 0.01;

for iter = 2:1:length(x),
	y(iter) = A*x(iter-1) + B*rand();
end

binnum = 64; %should be perfect square
smallhistbinnum = 500;

xd = zeros(length(x)-1,1);
for iter = 1:1:(length(x)-1),
	xd(iter,1) = x(iter+1)-x(iter);
end;

yd = zeros(length(y)-1,1);
for iter = 1:1:(length(y)-1),
	yd(iter,1) = y(iter+1)-y(iter);
end;

tempX = autocorr(x,500);
tempY = autocorr(y,500);
tempCrosXY = crosscorr(x,y,500);
tempCrosYX = crosscorr(y,x,500);
[xd_tstruct,xd_cnts] = hist_extra(xd,binnum);
[yd_tstruct,yd_cnts] = hist_extra(yd,binnum);


figure(1);
plot(tempX(:,1),tempX(:,2),'o');
xlabel('lags');
ylabel('Autocorrelation (X)');

figure(2);
plot(tempY(:,1),tempY(:,2),'o');
xlabel('lags');
ylabel('Autocorrelation (Y)');

figure(3);
plot(tempCrosXY(:,1),tempCrosXY(:,2),'o');
xlabel('lags');
ylabel('Cross-correlation (XY)');

figure(4);
plot(tempCrosYX(:,1),tempCrosYX(:,2),'o');
xlabel('lags');
ylabel('Cross-correlation (YX)');

figure(5);
for iter = 1:1:length(xd_tstruct),
    if( xd_tstruct(iter).tcount ~= 0 ),
        fprintf('  Bin %i [%.5f,%.5f]\n',iter,xd_tstruct(iter).binLower,xd_tstruct(iter).binUpper);
        subplot(sqrt(length(xd_tstruct)),sqrt(length(xd_tstruct)),iter);
        hist(y(xd_tstruct(iter).tsteps),smallhistbinnum);
        xlim([-1 1]);
    end;
end;

figure(6);
hist(y,smallhistbinnum);

figure(7);
for iter = 1:1:length(yd_tstruct),
    if( yd_tstruct(iter).tcount ~= 0 ),
        fprintf('  Bin %i [%.5f,%.5f]\n',iter,yd_tstruct(iter).binLower,yd_tstruct(iter).binUpper);
        subplot(sqrt(length(yd_tstruct)),sqrt(length(yd_tstruct)),iter);
        hist(x(yd_tstruct(iter).tsteps),smallhistbinnum);
        xlim([-1 1]);
    end;
end;

figure(8);
hist(x,smallhistbinnum);