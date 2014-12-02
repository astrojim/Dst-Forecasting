function penvec = penchants2E(C,E1,E2,nbins)

[tstructC, countsC] = hist_extra(C,nbins);
[tstructE1, countsE1] = hist_extra(E1,nbins);
[tstructE2, countsE2] = hist_extra(E2,nbins);

binUpperC = zeros(1,length(tstructC));
binLowerC = zeros(1,length(tstructC));
binUpperE1 = zeros(1,length(tstructE1));
binLowerE1 = zeros(1,length(tstructE1));
binUpperE2 = zeros(1,length(tstructE2));
binLowerE2 = zeros(1,length(tstructE2));

for iter = 1:1:nbins,
    binUpperC(iter) = tstructC(nbins-iter+1).binUpper;
    binLowerC(iter) = tstructC(nbins-iter+1).binLower;
    binUpperE1(iter) = tstructE1(nbins-iter+1).binUpper;
    binLowerE1(iter) = tstructE1(nbins-iter+1).binLower;
    binUpperE2(iter) = tstructE2(nbins-iter+1).binUpper;
    binLowerE2(iter) = tstructE2(nbins-iter+1).binLower;
end;

[tstructE, countsE] = histjoint_extraWBIN(E1,E2,...
    binUpperE1,binLowerE1,binUpperE2,binLowerE2);
[tstructJ, countsJ] = histjoint3_extraWBIN(C,E1,E2,...
    binUpperC,binLowerC,binUpperE1,binLowerE1,binUpperE2,binLowerE2);

Cdist = countsC./length(C);
Edist = countsE./length(C);
jdist = countsJ./length(C);

ECpen = zeros(nbins*nbins*nbins,1);
step = 1;
for iter1 = 1:1:size(jdist,1),
	for iter2 = 1:1:size(jdist,2),
        for iter3 = 1:1:size(jdist,3),
    
            if( Cdist(iter1) ~= 0 && Edist(iter2,iter3) ~= 0 ),
            ECpen(step) = (jdist(iter1,iter2,iter3)*((1/Cdist(iter1))...
                +(1/(1-Cdist(iter1))))-Edist(iter2,iter3)/(1-Cdist(iter1)));
            step = step+1;
            end;

        end;
    end;
end;

penvec = ECpen;
