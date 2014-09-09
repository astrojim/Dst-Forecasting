addpath('..');
addpath('../../utils');

global tspan;
global Vv;
global RR;
global L;

tspan = [0:0.5:1000];

bVaryV_amp = false;
bVaryV_offset = false;
bVaryV_phase = false;
bVaryV_freq = true;
bVaryR_amp = false;
bVaryR_offset = true;
bVaryR_phase = true;
bVaryR_freq = true;

bVaryV_offsetlong = false;
bVaryV_offsetLup = false;

bVaryR_freqlong = false;
bVaryR_freqLup = false;

E = 4;

if( bVaryV_amp ),
% 
    Av = [0.01:0.01:2.0];
    %Vv = Av.*sin(Omegav.*tspan+Phiv)+V0;

    %RR = Ar.*sin(Omegar.*tspan+Phir)+R0;
    RR = 5.*ones(length(tspan),1);
    L = 10;

    tau = 1;
    library_length = length(tspan);

    for vstep = 1:length(Av),

        fprintf('--> Av = %.3f [%.5f complete] <--\n',...
            Av(vstep),vstep/length(Av));
        Vv = Av(vstep).*sin(tspan);
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
        CoutputfilenameRI = sprintf('RIoutE3_temp_Av%.3f.dat',Av(vstep));
        CinputfilenameRI = sprintf('RI_tempVa.dat');
        CoutputfilenameRV = sprintf('RVoutE3_temp_Av%.3f.dat',Av(vstep));
        CinputfilenameRV = sprintf('RV_tempVa.dat');
        CoutputfilenameVI = sprintf('VIoutE3_temp_Av%.3f.dat',Av(vstep));
        CinputfilenameVI = sprintf('VI_tempVa.dat');

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
end;

if( bVaryV_offset ),

    offset = [0.01:0.01:2.0];
    %Vv = Av.*sin(Omegav.*tspan+Phiv)+V0;

    %RR = Ar.*sin(Omegar.*tspan+Phir)+R0;
    RR = 5.*ones(length(tspan),1);
    L = 10;

    
    tau = 1;
    library_length = length(tspan);

    for vstep = 1:length(offset),

        fprintf('--> offset = %.3f [%.5f complete] <--\n',...
            offset(vstep),vstep/length(offset));
        Vv = sin(tspan)+offset(vstep);
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
        CoutputfilenameRI = sprintf('RIoutE3_temp_offset%.3f.dat',offset(vstep));
        CinputfilenameRI = sprintf('RI_tempVo.dat');
        CoutputfilenameRV = sprintf('RVoutE3_temp_offset%.3f.dat',offset(vstep));
        CinputfilenameRV = sprintf('RV_tempVo.dat');
        CoutputfilenameVI = sprintf('VIoutE3_temp_offset%.3f.dat',offset(vstep));
        CinputfilenameVI = sprintf('VI_tempVo.dat');

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
end;

if( bVaryV_phase ),

    phase = [0.01:0.01:2.0];
    %Vv = Av.*sin(Omegav.*tspan+Phiv)+V0;

    %RR = Ar.*sin(Omegar.*tspan+Phir)+R0;
    RR = 5.*ones(length(tspan),1);
    L = 10;

    
    tau = 1;
    library_length = length(tspan);

    for vstep = 1:length(phase),

        fprintf('--> phase = %.3f [%.5f complete] <--\n',...
            phase(vstep),vstep/length(phase));
        Vv = sin(tspan+phase(vstep));
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
        CoutputfilenameRI = sprintf('RIoutE3_temp_phase%.3f.dat',phase(vstep));
        CinputfilenameRI = sprintf('RI_tempVp.dat');
        CoutputfilenameRV = sprintf('RVoutE3_temp_phase%.3f.dat',phase(vstep));
        CinputfilenameRV = sprintf('RV_tempVp.dat');
        CoutputfilenameVI = sprintf('VIoutE3_temp_phase%.3f.dat',phase(vstep));
        CinputfilenameVI = sprintf('VI_tempVp.dat');

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
end;

if( bVaryV_freq ),

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
        CoutputfilenameRI = sprintf('RIoutE4_temp_freq%.3f.dat',freq(vstep));
        CinputfilenameRI = sprintf('RI_tempVf.dat');
        CoutputfilenameRV = sprintf('RVoutE4_temp_freq%.3f.dat',freq(vstep));
        CinputfilenameRV = sprintf('RV_tempVf.dat');
        CoutputfilenameVI = sprintf('VIoutE4_temp_freq%.3f.dat',freq(vstep));
        CinputfilenameVI = sprintf('VI_tempVf.dat');

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
end;

