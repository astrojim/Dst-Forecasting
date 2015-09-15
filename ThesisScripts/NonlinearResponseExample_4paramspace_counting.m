load NonlinearResponseExample_4paramspace_20150909_pruned.mat

total = 0;
zeros = 0;
notnums = 0;
defnums = 0;

notvecs = nan(65988,4);
numvecs = nan(94012,4);
gvecs = nan(94012,5);

for Aiter = 1:1:20,
    for Biter = 1:1:20,
        for Citer = 1:1:20,
            for Diter = 1:1:20,
                
                gtemp = reshape(g_stored(Aiter,Biter,Citer,Diter,:),1,5);
                gsum = sum(gtemp);
                
                if( gsum == 0 ), zeros = zeros + 1; end;
                if( isnan(gsum) ), 
                    notnums = notnums + 1;
                    notvecs(notnums,1) = Aiter;
                    notvecs(notnums,2) = Biter;
                    notvecs(notnums,3) = Citer;
                    notvecs(notnums,4) = Diter;
                else
                    defnums = defnums + 1;
                    numvecs(defnums,1) = Aiter;
                    numvecs(defnums,2) = Biter;
                    numvecs(defnums,3) = Citer;
                    numvecs(defnums,4) = Diter;
                    gvecs(defnums,1) = gtemp(1);
                    gvecs(defnums,2) = gtemp(2);
                    gvecs(defnums,3) = gtemp(3);
                    gvecs(defnums,4) = gtemp(4);
                    gvecs(defnums,5) = gtemp(5);
                end;
                total = total + 1;
            end;
        end;
    end;
end;   

Avec = [0.05:0.05:1.0];
Bvec = [0.05:0.05:1.0];
Cvec = [0.05:0.05:1.0];
Dvec = [0.05:0.05:1.0];

g_stored_pruned = g_stored(1:11,:,:,:,:);

total_pruned = 0;
zeros_pruned = 0;
notnums_pruned = 0;
defnums_pruned = 0;

% notvecs_pruned = nan(65988,4);
numvecs_pruned = nan(88000,4);
gvecs_pruned = nan(88000,5);

for Aiter = 1:1:11,
    for Biter = 1:1:20,
        for Citer = 1:1:20,
            for Diter = 1:1:20,
                
                gtemp = reshape(g_stored_pruned(Aiter,Biter,Citer,Diter,:),1,5);
                gsum = sum(gtemp);
                
                if( gsum == 0 ), zeros_pruned = zeros_pruned + 1; end;
                if( isnan(gsum) ), 
                    notnums_pruned = notnums_pruned + 1;
%                     notvecs_pruned(notnums_pruned,1) = Aiter;
%                     notvecs_pruned(notnums_pruned,2) = Biter;
%                     notvecs_pruned(notnums_pruned,3) = Citer;
%                     notvecs_pruned(notnums_pruned,4) = Diter;
                else
                    defnums_pruned = defnums_pruned + 1;
                    numvecs_pruned(defnums_pruned,1) = Aiter;
                    numvecs_pruned(defnums_pruned,2) = Biter;
                    numvecs_pruned(defnums_pruned,3) = Citer;
                    numvecs_pruned(defnums_pruned,4) = Diter;
                    gvecs_pruned(defnums_pruned,1) = gtemp(1);
                    gvecs_pruned(defnums_pruned,2) = gtemp(2);
                    gvecs_pruned(defnums_pruned,3) = gtemp(3);
                    gvecs_pruned(defnums_pruned,4) = gtemp(4);
                    gvecs_pruned(defnums_pruned,5) = gtemp(5);
                end;
                total_pruned = total_pruned + 1;
            end;
        end;
    end;
end;

TE = gvecs_pruned(:,1);
GC = gvecs_pruned(:,2);
PAI = gvecs_pruned(:,3);
L = gvecs_pruned(:,4);
LCC = gvecs_pruned(:,5);

TEones = find(TE == 1);
TEtwoes = find(TE == 2);
GCones = find(GC == 1);
GCtwoes = find(GC == 2);
PAIones = find(PAI == 1);
PAItwoes = find(PAI == 2);
Lones = find(L == 1);
Ltwoes = find(L == 2);
LCCones = find(LCC == 1);
LCCtwoes = find(LCC == 2);

TEonesnums = numvecs_pruned(TEones,:);
GConesnums = numvecs_pruned(GCones,:);
PAIonesnums = numvecs_pruned(PAIones,:);
Lonesnums = numvecs_pruned(Lones,:);
LCConesnums = numvecs_pruned(LCCones,:);
