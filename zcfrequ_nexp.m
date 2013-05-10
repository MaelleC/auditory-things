function [] = zcfrequ_nexp(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, knum)

savethings = 1;

completethings = 1

if completethings == 1
	% 'fouriers1', 'fouriers1_noref', 'nrep_nexp'
	load(zcfilename('zsavef/frequ_k', num2str(knum), fibertype, pressure_exp));

else
	fouriers1 = [];
	fouriers1_noref = [];
end


for nr_exp=0:1:(nr_use - 1)
	[vihc, synout, psth, synout_noref, psth_noref] = zuusemodel(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt);
	fouriers1 = [fouriers1 zcfourier(psth, tdres, reptime, 1)];
	fouriers1_noref = [fouriers1_noref zcfourier(psth_noref, tdres, reptime, 1)];
end

nrep_nexp  = nrep;

if savethings == 1
	save(zcfilename('zsavef/frequ_k', num2str(knum), fibertype, pressure_exp), 'fouriers1', 'fouriers1_noref', 'nrep_nexp');
end