ParamDimList = 15:1:1000;

for pdstep = 1:1:length(ParamDimList),
    ParamDim = ParamDimList(pdstep);
    DataCorrExplore;
    savename = sprintf('./data/CCMdata_fullL_tau1_multiEdim/CCMdata_fullL_tau1_Edim%i.mat',ParamDimList(pdstep));
    save(savename);
    clearvars -except ParamDimList pdstep;
end;