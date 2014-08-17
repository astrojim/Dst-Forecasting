addpath('./TSC1');

binnum = 64;

t = [0:0.01:500];
x = sin(t);

xd = zeros(length(x)-1,1);
for iter = 1:1:(length(x)-1),
	xd(iter,1) = x(iter+1)-x(iter);
end;

fprintf('dX : X and Y have no link\n');

y = zeros(length(x)+1,1);
for iter = 2:1:length(x)+1,
    y(iter) = rand();
end;

[tstruct,cnts] = hist_extra(xd,binnum);

figure('Name','dX : Y is random');
for iter = 1:1:length(tstruct),
    if( tstruct(iter).tcount ~= 0 ),
        fprintf('  Bin %i [%.5f,%.5f]\n',iter,tstruct(iter).binLower,tstruct(iter).binUpper);
        subplot(sqrt(length(tstruct)),sqrt(length(tstruct)),iter);
        hist(y(tstruct(iter).tsteps+2),100);
        xlim([-1 1]);
    end;
end;

fprintf('dX : X drives Y\n');

y = zeros(length(x)+1,1);
for iter = 2:1:length(x)+1,
    y(iter) = x(iter-1) + 0.1*rand();
end;

[tstruct,cnts] = hist_extra(xd,binnum);

figure('Name','dX : X drives Y');
for iter = 1:1:length(tstruct),
    if( tstruct(iter).tcount ~= 0 ),
        fprintf('  Bin %i [%.5f,%.5f]\n',iter,tstruct(iter).binLower,tstruct(iter).binUpper);
        subplot(sqrt(length(tstruct)),sqrt(length(tstruct)),iter);
        hist(y(tstruct(iter).tsteps+2),100);
        xlim([-1 1]);
    end;
end;

fprintf('dY : X and Y have no link\n');

y = zeros(length(x)+1,1);
for iter = 2:1:length(x)+1,
    y(iter) = rand();
end;
yd = zeros(length(y)-1,1);
for iter = 1:1:(length(y)-1),
	yd(iter,1) = y(iter+1)-y(iter);
end;

[tstruct,cnts] = hist_extra(yd,binnum);

figure('Name','dY : Y is random');
for iter = 1:1:length(tstruct),
    if( tstruct(iter).tcount ~= 0 ),
        fprintf('  Bin %i [%.5f,%.5f]\n',iter,tstruct(iter).binLower,tstruct(iter).binUpper);
        subplot(sqrt(length(tstruct)),sqrt(length(tstruct)),iter);
        hist(x(tstruct(iter).tsteps),100);
        xlim([-1 1]);
    end;
end;

fprintf('dY : X drives Y\n');

y = zeros(length(x)+1,1);
for iter = 2:1:length(x)+1,
    y(iter) = x(iter-1) + 0.1*rand();
end;
yd = zeros(length(y)-1,1);
for iter = 1:1:(length(y)-1),
	yd(iter,1) = y(iter+1)-y(iter);
end;

[tstruct,cnts] = hist_extra(yd,binnum);

figure('Name','dY : X drives Y');
for iter = 1:1:length(tstruct),
    if( tstruct(iter).tcount ~= 0 ),
        fprintf('  Bin %i [%.5f,%.5f]\n',iter,tstruct(iter).binLower,tstruct(iter).binUpper);
        subplot(sqrt(length(tstruct)),sqrt(length(tstruct)),iter);
        hist(x(tstruct(iter).tsteps),100);
        xlim([-1 1]);
    end;
end;
