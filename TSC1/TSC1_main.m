t = [0:0.01:500];
%pulses = [100:100:500];
x = sin(t);
%x = square(t);
%x = sawtooth(t);
%x = pulstran(t,pulses,'tripuls');
%x = pulstran(t,pulses,'gauspuls');

xd = zeros(length(x)-1,1);
y = zeros(length(x)+1,1);
for iter = 1:1:(length(x)-1),
	xd(iter,1) = x(iter+1)-x(iter);
end;

for iter = 2:1:length(x)+1,
	y(iter) = x(iter-1) + 0.1*rand();
    %y(iter) = x(iter-1) + 0.9*rand();
    %y(iter) = rand();
end;

%plot(x)
%plot(y)
[tstruct,cnts] = hist_extra(xd,16);
%bar(cnts)
%hist(xd,10)
figure('Name','Foo');
for iter = 1:1:length(tstruct),
	
    %for tstep = 1:1:tstruct(iter).tcount
    %	printf('%i,',tstruct(iter).tsteps(tstep));
    %end;
    %printf('\n');
    
    if( tstruct(iter).tcount ~= 0 ),
        fprintf('Bin %i\n',iter);
        subplot(sqrt(length(tstruct)),sqrt(length(tstruct)),iter);
        hist(y(tstruct(iter).tsteps+2),100);
        xlim([-1 1]);
    end;
end;
