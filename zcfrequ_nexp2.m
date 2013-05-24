function [] = zcfrequ_nexp2(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, knum)

savethings = 1;

completethings = 0 % !! change that

if completethings == 1
	% 'fouriers0', 'fouriers0_noref' 'fouriers1', 'fouriers1_noref', 'fouriers2', 'fouriers2_noref', 'fouriers3', 'fouriers3_noref', 'nrep_nexp'
	load(zcfilename('zsavef/frequ_kmod', num2str(knum), fibertype, pressure_exp));

else
	fouriers0 = [];
	fouriers0_noref = [];
	fouriers1 = [];
	fouriers1_noref = [];
	fouriers2 = [];
	fouriers2_noref = [];
	fouriers3 = [];
	fouriers3_noref = [];
end


for nr_exp=0:1:(nr_use - 1)
	[vihc, synout, psth, synout_noref, psth_noref] = zuusemodel(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt);
	fouriers0 = [fouriers0 zcfourier(psth, tdres, reptime, 0)];
	fouriers0_noref = [fouriers0_noref zcfourier(psth_noref, tdres, reptime, 0)];
	fouriers1 = [fouriers1 zcfourier(psth, tdres, reptime, 1)];
	fouriers1_noref = [fouriers1_noref zcfourier(psth_noref, tdres, reptime, 1)];
	fouriers2 = [fouriers2 zcfourier(psth, tdres, reptime, 2)];
	fouriers2_noref = [fouriers2_noref zcfourier(psth_noref, tdres, reptime, 2)];
	fouriers3 = [fouriers3 zcfourier(psth, tdres, reptime, 3)];
	fouriers3_noref = [fouriers3_noref zcfourier(psth_noref, tdres, reptime, 3)];
end

nrep_nexp  = nrep;

if savethings == 1
	save(zcfilename('zsavef/frequ_kmod', num2str(knum), fibertype, pressure_exp), 'fouriers0', 'fouriers0_noref', 'fouriers1', 'fouriers1_noref', 'fouriers2', 'fouriers2_noref', 'fouriers3', 'fouriers3_noref', 'nrep_nexp');
end