%Explore convergence of snow data

E = 4;
tau = 1;

alttempdata %load pair0001

Tfinals = [10:10:340];

for Tfstep = 1:1:length(Tfinals);

    tspan = Tfinals(Tfstep);
    library_length = tspan;

    fprintf('--> L = %i <--\n',Tfinals(Tfstep));

    fprintf('Creating C input data files...');
    tic;
    CoutputfilenameXY = sprintf('alttempdataCCMout_L%i.dat',Tfinals(Tfstep));
    CinputfilenameXY = sprintf('alttempdata_temp.dat');

    fileID = fopen(CinputfilenameXY,'w');
    for tstep = 1:1:tspan,
        fprintf(fileID,'%.20f,%.20f;\n',pair0001(tstep,1),pair0001(tstep,2));
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
