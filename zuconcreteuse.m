function [vihc, synout, psth, synout_noref, psth_noref] = zuconcreteuse(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt)

%does not work
if (nargin<5)
  error('not enough arguments for zusemodel (need at least the 5 first ones)');
elseif (nargin<6) or isempty(cohc)
  cohc = 1;
elseif (nargin<7) or isempty(cihc)
  cihc = 1;
elseif (nargin<8) or isempty(fibertype)
  fibertype = 2;
elseif (nargin<9) or isempty(implnt)
  implnt = 0;
end

 vihc = catmodel_IHC(y,cf,nrep,tdres,reptime,cohc,cihc);
 [synout, psth] = catmodel_Synapse(vihc,cf,nrep,tdres,fibertype,implnt);
 [synout_noref, psth_noref] = catmodel_Synapse_noref(vihc,cf,nrep,tdres,fibertype,implnt);