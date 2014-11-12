% x = [0,1,2,1,0];
% y = [0,0,1,2,1];
% dx = [0,1,1,-1,-1];
% dy = [0,0,1,1,-1];

x = [0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1,0];
y = [0,0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1];
dx = [0,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1];
dy = [0,0,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,];

nbins = 3;
[truth,LIRvec] = LIRpenchants(x,y,nbins);
fprintf('Notional TS; nbins = 3\n')
truth
temp = LIRvec;
lenvec = leaning(x,y,3);

nbins = 4;
[truth,LIRvec] = LIRpenchants(x,y,nbins);
fprintf('Notional TS; nbins = 4\n')
truth

nbins = 5;
[truth,LIRvec] = LIRpenchants(x,y,nbins);
fprintf('Notional TS; nbins = 5\n')
truth

nbins = 10;
[truth,LIRvec] = LIRpenchants(x,y,nbins);
fprintf('Notional TS; nbins = 10\n')
truth


nbins = 20;
[x,y,xd,yd] = LinearEx(0.01);
[truth,LIRvec] = LIRpenchants(x,y,nbins);
fprintf('LinearEx Sine TS; nbins = 20, B = 0.01\n')
truth

nbins = 20;
[x,y,xd,yd] = LinearEx(0.5);
[truth,LIRvec] = LIRpenchants(x,y,nbins);
fprintf('LinearEx Sine TS; nbins = 20, B = 0.5\n')
truth

nbins = 20;
[x,y,xd,yd] = LinearEx(0.8);
[truth,LIRvec] = LIRpenchants(x,y,nbins);
fprintf('LinearEx Sine TS; nbins = 20, B = 0.8\n')
truth

nbins = 50;
[x,y,xd,yd] = LinearEx(0.01);
[truth,LIRvec] = LIRpenchants(x,y,nbins);
fprintf('LinearEx Sine TS; nbins = 50, B = 0.01\n')
truth

nbins = 50;
[x,y,xd,yd] = LinearEx(0.5);
[truth,LIRvec] = LIRpenchants(x,y,nbins);
fprintf('LinearEx Sine TS; nbins = 50, B = 0.5\n')
truth

nbins = 50;
[x,y,xd,yd] = LinearEx(0.8);
[truth,LIRvec] = LIRpenchants(x,y,nbins);
fprintf('LinearEx Sine TS; nbins = 50, B = 0.8\n')
truth