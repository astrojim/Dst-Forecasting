%Explore convergence of Av(27), Bv(27) vs Av(31), B(27)

E = 3;
tau = 1;

Tfinals = [10:10:4180];

for Tfstep = 1:1:length(Tfinals);

    tspan = 0:0.5:Tfinals(Tfstep);
    library_length = length(tspan);

    fprintf('--> L = %i <--\n',Tfinals(Tfstep));

    Xt = zeros(length(tspan),1);
    Yt = zeros(length(tspan),1);

    Xt(1) = sin(tspan(1));
    Yt(1) = 0;
    A = 2.6; %index 27
    %A = 3.0; %index 31
    B = 2.6; %index 27
    for step = 2:length(tspan),
        Xt(step) = sin(tspan(step));
        Yt(step) = A*Xt(step-1)+B*randn();
    end;

    fprintf('Creating C input data files...');
    tic;
    CoutputfilenameXY = sprintf('XYout_A%.2fB%.2f_L%i.dat',A,B,Tfinals(Tfstep));
    CinputfilenameXY = sprintf('XY_temp.dat');

    fileID = fopen(CinputfilenameXY,'w');
    for tstep = 1:1:length(tspan),
        fprintf(fileID,'%.20f,%.20f;\n',Xt(tstep),Yt(tstep));
    end;
    fclose(fileID);
    fprintf('done. [%f]\n',toc);

    fprintf('Calling C code...');
    tic;

    CCommandString = sprintf('./CCMpair -E %i -t %i -L %i -f %s -n %i -o %s -p %i',...
                                  E,tau,library_length,CinputfilenameXY,tau,...
                                  CoutputfilenameXY,2);
    [status,cmdout] = system(CCommandString);
    %fprintf('%s\n',cmdout);
    RMCommandString = sprintf('rm %s',CinputfilenameXY);
    system(RMCommandString);
    fprintf('done. [%f]\n',toc);

end;
