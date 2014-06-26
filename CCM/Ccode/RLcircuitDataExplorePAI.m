addpath('..');
addpath('../../utils');

global tspan;
global Vv;
global RR;
global L;

tspan = [0:0.5:1000];

E = 2;

%if( bVaryV_freq ),

freq = [0.01:0.01:2.0];
%Vv = Av.*sin(Omegav.*tspan+Phiv)+V0;

%RR = Ar.*sin(Omegar.*tspan+Phir)+R0;
RR = 5.*ones(length(tspan),1);
L = 10;


tau = 1;
library_length = length(tspan);

for vstep = 1:length(freq),

    fprintf('--> freq = %.3f [%.5f complete] <--\n',...
        freq(vstep),vstep/length(freq));
    Vv = sin(freq(vstep)*tspan);
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
    CoutputfilenameRI = sprintf('RIoutE2_tempPAI_freq%.3f.dat',freq(vstep));
    CinputfilenameRI = sprintf('RI_tempPAIVf.dat');
    CoutputfilenameRV = sprintf('RVoutE2_tempPAI_freq%.3f.dat',freq(vstep));
    CinputfilenameRV = sprintf('RV_tempPAIVf.dat');
    CoutputfilenameVI = sprintf('VIoutE2_tempPAI_freq%.3f.dat',freq(vstep));
    CinputfilenameVI = sprintf('VI_tempPAIVf.dat');

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
    CCommandString = sprintf('./PAI -E %i -t %i -Ey 1 -ty 1 -L %i -f %s -n %i -o %s -eY tempeYout.dat -PAI',...
                                  E,tau,library_length,CinputfilenameRI,1,...
                                  CoutputfilenameRI);
    [status,cmdout] = system(CCommandString);
    %fprintf('%s\n',cmdout);
    RMCommandString = sprintf('rm %s',CinputfilenameRI);
    system(RMCommandString);

    %RV
    CCommandString = sprintf('./PAI -E %i -t %i -Ey 1 -ty 1 -L %i -f %s -n %i -o %s -eY tempeYout.dat -PAI',...
                                  E,tau,library_length,CinputfilenameRV,1,...
                                  CoutputfilenameRV);
    [status,cmdout] = system(CCommandString);
    %fprintf('%s\n',cmdout);
    RMCommandString = sprintf('rm %s',CinputfilenameRV);
    system(RMCommandString);

    %VI
    CCommandString = sprintf('./PAI -E %i -t %i -Ey 1 -ty 1 -L %i -f %s -n %i -o %s -eY tempeYout.dat -PAI',...
                                  E,tau,library_length,CinputfilenameVI,1,...
                                  CoutputfilenameVI);
    [status,cmdout] = system(CCommandString);
    %fprintf('%s\n',cmdout);
    RMCommandString = sprintf('rm %s',CinputfilenameVI);
    system(RMCommandString);
    fprintf('done. [%f]\n',toc);

end;