if( bVaryR_amp ),

    Av = [0.01:0.01:2.0];
    %Vv = Av.*sin(Omegav.*tspan+Phiv)+V0;

    %RR = Ar.*sin(Omegar.*tspan+Phir)+R0;
    Vv = 5.*ones(length(tspan),1);
    L = 10;

    
    tau = 1;
    library_length = length(tspan);

    for vstep = 1:length(Av),

        fprintf('--> Av = %.3f [%.5f complete] <--\n',...
            Av(vstep),vstep/length(Av));
        RR = Av(vstep).*sin(tspan)+5;
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
        CoutputfilenameRI = sprintf('RIoutE3_tempR_Av%.3f.dat',Av(vstep));
        CinputfilenameRI = sprintf('RI_tempRav.dat');
        CoutputfilenameRV = sprintf('RVoutE3_tempR_Av%.3f.dat',Av(vstep));
        CinputfilenameRV = sprintf('RV_tempRav.dat');
        CoutputfilenameVI = sprintf('VIoutE3_tempR_Av%.3f.dat',Av(vstep));
        CinputfilenameVI = sprintf('VI_tempRav.dat');

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
end;

if( bVaryR_offset ),

    offset = [0.01:0.01:2.0];
    %Vv = Av.*sin(Omegav.*tspan+Phiv)+V0;

    %RR = Ar.*sin(Omegar.*tspan+Phir)+R0;
    Vv = 5.*ones(length(tspan),1);
    L = 10;

    
    tau = 1;
    library_length = length(tspan);

    for vstep = 1:length(offset),

        fprintf('--> offset = %.3f [%.5f complete] <--\n',...
            offset(vstep),vstep/length(offset));
        RR = sin(tspan)+offset(vstep)+5;
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
        CoutputfilenameRI = sprintf('RIoutE3_tempR_offset%.3f.dat',offset(vstep));
        CinputfilenameRI = sprintf('RI_tempRo.dat');
        CoutputfilenameRV = sprintf('RVoutE3_tempR_offset%.3f.dat',offset(vstep));
        CinputfilenameRV = sprintf('RV_tempRo.dat');
        CoutputfilenameVI = sprintf('VIoutE3_tempR_offset%.3f.dat',offset(vstep));
        CinputfilenameVI = sprintf('VI_tempRo.dat');

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
end;

if( bVaryR_phase ),

    phase = [0.01:0.01:2.0];
    %Vv = Av.*sin(Omegav.*tspan+Phiv)+V0;

    %RR = Ar.*sin(Omegar.*tspan+Phir)+R0;
    Vv = 5.*ones(length(tspan),1);
    L = 10;

    
    tau = 1;
    library_length = length(tspan);

    for vstep = 1:length(phase),

        fprintf('--> phase = %.3f [%.5f complete] <--\n',...
            phase(vstep),vstep/length(phase));
        RR = sin(tspan+phase(vstep))+5;
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
        CoutputfilenameRI = sprintf('RIoutE3_tempR_phase%.3f.dat',phase(vstep));
        CinputfilenameRI = sprintf('RI_tempRp.dat');
        CoutputfilenameRV = sprintf('RVoutE3_tempR_phase%.3f.dat',phase(vstep));
        CinputfilenameRV = sprintf('RV_tempRp.dat');
        CoutputfilenameVI = sprintf('VIoutE3_tempR_phase%.3f.dat',phase(vstep));
        CinputfilenameVI = sprintf('VI_tempRp.dat');

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
end;

if( bVaryR_freq ),

    freq = [0.01:0.01:2.0];
    %Vv = Av.*sin(Omegav.*tspan+Phiv)+V0;

    %RR = Ar.*sin(Omegar.*tspan+Phir)+R0;
    Vv = 5.*ones(length(tspan),1);
    L = 10;

    
    tau = 1;
    library_length = length(tspan);

    for vstep = 1:length(freq),

        fprintf('--> freq = %.3f [%.5f complete] <--\n',...
            freq(vstep),vstep/length(freq));
        RR = sin(freq(vstep)*tspan)+5;
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
        CoutputfilenameRI = sprintf('RIoutE3_tempR_freq%.3f.dat',freq(vstep));
        CinputfilenameRI = sprintf('RI_tempRf.dat');
        CoutputfilenameRV = sprintf('RVoutE3_tempR_freq%.3f.dat',freq(vstep));
        CinputfilenameRV = sprintf('RV_tempRf.dat');
        CoutputfilenameVI = sprintf('VIoutE3_tempR_freq%.3f.dat',freq(vstep));
        CinputfilenameVI = sprintf('VI_tempRf.dat');

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
end;

