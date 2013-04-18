function [vihc, synout, psth, synout_noref, psth_noref] = zusemodel(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt)

if length(y) ~= reptime/tdres
	error('Length of stimulus does not match reptime ! ');
end

 stim = repmat(y, 1, nrep);

[vihc, synout, psth, synout_noref, psth_noref] = zconcreteuse(stim, cf, 1, tdres, reptime*nrep, cohc, cihc, fibertype, implnt);

 real_length = length(synout)/nrep;
 vihc = vihc(1 + 9*real_length: 10*real_length);
 synout = synout(1 + 9*real_length: 10*real_length);
 
 psth = zcomputePSTH(psth, nrep);
 psth_noref = zcomputePSTH(psth_noref, nrep);
 
 