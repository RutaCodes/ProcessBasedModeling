function [kgeval] = kge(modelled,observed)
%Nash Sutcliffe Efficiency measure

modelled = modelled(2:length(modelled));
observed = observed(2:length(observed));

%cflow=[modelled;observed];

sdmodelled=std(modelled);
sdobserved=std(observed);
 
mmodelled=mean(modelled);
mobserved=mean(observed);

%r=corr(cflow');
r = corrcoef(modelled,observed);
relvar=sdmodelled/sdobserved;
bias=mmodelled/mobserved;

%KGE timeseries 
kgeval = 1 - sqrt( ((r(1,2)-1)^2) + ((relvar-1)^2)  + ((bias-1)^2) );