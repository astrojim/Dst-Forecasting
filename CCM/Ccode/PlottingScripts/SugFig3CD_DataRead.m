%Reproducing Sugihara Figure 3 C and D

Coutputfilename = sprintf('PAItesting_eY.dat');
fprintf('Reading %s...',Coutputfilename);
tic;
if exist(Coutputfilename, 'file')
    fileID = fopen(Coutputfilename,'r');
    Outdat = fscanf(fileID, '%f');
    fclose(fileID);
    if(numel(Outdat) == 0),
        fprintf('Warning: Too few output data points\n');
    end;
    Cdata_XgY = Outdat(1:(length(Outdat)/2));
    Cdata_YgX = Outdat(((length(Outdat)/2)+1):end);
else
  fprintf('Warning: %s does not exist\n',Coutputfilename);
end;
fprintf('done. [%f]\n',toc);

Coutputfilename = sprintf('PAItesting_eY_PAIflag.dat');
fprintf('Reading %s...',Coutputfilename);
tic;
if exist(Coutputfilename, 'file')
    fileID = fopen(Coutputfilename,'r');
    Outdat = fscanf(fileID, '%f');
    fclose(fileID);
    if(numel(Outdat) == 0),
        fprintf('Warning: Too few output data points\n');
    end;
    Cdata_XgX = Outdat(1:(length(Outdat)/4));
    Cdata_XgXY = Outdat(((length(Outdat)/4)+1):(length(Outdat)/2));
    Cdata_YgY = Outdat(((length(Outdat)/2)+1):(3*length(Outdat)/4));
    Cdata_YgYX = Outdat(((3*length(Outdat)/4)+1):end);
else
  fprintf('Warning: %s does not exist\n',Coutputfilename);
end;
fprintf('done. [%f]\n',toc);

fprintf('Creating reference TS...');
tic;
Bxy = 0;
Byx = 0.32;
library_length = 1000;

X = zeros(library_length,1);
Y = X;
X(1) = 0.2;
Y(1) = 0.4;
rx = 3.7;
ry = 3.7;

for fstep = 1:(length(X)-1),
    X(fstep+1) = X(fstep)*(rx-rx*X(fstep)-Bxy*Y(fstep));
    Y(fstep+1) = Y(fstep)*(ry-ry*Y(fstep)-Byx*X(fstep));
end;
fprintf('done. [%f]\n',toc);