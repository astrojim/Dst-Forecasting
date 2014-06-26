E = 3;
tau = 1;

tspan = 0:0.5:1000;
library_length = length(tspan);

Av = 0.5:0.5:5.0;
Bv = 0:0.5:5.0;
Cv = 0:0.5:5.0;

for Astep = 1:1:length(Av),
    for Bstep = 1:1:length(Bv),
        for Cstep = 1:1:length(Cv),

            fprintf('--> A = %.2f; B = %.2f; C = %.2f <--\n',...
                Av(Astep),Bv(Bstep),Cv(Cstep));

            Xt = zeros(length(tspan),1);
            Yt = zeros(length(tspan),1);

            Xt(1) = sin(tspan(1));
            Yt(1) = 0;
            A = Av(Astep);
            B = Bv(Bstep);
            C = Cv(Cstep);
            for step = 2:length(tspan),
                Xt(step) = sin(tspan(step));
                Yt(step) = (A*Xt(step-1))*(1-B*Xt(step-1))+C*randn();
            end;

            fprintf('Creating C input data files...');
            tic;
            CoutputfilenameXY = sprintf('XYoutPAI_A%.2fB%.2fC%.2f.dat',...
                Av(Astep),Bv(Bstep),Cv(Cstep));
            CinputfilenameXY = sprintf('XYnLPAI_temp.dat');

            fileID = fopen(CinputfilenameXY,'w');
            for tstep = 1:1:length(tspan),
                fprintf(fileID,'%.20f,%.20f;\n',Xt(tstep),Yt(tstep));
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
        end;
    end;
end;