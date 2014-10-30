% x = [0,1,2,1,0];
% y = [0,0,1,2,1];
% dx = [0,1,1,-1,-1];
% dy = [0,0,1,1,-1];

x = [0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1,0];
y = [0,0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1];
dx = [0,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1];
dy = [0,0,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1];

nbins = 3;

% [tstruct, counts] = histjoint_extra(x,y,nbins);
% counts
% [tstruct, counts] = histjoint_extra(dx,y,nbins);
% counts

testxy1 = penchants(x,y,nbins);
mean(testxy1)
testyx1 = penchants(y,x,nbins);
mean(testyx1)

testxy2 = penchants(dx,y,nbins);
mean(testxy2)
testyx2 = penchants(y,dx,nbins);
mean(testyx2)