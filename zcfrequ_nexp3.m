function [] = zcfrequ_nexp3(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, frequ)

savethings = 1

completethings = 0

filename = 'zsavef/frequ3_repn'
%filename = 'zsavef/frequ3_nomod'

if completethings == 1
	% 'fouriers0', 'fouriers0_noref' 'fouriers1', 'fouriers1_noref', 'fouriers2', 'fouriers2_noref', 'fouriers3', 'fouriers3_noref', 'nrep_nexp'
	load(zcfilename(filename, num2str(frequ), fibertype, pressure_exp));
	
%zsavef/frequ3_repn : the nrep = 400, nr_use = 1, pressure_exp = -7 % try with 800, but not ok (concreteuse was used !)
%zsavef/frequ3_nomod : same but no modulation, not ok
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
	
	%reptime is a natural number > 1 s
	
	%if rem(frequ, 250) == 0 && nr_use == 0
	if nr_exp == 0
		figure
		plot(psth((1e5 + 1): length(psth)));
		title([num2str(frequ) ' ' num2str(sum(psth))]);
		figure 
		plot(y)
		title(['stim ' num2str(frequ)]);
		
	end
	%end
	
	freptime = reptime -1;
	
	fouriers0 = [fouriers0 zcfourier(psth((1e5 + 1): length(psth)), tdres, freptime, 0)];
	fouriers0_noref = [fouriers0_noref zcfourier(psth_noref((1e5 + 1): length(psth)), tdres, freptime, 0)];
	fouriers1 = [fouriers1 zcfourier(psth((1e5 + 1): length(psth)), tdres, freptime, 1)];
	fouriers1_noref = [fouriers1_noref zcfourier(psth_noref((1e5 + 1): length(psth)), tdres, freptime, 1)];
	fouriers2 = [fouriers2 zcfourier(psth((1e5 + 1): length(psth)), tdres, freptime, 2)];
	fouriers2_noref = [fouriers2_noref zcfourier(psth_noref((1e5 + 1): length(psth)), tdres, freptime, 2)];
	fouriers3 = [fouriers3 zcfourier(psth((1e5 + 1): length(psth)), tdres, freptime, 3)];
	fouriers3_noref = [fouriers3_noref zcfourier(psth_noref((1e5 + 1): length(psth)), tdres, freptime, 3)];
end

nrep_nexp  = nrep;
fourierslen = length(fouriers0)

if savethings == 1
	save(zcfilename(filename, num2str(frequ), fibertype, pressure_exp), 'fouriers0', 'fouriers0_noref', 'fouriers1', 'fouriers1_noref', 'fouriers2', 'fouriers2_noref', 'fouriers3', 'fouriers3_noref', 'nrep_nexp');
end