% comparing tolerance methods
warning('off','all');

fprintf('Linear example: L = 20, 50, 100, and 500\n');
fprintf('Method 1: ytol = B\n');
fprintf('Method 2: ytol = mean(|y_{t}-x_{t-1}|)\n');
fprintf('Method 3: ytol = std(y-mean(y))\n');

B = [0:0.1:1.0];
Lvec = [20,50,100,500];

leans_stored1a = nan(length(B),length(Lvec));
leans_stored2a = nan(length(B),length(Lvec));
leans_stored3a = nan(length(B),length(Lvec));

for Liter = 1:1:length(Lvec),
    
    liblength = Lvec(Liter);
    hitspace = 3;
    hititer = 0;
    x = zeros(1,liblength);
    x(2) = 2;
    for xiter = 2:1:liblength,
        if( hititer > hitspace ),
            x(xiter) = 2;
            hititer = 0;
        end;
        hititer = hititer + 1;
    end;

    for step = 1:1:length(B),

        y = zeros(length(x),1);
        for iter = 2:1:length(y),
            y(iter) = x(iter-1) + B(step)*randn();
        end;

        leans_temp = leans_lagged(x,y,0,B(step),1);
        leans_stored1a(step,Liter) = leans_temp(1,2);

        noiseiny = zeros(length(x),1);
        noiseinx = zeros(length(x),1);
        absnoiseiny = zeros(length(x),1);
        absnoiseinx = zeros(length(x),1);
        for iter = 1:1:(length(x)-1),
            noiseiny(iter) = y(iter+1,1)-x(1,iter);
            noiseinx(iter) = x(1,iter+1)-y(iter,1);
            absnoiseiny(iter) = abs(y(iter+1,1)-x(1,iter));
            absnoiseinx(iter) = abs(x(1,iter+1)-y(iter,1));
        end;
        ZMniny = var(noiseiny-mean(noiseiny));
        ZMninx = var(noiseinx-mean(noiseinx));
        absZMniny = var(absnoiseiny-mean(absnoiseiny));
        absZMninx = var(absnoiseinx-mean(absnoiseinx));
        snr_xy = var(x-mean(x))/ZMniny;
        snr_yx = var(y-mean(y))/ZMninx;
        abssnr_xy = var(x-mean(x))/absZMniny;
        abssnr_yx = var(y-mean(y))/absZMninx;

        leans_temp = leans_lagged(x,y,0,mean(absnoiseiny),1);
        leans_stored2a(step,Liter) = leans_temp(1,2);

        leans_temp = leans_lagged(x,y,0,std(y-mean(y)),1);
        leans_stored3a(step,Liter) = leans_temp(1,2);

    end;
end;

leans_stored1a
leans_stored2a
leans_stored3a

fprintf('Cyclic example: L = 50 (1p), 60 (3p), 100 (1p), and 300 (3p)\n');
fprintf('Method 1: ytol = B\n');
fprintf('Method 2: ytol = mean(|y_{t}-x_{t-1}|)\n');
fprintf('Method 3: ytol = std(y-mean(y))\n');

clear('x');
x = cell(1,4);

B = [0:0.1:1.0];

leans_stored1b = nan(length(B),4);
leans_stored2b = nan(length(B),4);
leans_stored3b = nan(length(B),4);

tstep = 0:(pi/50):(2*pi);
x{1} = sin(tstep);

tstep = 0:(pi/10):(6*pi);
x{2} = sin(tstep);

tstep = 0:(pi/100):(2*pi);
x{3} = sin(tstep);

tstep = 0:(pi/50):(6*pi);
x{4} = sin(tstep);

for xiter = 1:1:length(x),
    for step = 1:1:length(B),

        y = zeros(length(x{xiter}),1);
        for iter = 2:1:length(y),
            y(iter) = x{xiter}(iter-1) + B(step)*randn();
        end;

        leans_temp = leans_lagged(x{xiter},y,0,B(step),1);
        leans_stored1b(step,xiter) = leans_temp(1,2);

        absnoiseiny = zeros(length(x{xiter}),1);
        absnoiseinx = zeros(length(x{xiter}),1);
        for iter = 1:1:(length(x)-1),
            absnoiseiny(iter) = abs(y(iter+1,1)-x{xiter}(1,iter));
            absnoiseinx(iter) = abs(x{xiter}(1,iter+1)-y(iter,1));
        end;

        leans_temp = leans_lagged(x{xiter},y,0,mean(absnoiseiny),1);
        leans_stored2b(step,xiter) = leans_temp(1,2);

        leans_temp = leans_lagged(x{xiter},y,0,std(y-mean(y)),1);
        leans_stored3a(step,xiter) = leans_temp(1,2);

    end;
end;

leans_stored1b
leans_stored2b
leans_stored3b

fprintf('LR circuit example (analytical solution): \n');
fprintf('Method 1: ytol = 0\n');
fprintf('Method 2: ytol = mean(|I_{t}-V_{t-1}|)\n');
fprintf('Method 3: ytol = std(I-mean(I))\n');

Tt = 2*pi:2*pi:10*pi; %2*pi; 
Ttstep = [pi/5,pi/10,pi/20];%[pi,pi/2,pi/4,pi/10,pi/50,pi/100,pi/1000,pi/10000];

leans_stored1c = nan(length(Tt),length(Ttstep));
leans_stored2c = nan(length(Tt),length(Ttstep));
leans_stored3c = nan(length(Tt),length(Ttstep));

for tstep = 1:1:length(Tt),
	for tsstep = 1:1:length(Ttstep),

		tspan  = 0 : Ttstep(tsstep) : Tt(tstep);
		Vv = sin(tspan);
		RR = 5.*ones(length(tspan),1);
		L = 10;

		Denom = L^2+RR(1)^2;
		Eterm = (L/Denom).*exp((-RR(1)/L).*tspan);
		Sterm = (RR(1)/Denom).*sin(tspan);
		Cterm = (L/Denom).*cos(tspan);
		Ian = Eterm+Sterm-Cterm;

		absnoiseinV = zeros(length(Vv),1);
		absnoiseinI = zeros(length(Ian),1);
		for iter = 1:1:(length(Vv)-1),
        	absnoiseinI(iter) = abs(Ian(iter+1)-Vv(iter));
    		absnoiseinV(iter) = abs(Vv(iter+1)-Ian(iter));
    	end;

		leans_temp = leans_lagged(Vv,Ian,0,0,1);
		leans_stored1c(tstep,tsstep) = leans_temp(1,2);
        
		leans_temp = leans_lagged(Vv,Ian,0,mean(absnoiseinI),1);
		leans_stored2c(tstep,tsstep) = leans_temp(1,2);
        
        leans_temp = leans_lagged(Vv,Ian,0,std(Ian-mean(Ian)),1);
		leans_stored3c(tstep,tsstep) = leans_temp(1,2);
    end;
end;

leans_stored1c
leans_stored2c
leans_stored3c

warning('on','all');
