L = 100;%[10:1:500];
Edim = [1:1:10];
tau = 1;%[1:1:5];
lags = 1:1:50;

plotdata = zeros(length(L),length(Edim),length(tau),2);
autocorrdata = zeros(length(lags),2);

X = zeros(L,1);
Y = X;
X(1) = 0.4;
Y(1) = 0.2;
rx = 3.1;
ry = 3.9;
Bxy = 0.2;
Byx = 0.002;
            
for fstep = 1:(length(X)-1),
	X(fstep+1) = X(fstep)*(rx-rx*X(fstep)-Bxy*Y(fstep));
    Y(fstep+1) = Y(fstep)*(ry-ry*Y(fstep)-Byx*X(fstep));
end;

for lagstep = 1:length(lags),
	autocorrdata(lagstep,1) = corr(X((1+lags(lagstep)):end),X(1:(end-lags(lagstep))));
    autocorrdata(lagstep,2) = corr(Y((1+lags(lagstep)):end),Y(1:(end-lags(lagstep))));
end;

plot(lags,abs(autocorrdata(:,1)),'.',lags,abs(autocorrdata(:,2)),'o');
title('Autocorrelation Lags for L = 100');
xlabel('l');
ylabel('autocorrelation');
grid on;
legend('|A_l^X|','|A_l^Y|');

max(abs(autocorrdata(:,1)))
find(abs(autocorrdata(:,1))==max(abs(autocorrdata(:,1))))
min(abs(autocorrdata(:,1)))
find(abs(autocorrdata(:,1))==min(abs(autocorrdata(:,1))))
max(abs(autocorrdata(:,2)))
find(abs(autocorrdata(:,2))==max(abs(autocorrdata(:,2))))
min(abs(autocorrdata(:,2)))
find(abs(autocorrdata(:,2))==min(abs(autocorrdata(:,2))))