if( bVaryV_offsetlong ),

    offset = [0.01:0.05:10.0];
    %Vv = Av.*sin(Omegav.*tspan+Phiv)+V0;

    %RR = Ar.*sin(Omegar.*tspan+Phir)+R0;
    RR = 5.*ones(length(tspan),1);
    L = 10;

    
    tau = 1;
    library_length = length(tspan);

    for vstep = 1:length(offset),

        fprintf('--> offset = %.3f [%.5f complete] <--\n',...
            offset(vstep),vstep/length(offset));
        Vv = sin(tspan)+offset(vstep);
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
        CoutputfilenameRI = sprintf('RIoutE3_temp_offsetlong%.3f.dat',offset(vstep));
        CinputfilenameRI = sprintf('RI_tempVol.dat');
        CoutputfilenameRV = sprintf('RVoutE3_temp_offsetlong%.3f.dat',offset(vstep));
        CinputfilenameRV = sprintf('RV_tempVol.dat');
        CoutputfilenameVI = sprintf('VIoutE3_temp_offsetlong%.3f.dat',offset(vstep));
        CinputfilenameVI = sprintf('VI_tempVol.dat');

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
end;

if( bVaryV_offsetLup ),

    tspan = [0:0.5:5000];
    offset = [0.01:0.01:2.0];
    %Vv = Av.*sin(Omegav.*tspan+Phiv)+V0;

    %RR = Ar.*sin(Omegar.*tspan+Phir)+R0;
    RR = 5.*ones(length(tspan),1);
    L = 10;

    
    tau = 1;
    library_length = length(tspan);

    for vstep = 1:length(offset),

        fprintf('--> offset = %.3f [%.5f complete] <--\n',...
            offset(vstep),vstep/length(offset));
        Vv = sin(tspan)+offset(vstep);
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
        CoutputfilenameRI = sprintf('RIoutE3_temp_offsetLup%.3f.dat',offset(vstep));
        CinputfilenameRI = sprintf('RI_tempVolu.dat');
        CoutputfilenameRV = sprintf('RVoutE3_temp_offsetLup%.3f.dat',offset(vstep));
        CinputfilenameRV = sprintf('RV_tempVolu.dat');
        CoutputfilenameVI = sprintf('VIoutE3_temp_offsetLup%.3f.dat',offset(vstep));
        CinputfilenameVI = sprintf('VI_tempVolu.dat');

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
end;

if( bVaryR_freqlong ),

    freq = [0.01:0.05:10.0];
    %Vv = Av.*sin(Omegav.*tspan+Phiv)+V0;

    %RR = Ar.*sin(Omegar.*tspan+Phir)+R0;
    Vv = 5.*ones(length(tspan),1);
    L = 10;

    
    tau = 1;
    library_length = length(tspan);

    for vstep = 1:length(freq),

        fprintf('--> freq = %.3f [%.5f complete] <--\n',...
            freq(vstep),vstep/length(freq));
        RR = sin(freq(vstep)*tspan)+5;
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
        CoutputfilenameRI = sprintf('RIoutE3_tempR_freqlong%.3f.dat',freq(vstep));
        CinputfilenameRI = sprintf('RI_tempRfl.dat');
        CoutputfilenameRV = sprintf('RVoutE3_tempR_freqlong%.3f.dat',freq(vstep));
        CinputfilenameRV = sprintf('RV_tempRfl.dat');
        CoutputfilenameVI = sprintf('VIoutE3_tempR_freqlong%.3f.dat',freq(vstep));
        CinputfilenameVI = sprintf('VI_tempRfl.dat');

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
end;

if( bVaryR_freqLup ),

    tspan = [0:0.5:5000];
    freq = [0.01:0.01:2.0];
    %Vv = Av.*sin(Omegav.*tspan+Phiv)+V0;

    %RR = Ar.*sin(Omegar.*tspan+Phir)+R0;
    Vv = 5.*ones(length(tspan),1);
    L = 10;

    
    tau = 1;
    library_length = length(tspan);

    for vstep = 1:length(freq),

        fprintf('--> freq = %.3f [%.5f complete] <--\n',...
            freq(vstep),vstep/length(freq));
        RR = sin(freq(vstep)*tspan)+5;
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
        CoutputfilenameRI = sprintf('RIoutE3_tempR_freqLup%.3f.dat',freq(vstep));
        CinputfilenameRI = sprintf('RI_tempRflu.dat');
        CoutputfilenameRV = sprintf('RVoutE3_tempR_freqLup%.3f.dat',freq(vstep));
        CinputfilenameRV = sprintf('RV_tempRflu.dat');
        CoutputfilenameVI = sprintf('VIoutE3_tempR_freqLup%.3f.dat',freq(vstep));
        CinputfilenameVI = sprintf('VI_tempRflu.dat');

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
end;
