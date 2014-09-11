%Explore convergence of snow data

E = 3;
tau = 1;

snowdata %load pair0087

Tfinals = [10:10:7750];

for Tfstep = 1:1:length(Tfinals);

    tspan = Tfinals(Tfstep);
    library_length = tspan;

    fprintf('--> L = %i <--\n',Tfinals(Tfstep));

    fprintf('Creating C input data files...');
    tic;
    CoutputfilenameXY = sprintf('snowdataCCMout_L%i.dat',Tfinals(Tfstep));
    CinputfilenameXY = sprintf('snowdata_temp.dat');

    fileID = fopen(CinputfilenameXY,'w');
    for tstep = 1:1:tspan,
        fprintf(fileID,'%.20f,%.20f;\n',pair0087(tstep,1),pair0087(tstep,2));
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
