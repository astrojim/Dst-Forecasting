
% load X and Y
x50 = rand(1,50);
x100 = rand(1,100);
x250 = rand(1,250);
x500 = rand(1,500);

% parameter settings
LCClags = 1:1:20;
xtol50 = (max(x50)-min(x50))/4;
xtol100 = (max(x100)-min(x100))/4;
xtol250 = (max(x50)-min(x250))/4;
xtol500 = (max(x50)-min(x500))/4;
E = 10;
tau = 1;
verb = true;
skipGC = true;

% ECA
[TE_50,GC_50,PAI_50,L_50,LCC_50,g_50] = ECA(x50,x50,xtol50,xtol50,LCClags,E,tau,verb,skipGC);
[TE_100,GC_100,PAI_100,L_100,LCC_100,g_100] = ECA(x100,x100,xtol100,xtol100,LCClags,E,tau,verb,skipGC); 
[TE_250,GC_250,PAI_250,L_250,LCC_250,g_250] = ECA(x250,x250,xtol250,xtol250,LCClags,E,tau,verb,skipGC);
[TE_500,GC_500,PAI_500,L_500,LCC_500,g_500] = ECA(x500,x500,xtol500,xtol500,LCClags,E,tau,verb,skipGC);