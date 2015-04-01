% comparing tolerance methods
warning('off','all');

fprintf('Linear example: L = 20, 50, 100, and 500\n');
fprintf('Method 1: ytol = B\n');
fprintf('Method 2: ytol = mean(|y_{t}-x_{t-1}|)\n');
fprintf('Method 3: ytol = std(y-mean(y))\n');
fprintf('Method 4: ytol = n-bin mean std\n');

B = 0.8;%[0:0.1:1.0];
Lvec = 100;%[20,50,100,500];
lag = 1;%1:1:20;
nb = 5;

leans_stored1a = nan(length(B),length(Lvec),length(lag));
leans_stored2a = nan(length(B),length(Lvec),length(lag));
leans_stored3a = nan(length(B),length(Lvec),length(lag));
leans_stored4a = nan(length(B),length(Lvec),length(lag));

for giter = 1:1:length(lag),
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

            leans_temp = leans_lagged(x,y,0,B(step),lag(giter));
            leans_stored1a(step,Liter,giter) = leans_temp(1,2);

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

            leans_temp = leans_lagged(x,y,0,mean(absnoiseiny),lag(giter));
            leans_stored2a(step,Liter,giter) = leans_temp(1,2);

            leans_temp = leans_lagged(x,y,0,std(y-mean(y)),lag(giter));
            leans_stored3a(step,Liter,giter) = leans_temp(1,2);

            [Xtsteps_struct,counts] = hist_extra(x,nb);
            [Ytsteps_struct,counts] = hist_extra(y,nb);
            Xbinstds = zeros(1,nb);
            Ybinstds = zeros(1,nb);
            for iter = 1:1:nb,
                if( isnan(Xtsteps_struct(iter).tsteps) ),
                    Xbinstds(iter) = nan;
                else
                    Xbinstds(iter) = std(x(Xtsteps_struct(iter).tsteps));
                end;
                if( isnan(Ytsteps_struct(iter).tsteps) ),
                    Ybinstds(iter) = nan;
                else
                    Ybinstds(iter) = std(y(Ytsteps_struct(iter).tsteps));
                end;
            end;
            xtol = nanmean(Xbinstds);
            ytol = nanmean(Ybinstds);

            leans_temp = leans_lagged(x,y,0,nanmean(Ybinstds),lag(giter));
            leans_stored4a(step,Liter,giter) = leans_temp(1,2);


        end;
    end;
end;

leans_stored1a
leans_stored2a
leans_stored3a
leans_stored4a

warning('on','all');
