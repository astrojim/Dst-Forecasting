function penvec = leanings(C,E,nbins)

[tstructE, countsE] = hist_extra(E,nbins);
[tstructC, countsC] = hist_extra(C,nbins);

binUpperE = zeros(1,length(tstructE));
binLowerE = zeros(1,length(tstructE));
binUpperC = zeros(1,length(tstructC));
binLowerC = zeros(1,length(tstructC));

for iter = 1:1:nbins,
    binUpperE(iter) = tstructE(nbins-iter+1).binUpper;
    binLowerE(iter) = tstructE(nbins-iter+1).binLower;
    binUpperC(iter) = tstructC(nbins-iter+1).binUpper;
    binLowerC(iter) = tstructC(nbins-iter+1).binLower;
end;

[tstructJEC, countsJEC] = histjoint_extraWBIN(E,C,binUpperE,binLowerE,binUpperC,binLowerC);
[tstructJCE, countsJCE] = histjoint_extraWBIN(C,E,binUpperC,binLowerC,binUpperE,binLowerE);

Edist = countsE./length(E);
Cdist = countsC./length(C);
jdistEC = countsJEC./length(E);
jdistCE = countsJCE./length(E);

ECpen = zeros(nbins*nbins,1);
step = 1;
for iter1 = 1:1:size(jdistEC,1),
	for iter2 = 1:1:size(jdistEC,2),
      
      if( Cdist(iter2) ~= 0  && Edist(iter1) ~= 0 && Cdist(iter1) ~= 0  && Edist(iter2) ~= 0),
        tempCE = (jdistCE(iter2,iter1)*((1/Edist(iter1))+(1/(1-Edist(iter1))))-Cdist(iter2)/(1-Edist(iter1)));
        tempEC = (jdistEC(iter1,iter2)*((1/Cdist(iter2))+(1/(1-Cdist(iter2))))-Edist(iter1)/(1-Cdist(iter2)));
        ECpen(step) = tempEC-tempCE;
        step = step+1;
        clear tempCE tempEC
      end;
      
  end;
end;

penvec = ECpen;