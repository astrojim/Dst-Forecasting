E = 4;
tau = 1;

tspan = 0:0.5:1000;
library_length = length(tspan);

%Av = 0:0.1:10.0;
Av = 4.8:0.1:10.0;
Bv = 0:0.1:10.0;

for Astep = 1:1:length(Av),
    for Bstep = 1:1:length(Bv),

        fprintf('--> A = %.2f; B = %.2f <--\n',...
            Av(Astep),Bv(Bstep));
        
        Xt = zeros(length(tspan),1);
        Yt = zeros(length(tspan),1);
        Zt = zeros(length(tspan),1);

        Xt(1) = sin(tspan(1));
        Yt(1) = 0;
        Zt(1) = 0;
        A = Av(Astep);
        B = Bv(Bstep);
        for step = 2:length(tspan),
            Xt(step) = sin(tspan(step));
            Yt(step) = A*Xt(step-1)+B*randn();
            Zt(step) = Yt(step-1);
        end;
        
        fprintf('Creating C input data files...');
        tic;
        CoutputfilenameXY = sprintf('XYoutPAIXYZ_A%.2fB%.2f.dat',Av(Astep),Bv(Bstep));
        CinputfilenameXY = sprintf('XY_tempPAIXYZ.dat');
        CoutputfilenameYZ = sprintf('YZoutPAIXYZ_A%.2fB%.2f.dat',Av(Astep),Bv(Bstep));
        CinputfilenameYZ = sprintf('YZ_tempPAIXYZ.dat');
        CoutputfilenameXZ = sprintf('XZoutPAIXYZ_A%.2fB%.2f.dat',Av(Astep),Bv(Bstep));
        CinputfilenameXZ = sprintf('XZ_tempPAIXYZ.dat');

        fileID = fopen(CinputfilenameXY,'w');
        for tstep = 1:1:length(tspan),
            fprintf(fileID,'%.20f,%.20f;\n',Xt(tstep),Yt(tstep));
        end;
        fclose(fileID);
        fprintf('done. [%f]\n',toc);
        
        fileID = fopen(CinputfilenameYZ,'w');
        for tstep = 1:1:length(tspan),
            fprintf(fileID,'%.20f,%.20f;\n',Yt(tstep),Zt(tstep));
        end;
        fclose(fileID);
        fprintf('done. [%f]\n',toc);
        
        fileID = fopen(CinputfilenameXZ,'w');
        for tstep = 1:1:length(tspan),
            fprintf(fileID,'%.20f,%.20f;\n',Xt(tstep),Zt(tstep));
        end;
        fclose(fileID);
        fprintf('done. [%f]\n',toc);

        fprintf('Calling C code...');
        tic;

        CCommandString = sprintf('./PAI -E %i -t %i -Ey 1 -ty 1 -L %i -f %s -n %i -o %s -eY tempeYout.dat -PAI',...
                                      E,tau,library_length,CinputfilenameXY,tau,...
                                      CoutputfilenameXY);
        [status,cmdout] = system(CCommandString);
        %fprintf('%s\n',cmdout);
        RMCommandString = sprintf('rm %s',CinputfilenameXY);
        system(RMCommandString);
        fprintf('done. [%f]\n',toc);
        
        CCommandString = sprintf('./PAI -E %i -t %i -Ey 1 -ty 1 -L %i -f %s -n %i -o %s -eY tempeYout.dat -PAI',...
                                      E,tau,library_length,CinputfilenameYZ,tau,...
                                      CoutputfilenameYZ);
        [status,cmdout] = system(CCommandString);
        %fprintf('%s\n',cmdout);
        RMCommandString = sprintf('rm %s',CinputfilenameYZ);
        system(RMCommandString);
        fprintf('done. [%f]\n',toc);
        
        CCommandString = sprintf('./PAI -E %i -t %i -Ey 1 -ty 1 -L %i -f %s -n %i -o %s -eY tempeYout.dat -PAI',...
                                      E,tau,library_length,CinputfilenameXZ,tau,...
                                      CoutputfilenameXZ);
        [status,cmdout] = system(CCommandString);
        %fprintf('%s\n',cmdout);
        RMCommandString = sprintf('rm %s',CinputfilenameXZ);
        system(RMCommandString);
        fprintf('done. [%f]\n',toc);
    
    end;
end;