function [vihc, synout, psth, synout_noref, psth_noref] = zuusemodel(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt)

if length(y) ~= ceil(reptime/tdres)
	reptime
	tdres
	reptime/tdres
	length(y)
	error('Length of stimulus does not match reptime ! ');
elseif nrep < 11
	error('nrep should be at least 11')
end 

 stim = repmat(y, 1, nrep);
 

 %stim = stim(1:length(stim) - 1);
 lenstim = length(stim) * tdres
 newreptime = reptime*nrep
 
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

 real_length = length(synout)/nrep;
 vihc = vihc(1 + 9*real_length: 10*real_length);
 synout = synout(1 + 9*real_length: 10*real_length);
 
 psth = zccomputePSTH(psth, nrep);
 psth_noref = zccomputePSTH(psth_noref, nrep);
 
 