function penvec = penchants3(C1,C2,E1,E2,nbins)

[tstructE1, countsE1] = hist_extra(E1,nbins);
[tstructE2, countsE2] = hist_extra(E2,nbins);
[tstructC1, countsC1] = hist_extra(C1,nbins);
[tstructC2, countsC2] = hist_extra(C2,nbins);

binUpperE1 = zeros(1,length(tstructE1));
binLowerE1 = zeros(1,length(tstructE1));
binUpperE2 = zeros(1,length(tstructE2));
binLowerE2 = zeros(1,length(tstructE2));
binUpperC1 = zeros(1,length(tstructC1));
binLowerC1 = zeros(1,length(tstructC1));
binUpperC2 = zeros(1,length(tstructC2));
binLowerC2 = zeros(1,length(tstructC2));

for iter = 1:1:nbins,
    binUpperE1(iter) = tstructE1(nbins-iter+1).binUpper;
    binLowerE1(iter) = tstructE1(nbins-iter+1).binLower;
    binUpperE2(iter) = tstructE2(nbins-iter+1).binUpper;
    binLowerE2(iter) = tstructE2(nbins-iter+1).binLower;
    binUpperC1(iter) = tstructC1(nbins-iter+1).binUpper;
    binLowerC1(iter) = tstructC1(nbins-iter+1).binLower;
    binUpperC2(iter) = tstructC2(nbins-iter+1).binUpper;
    binLowerC2(iter) = tstructC2(nbins-iter+1).binLower;
end;

[tstructC, countsC] = histjoint_extraWBIN(C1,C2,...
    binUpperC1,binLowerC1,binUpperC2,binLowerC2);
[tstructE, countsE] = histjoint_extraWBIN(E1,E2,...
    binUpperC1,binLowerC1,binUpperC2,binLowerC2);
[tstructJ, countsJ] = histjoint4_extraWBIN(E1,E2,C1,C2,...
    binUpperE1,binLowerE1,binUpperE2,binLowerE2,binUpperC1,binLowerC1,binUpperC2,binLowerC2);

Edist = countsE./length(E1);
Cdist = countsC./length(E1);
jdist = countsJ./length(E1);

ECpen = zeros(nbins*nbins*nbins*nbins,1);
step = 1;
for iter1 = 1:1:size(jdist,1),
	for iter2 = 1:1:size(jdist,2),
        for iter3 = 1:1:size(jdist,3),
            for iter4 = 1:1:size(jdist,4),

                if( Cdist(iter3,iter4) ~= 0 && Edist(iter1,iter2) ~= 0 ),
                ECpen(step) = (jdist(iter1,iter2,iter3,iter4)*((1/Cdist(iter3,iter4))...
                    +(1/(1-Cdist(iter3,iter4))))-Edist(iter1,iter2)/(1-Cdist(iter3,iter4)));
                step = step+1;
                end;
                
            end;
        end;
    end;
end;

penvec = ECpen;
