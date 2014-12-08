function penvecIMG = penchantsIMG(C,E,nbins)

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

[tstructJ, countsJ] = histjoint_extraWBIN(E,C,binUpperE,binLowerE,binUpperC,binLowerC);

Edist = countsE./length(E);
Cdist = countsC./length(C);
jdist = countsJ./length(E);

ECpenIMG = zeros(nbins,nbins);

for iter1 = 1:1:size(jdist,1),
	for iter2 = 1:1:size(jdist,2),
      
      if( Cdist(iter2) ~= 0  && Edist(iter1) ~= 0),
    	ECpenIMG(iter1,iter2) = (jdist(iter1,iter2)*((1/Cdist(iter2))+(1/(1-Cdist(iter2))))-Edist(iter1)/(1-Cdist(iter2)));
      end;
      
  end;
end;

penvecIMG.data2D = ECpenIMG;
penvecIMG.EbincenterY = (binUpperE+binLowerE)./2;
penvecIMG.CbincenterX = (binUpperC+binLowerC)./2;