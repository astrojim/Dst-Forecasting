function OutputScalar = ShannonEntropy_Normal(X)

entX = 0;
lenX = length(X);

for cstep = 1:lenX,
	entX = entX + X(cstep)*log2(X(cstep));
end;
entX = -(1/log2(lenX))*entX;
        
OutputScalar = entX;