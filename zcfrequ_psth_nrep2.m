function [] = zcfrequ_psth_nrep2(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, frequ)

savethings = 1

completethings = 1

filename = 'zsavef/frequ_psth2';

if completethings == 1
	% 'bpsth', 'bpsth_noref', 'repstot'
	load(zcfilename(filename, num2str(frequ), fibertype, pressure_exp));
	
else
	bpsth = zeros(1, round((reptime - 1)/tdres));
	bpsth_noref = zeros(1, round((reptime - 1)/tdres));
	repstot = 0;
end

for nr_exp=0:1:(nr_use - 1)
	[vihc, synout, psth, synout_noref, psth_noref] = zuconcreteuse(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt);
	
	%reptime is a natural number > 1 s	
	
	if nr_exp == 0 && rem(frequ, 500) == 0 && 1 == 0
		figure
		plot(psth((1e5 + 1): length(psth)));
		title([num2str(frequ) ' ' num2str(sum(psth))]);
		figure 
		plot(y)
		title(['stim ' num2str(frequ)]);
		
	end
	
	bpsth = bpsth + psth((1e5 + 1): length(psth));
	bpsth_noref = bpsth_noref + psth_noref((1e5 + 1): length(psth_noref));
	
end
repstot = repstot + nrep * nr_use

if savethings == 1
	save(zcfilename(filename, num2str(frequ), fibertype, pressure_exp), 'bpsth', 'bpsth_noref', 'repstot');
end