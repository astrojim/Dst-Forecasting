
global tspan;
global Vv;
global RR;
global L;

xytol = [0,1e-10,1e-9,1e-8,1e-7,1e-6,1e-5,1e-4,1e-3,1e-2,1e-1];
odetol = [1e-10,1e-9,1e-8,1e-7,1e-6,1e-5,1e-4,1e-3,1e-2,1e-1,5e-1];
lag = 1;%[1:1:20];

Tt = 6*pi; %pi/2:pi/2:4*pi;
Ttstep = pi/100;

leans_storedVI_ode45 = nan(length(Tt),length(lag),length(xytol),length(odetol));
leans_storedVI_ode23 = nan(length(Tt),length(lag),length(xytol),length(odetol));
leans_storedVI_ode113 = nan(length(Tt),length(lag),length(xytol),length(odetol));

for odestep = 1:1:length(odetol),
    for tolstep = 1:1:length(xytol),
        for tstep = 1:1:length(Tt),
            for lstep = 1:1:length(lag),

                tspan  = 0 : Ttstep : Tt(tstep);
                % d = [0 : 1/1e3 : 10e-3 ; 0.8.^(0:10)]';
                % Vv = pulstran(tspan,d,'gauspuls',10e3,0.5);  
                Vv = sin(tspan);
                RR = 5.*ones(length(tspan),1);
                L = 10;

                fprintf('lag = %i/%i, tstep = %i/%i, xytol = %i/%i odestep = %i/%i\n',...
                    lag(lstep),length(lag),tstep,length(Tt),tolstep,length(odetol),odestep,length(odetol));

                fprintf('Starting ODE solver...');
                Ix0 = 0;
                opt = odeset('RelTol',odetol(odestep),'AbsTol',odetol(odestep));

                [tx Ix] = ode45('RLcircuit',tspan,Ix0,opt);
                leans_temp = leans_lagged(Vv,Ix,0,xytol(tolstep),lag(lstep));
                leans_storedVI_ode45(tstep,lstep,tolstep,odestep) = leans_temp(1,2);

                [tx Ix] = ode23('RLcircuit',tspan,Ix0,opt);
                leans_temp = leans_lagged(Vv,Ix,0,xytol(tolstep),lag(lstep));
                leans_storedVI_ode23(tstep,lstep,tolstep,odestep) = leans_temp(1,2);
                
                [tx Ix] = ode113('RLcircuit',tspan,Ix0,opt);
                leans_temp = leans_lagged(Vv,Ix,0,xytol(tolstep),lag(lstep));
                leans_storedVI_ode113(tstep,lstep,tolstep,odestep) = leans_temp(1,2);
                
                fprintf('done.\n');

            end;
        end;
    end;
end;

