function [vihc, synout, psth, synout_noref, psth_noref] = zuusemodel(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt)

if length(y) ~= round(reptime/tdres)
	reptime
	tdres
	reptime/tdres
	length(y)
	error('Length of stimulus does not match reptime ! ');
end 

 stim = repmat(y, 1, nrep);
 

 %lenstim = length(stim) * tdres
 %newreptime = reptime*nrep
 
 test = 0;
 if test == 1
	figure;
	plot(stim);
 end
 
 %reptime
 %stimlen = length(stim)
 %repnew = reptime*nrep
 %repwanted = stimlen * tdres
 
[vihc, synout, psth, synout_noref, psth_noref] = zuconcreteuse(stim, cf, 1, tdres, reptime*nrep, cohc, cihc, fibertype, implnt);

 real_length = round(length(synout)/nrep);
 vihc = vihc(1 + (nrep - 1)*real_length: nrep*real_length);
 synout = synout(1 + (nrep - 1)*real_length: nrep*real_length);
 synout_noref = synout_noref(1 + (nrep - 1)*real_length: nrep*real_length);
 
 psth = zccomputePSTH(psth, nrep);
 psth_noref = zccomputePSTH(psth_noref, nrep);
 
 