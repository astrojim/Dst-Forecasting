addpath('./TSC1');

fprintf('X and Y have no link\n');
t = [0:0.01:500];
x = sin(t);

xd = zeros(length(x)-1,1);
y = zeros(length(x)+1,1);
for iter = 1:1:(length(x)-1),
	xd(iter,1) = x(iter+1)-x(iter);
end;

for iter = 2:1:length(x)+1,
    y(iter) = rand();
end;

[tstruct,cnts] = hist_extra(xd,16);

figure('Name','Y is random');
for iter = 1:1:length(tstruct),
    if( tstruct(iter).tcount ~= 0 ),
        fprintf('  Bin %i [%.5f,%.5f]\n',iter,tstruct(iter).binLower,tstruct(iter).binUpper);
        subplot(sqrt(length(tstruct)),sqrt(length(tstruct)),iter);
        hist(y(tstruct(iter).tsteps+2),100);
        xlim([-1 1]);
    end;
end;

fprintf('X drives Y\n');
t = [0:0.01:500];
x = sin(t);

xd = zeros(length(x)-1,1);
y = zeros(length(x)+1,1);
for iter = 1:1:(length(x)-1),
	xd(iter,1) = x(iter+1)-x(iter);
end;

for iter = 2:1:length(x)+1,
    y(iter) = x(iter-1) + 0.1*rand();
end;

[tstruct,cnts] = hist_extra(xd,16);

figure('Name','X drives Y');
for iter = 1:1:length(tstruct),
    if( tstruct(iter).tcount ~= 0 ),
        fprintf('  Bin %i [%.5f,%.5f]\n',iter,tstruct(iter).binLower,tstruct(iter).binUpper);
        subplot(sqrt(length(tstruct)),sqrt(length(tstruct)),iter);
        hist(y(tstruct(iter).tsteps+2),100);
        xlim([-1 1]);
    end;
end;
