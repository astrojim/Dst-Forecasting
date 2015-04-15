%B = [0:0.01:1.0];
%xytol = [0:0.01:1];
%lag = 1;

B = 0.5;
xytol = B;
lag = 1;%[1,2,3];
lagAR = 1;%[0,1];

leans_storedXY = nan(length(B),length(xytol));
leans_keepXY = nan(length(lag),length(lagAR));

leans_storedYZ = nan(length(B),length(xytol));
leans_keepYZ = nan(length(lag),length(lagAR));

leans_storedXZ = nan(length(B),length(xytol));
leans_keepXZ = nan(length(lag),length(lagAR));

liblength = 500;
hitspace = 5;
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
for lARstep = 1:1:length(lagAR),
    for lstep = 1:1:length(lag), 
        for outer = 1:1:length(xytol),
            for step = 1:1:length(B),

                fprintf('B = %.2f; xytol = %.2f; lag = %i ...',B(step),xytol(outer),lag(lstep));
                tic;
                y = zeros(1,length(x));
                z = zeros(1,length(x));
                for iter = 2:1:length(y),
                    y(iter) = x(iter-1) + B(step)*randn();
                    z(iter) = y(iter-1) + x(iter-1) + z(iter-1);
                end;

                leans_temp = leans_laggedAR(x,y,0,xytol(outer),lag(lstep),lagAR(lARstep));
                leans_storedXY(step,outer) = leans_temp(1,2);
                leans_keepXY(lstep,lARstep) = leans_temp(1,2);

                leans_temp = leans_laggedAR(y,z,xytol(outer),xytol(outer),lag(lstep),lagAR(lARstep));
                leans_storedYZ(step,outer) = leans_temp(1,2);
                leans_keepYZ(lstep,lARstep) = leans_temp(1,2);

                leans_temp = leans_laggedAR(x,z,0,xytol(outer),lag(lstep),lagAR(lARstep));
                leans_storedXZ(step,outer) = leans_temp(1,2);
                leans_keepXZ(lstep,lARstep) = leans_temp(1,2);

                fprintf(' done. [%.3f]\n',toc);

            end;
        end;
    end;
end;