
global tspan;
global Vv;
global RR;
global L;

xytol = [0,1e-10,1e-9,1e-8,1e-7,1e-6,1e-5,1e-4,1e-3,1e-2,1e-1];
lag = [1:1:20];

Tt = pi/2:pi/2:4*pi;
Ttstep = pi/100;

leans_storedVI = nan(length(Tt),length(lag),length(xytol));

for tolstep = 1:1:length(xytol),
    for tstep = 1:1:length(Tt),
        for lstep = 1:1:length(lag),

            tspan  = 0 : Ttstep : Tt(tstep);
            % d = [0 : 1/1e3 : 10e-3 ; 0.8.^(0:10)]';
            % Vv = pulstran(tspan,d,'gauspuls',10e3,0.5);  
            Vv = sin(tspan);
            RR = 5.*ones(length(tspan),1);
            L = 10;

            fprintf('lag = %i/%i, tstep = %i/%i, xytol = %i/%i \n',...
                lag(lstep),length(lag),tstep,length(Tt),tolstep,length(xytol));

            fprintf('Starting ODE solver...');
            Ix0 = 0;
            [tx Ix] = ode45('RLcircuit',tspan,Ix0);
            fprintf('done.\n');

            %VI
            leans_temp = leans_lagged(Vv,Ix,0,xytol(tolstep),lag(lstep));
            leans_storedVI(tstep,lstep,tolstep) = leans_temp(1,2);
        end;
    end;
end;

