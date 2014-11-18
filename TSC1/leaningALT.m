function lenvec = leaningALT(C,E,nbins)

CE = penchants(C,E,nbins);
EC = penchants(E,C,nbins);

lenvec = CE-EC;