function [vihc, synout, psth, synout_noref, psth_noref] = zuusemodel_rep(stim, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt)

if rem(length(stim), ceil(reptime/tdres)) ~= 0
	reptime
	tdres
	reptime/tdres
	length(y)
	error('Length of stimulus does not match a multiple of reptime ! ');
elseif rem(length(stim), nrep) ~= 0
	error('Length of stimulus is not a multiple of  nrep! ');
elseif nrep < 11
	error('nrep should be at least 11')
end 
 
 
 %stim = repmat(y, 1, nrep);
 
 
[vihc, synout, psth, synout_noref, psth_noref] = zuconcreteuse(stim, cf, 1, tdres, reptime*nrep, cohc, cihc, fibertype, implnt);

 real_length = length(synout)/nrep;
 vihc = vihc(1 + 9*real_length: 10*real_length);
 synout = synout(1 + 9*real_length: 10*real_length);
 synout_noref = synout_noref(1 + 9*real_length: 10*real_length);
 
 psth = zccomputePSTH(psth, nrep);
 psth_noref = zccomputePSTH(psth_noref, nrep);