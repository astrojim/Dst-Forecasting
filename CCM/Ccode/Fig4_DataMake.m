addpath('..');
addpath('../../utils');

global tspan;
global Omega;

tspan = [0:0.5:1000];
OmegaVec = [0.1:0.1:2.0];

E = 5;
tau = 1;
library_length = length(tspan);

for ostep = 1:length(OmegaVec),
    
    fprintf('--> Omega = %.2f [%.2f complete] <--\n',...
        OmegaVec(ostep),ostep/length(OmegaVec));
    Omega = OmegaVec(ostep);
    Vspan = zeros(length(tspan),1);
    Rspan = zeros(length(tspan),1);
    for tstep = 1:1:length(tspan),
        VRL = RLcircuitVRL(tspan(tstep));
        Vspan(tstep,1) = VRL(1);
        Rspan(tstep,1) = VRL(2);
    end;

    fprintf('Starting ODE solver...');
    Ix0 = 0;
    [tx Ix] = ode45('RLcircuit',tspan,Ix0);
    fprintf('done.\n');

    fprintf('Creating C input data files...');
    tic;
    CoutputfilenameRI = sprintf('RIout_omega%.2f.dat',OmegaVec(ostep));
    CinputfilenameRI = sprintf('RI_omega%.2f.dat',OmegaVec(ostep));
    CoutputfilenameRV = sprintf('RVout_omega%.2f.dat',OmegaVec(ostep));
    CinputfilenameRV = sprintf('RV_omega%.2f.dat',OmegaVec(ostep));
    CoutputfilenameVI = sprintf('VIout_omega%.2f.dat',OmegaVec(ostep));
    CinputfilenameVI = sprintf('VI_omega%.2f.dat',OmegaVec(ostep));

    %RI
    fileID = fopen(CinputfilenameRI,'w');
    for tstep = 1:1:length(tspan),
        VRL = RLcircuitVRL(tspan(tstep));
        fprintf(fileID,'%.20f,%.20f;\n',VRL(2),Ix(tstep));
    end;
    fclose(fileID);

    %RV
    fileID = fopen(CinputfilenameRV,'w');
    for tstep = 1:1:length(tspan),
        VRL = RLcircuitVRL(tspan(tstep));
        fprintf(fileID,'%.20f,%.20f;\n',VRL(2),VRL(1));
    end;
    fclose(fileID);

    %VI
    fileID = fopen(CinputfilenameVI,'w');
    for tstep = 1:1:length(tspan),
        VRL = RLcircuitVRL(tspan(tstep));
        fprintf(fileID,'%.20f,%.20f;\n',VRL(1),Ix(tstep));
    end;
    fclose(fileID);
    fprintf('done. [%f]\n',toc);
    
    fprintf('Calling C code...');
    tic;
    
    %RI
    CCommandString = sprintf('./CCMpair -E %i -t %i -L %i -f %s -n %i -o %s -p %i',...
                                  E,tau,library_length,CinputfilenameRI,1,...
                                  CoutputfilenameRI,2);
    [status,cmdout] = system(CCommandString);
    %fprintf('%s\n',cmdout);
    RMCommandString = sprintf('rm %s',CinputfilenameRI);
    system(RMCommandString);
    
    %RV
    CCommandString = sprintf('./CCMpair -E %i -t %i -L %i -f %s -n %i -o %s -p %i',...
                                  E,tau,library_length,CinputfilenameRV,1,...
                                  CoutputfilenameRV,2);
    [status,cmdout] = system(CCommandString);
    %fprintf('%s\n',cmdout);
    RMCommandString = sprintf('rm %s',CinputfilenameRV);
    system(RMCommandString);
    
    %VI
    CCommandString = sprintf('./CCMpair -E %i -t %i -L %i -f %s -n %i -o %s -p %i',...
                                  E,tau,library_length,CinputfilenameVI,1,...
                                  CoutputfilenameVI,2);
    [status,cmdout] = system(CCommandString);
    %fprintf('%s\n',cmdout);
    RMCommandString = sprintf('rm %s',CinputfilenameVI);
    system(RMCommandString);
    fprintf('done. [%f]\n',toc);

end;
