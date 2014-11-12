function penvec = penchants2(C1,C2,E,nbins)

[tstructE, countsE] = hist_extra(E,nbins);
[tstructC1, countsC1] = hist_extra(C1,nbins);
[tstructC2, countsC2] = hist_extra(C2,nbins);

binUpperE = zeros(1,length(tstructE));
binLowerE = zeros(1,length(tstructE));
binUpperC1 = zeros(1,length(tstructC1));
binLowerC1 = zeros(1,length(tstructC1));
binUpperC2 = zeros(1,length(tstructC2));
binLowerC2 = zeros(1,length(tstructC2));

for iter = 1:1:nbins,
    binUpperE(iter) = tstructE(nbins-iter+1).binUpper;
    binLowerE(iter) = tstructE(nbins-iter+1).binLower;
    binUpperC1(iter) = tstructC1(nbins-iter+1).binUpper;
    binLowerC1(iter) = tstructC1(nbins-iter+1).binLower;
    binUpperC2(iter) = tstructC2(nbins-iter+1).binUpper;
    binLowerC2(iter) = tstructC2(nbins-iter+1).binLower;
end;

[tstructC, countsC] = histjoint_extraWBIN(C1,C2,...
    binUpperC1,binLowerC1,binUpperC2,binLowerC2);
[tstructJ, countsJ] = histjoint3_extraWBIN(E,C1,C2,...
    binUpperE,binLowerE,binUpperC1,binLowerC1,binUpperC2,binLowerC2);

Edist = countsE./length(E);
C1dist = countsC1./length(C1);
C2dist = countsC2./length(C2);
Cdist = countsC./length(E);
jdist = countsJ./length(E);

ECpen = zeros(size(jdist,1)*size(jdist,2)*size(jdist,3),1);
step = 1;
for iter1 = 1:1:size(jdist,1),
	for iter2 = 1:1:size(jdist,2),
        	for iter3 = 1:1:size(jdist,3),
      
              if( Cdist(iter2) ~= 0 ),
                ECpen(step) = (jdist(iter1,iter2)*((1/Cdist(iter2))+(1/(1-Cdist(iter2))))-Edist(iter1)/(1-Cdist(iter2)));
                %fprintf('ECpen = %.5f; (Edist(iter1),Cdist(iter2),jdist(iter1,iter2)) = (%.5f,%.5f,%.5f)\n',...
                %    ECpen(step),Edist(iter1),Cdist(iter2),jdist(iter1,iter2));
                step = step+1;
              end;
      
  end;
end;

penvec = ECpen;
