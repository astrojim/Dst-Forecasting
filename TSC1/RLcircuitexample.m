
global tspan;
global Vv;
global RR;
global L;

xtol = 0;%[0,1e-10,1e-9,1e-8,1e-7,1e-6,1e-5,1e-4,1e-3,1e-2,1e-1];
ytol = [0,1e-6,1e-5,1e-4,1e-3,1e-2,1e-1];
odetol = [1e-8,1e-7,1e-6,1e-5,1e-4,1e-3,1e-2,1e-1];
lag = 1;%[1:1:20];

Tt = 2*pi:2*pi:20*pi; %2*pi; 
Ttstep = pi/10;%[pi,pi/2,pi/4,pi/10,pi/50,pi/100,pi/1000,pi/10000];

leans_storedVI_ode45 = nan(length(Tt),length(Ttstep),length(lag),length(xtol),length(ytol),length(odetol));
% leans_storedVI_ode23 = nan(length(Tt),length(Ttstep),length(lag),length(xtol),length(ytol),length(odetol));
% leans_storedVI_ode113 = nan(length(Tt),length(Ttstep),length(lag),length(xtol),length(ytol),length(odetol));
leans_storedVI_an = nan(length(Tt),length(Ttstep),length(lag),length(xtol),length(ytol),length(odetol));

for odestep = 1:1:length(odetol),
    for xtolstep = 1:1:length(xtol),
        for ytolstep = 1:1:length(ytol),
            for tstep = 1:1:length(Tt),
                for tsstep = 1:1:length(Ttstep),
                    for lstep = 1:1:length(lag),

                        tspan  = 0 : Ttstep(tsstep) : Tt(tstep);
                        % d = [0 : 1/1e3 : 10e-3 ; 0.8.^(0:10)]';
                        % Vv = pulstran(tspan,d,'gauspuls',10e3,0.5);  
                        Vv = sin(tspan);
                        RR = 5.*ones(length(tspan),1);
                        L = 10;

                        fprintf('lag = %i/%i, tstep = %i/%i, xtol = %i/%i, ytol = %i/%i, TSstep = %i/%i, odestep = %i/%i\n',...
                            lag(lstep),length(lag),tstep,length(Tt),...
                            xtolstep,length(xtol),ytolstep,length(ytol),...
                            tsstep,length(Ttstep),odestep,length(odetol));

                        fprintf('Starting ODE solver...');
                        Ix0 = 0;
                        opt = odeset('RelTol',odetol(odestep),'AbsTol',odetol(odestep));

                        [tx Ix45] = ode45('RLcircuit',tspan,Ix0,opt);
                        leans_temp = leans_lagged(Vv,Ix45,xtol(xtolstep),ytol(ytolstep),lag(lstep));
                        leans_storedVI_ode45(tstep,tsstep,lstep,xtolstep,ytolstep,odestep) = leans_temp(1,2);

%                         [tx Ix23] = ode23('RLcircuit',tspan,Ix0,opt);
%                         leans_temp = leans_lagged(Vv,Ix23,xtol(xtolstep),ytol(ytolstep),lag(lstep));
%                         leans_storedVI_ode23(tstep,tsstep,lstep,xtolstep,ytolstep,odestep) = leans_temp(1,2);
% 
%                         [tx Ix113] = ode113('RLcircuit',tspan,Ix0,opt);
%                         leans_temp = leans_lagged(Vv,Ix113,xtol(xtolstep),ytol(ytolstep),lag(lstep));
%                         leans_storedVI_ode113(tstep,tsstep,lstep,xtolstep,ytolstep,odestep) = leans_temp(1,2);

                        Denom = L^2+RR(1)^2;
                        Eterm = (L/Denom).*exp((-RR(1)/L).*tspan);
                        Sterm = (RR(1)/Denom).*sin(tspan);
                        Cterm = (L/Denom).*cos(tspan);
                        Ian = Eterm+Sterm-Cterm;

                        leans_temp = leans_lagged(Vv,Ian,xtol(xtolstep),ytol(ytolstep),lag(lstep));
                        leans_storedVI_an(tstep,tsstep,lstep,xtolstep,ytolstep,odestep) = leans_temp(1,2);

                        fprintf('done.\n');

                    end;
                end;
            end;
        end;
    end;
end;

