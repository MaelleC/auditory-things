cf = 1e3;
tdres = 1/100e3;
cohc = 1;
cihc = 1;
implnt = 0;


reptime = 1;

y = [0];
y = repmat(y, 1, round(reptime / tdres));
	
test = 0;

only_show = 1;

for fibertype=1:1:3

	if only_show == 1
		load(zcfilename('zsavef/rmds', 'clickbase', fibertype, 0));
		fibertype
		clickbaseline = mean(clickbaselines)
		clickbaseline_noref = mean(clickbaselines_noref)
		clickbaselinevar = var(clickbaselines)
		clickbaselinevar_noref = var(clickbaselines_noref)
	else
		fibertype
		clickbaselines = [];
		clickbaselines_noref = [];
		for nr_exp_inner=1:1:10
			nrep = 400;
			[vihc, synout, psth, synout_noref, psth_noref] = zuconcreteuse(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt);
			clickbaselines = [clickbaselines mean(psth)];
			clickbaselines_noref = [clickbaselines_noref mean(psth_noref)];
		end
		
		if test == 1
			figure
			x = 0 : (round(reptime / tdres) - 1);
			x = x * tdres;	
			subplot(2, 1, 1);
			plot(x, psth);
			title(strcat('psth, fb ', num2str(fibertype)));
			subplot(2, 1, 2);
			plot(x, psth_noref);
			title(strcat('psth_noref, fb ', num2str(fibertype)));
		end
		
		%save what is necessary
		save(zcfilename('zsavef/rmds', 'clickbase', fibertype, 0), 'clickbaselines', 'clickbaselines_noref');
	
	end
	
end