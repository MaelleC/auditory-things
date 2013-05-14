experiment = 'click'; % ~30'

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
completethings = 1;

%complete all , so that tonestepbaselinestdper tonestepbaselinestdper_noref < = 0.01
%then, zcrmd_calclick

for fibertype=1:1:3

	if only_show == 1
		fibertype
		
		%'clickbaselines', 'clickbaselines_noref'
		load(zcfilename('zsavef/rmdsbase', experiment, fibertype, 0));
		
		clickbaseline = mean(clickbaselines)
		lenclickbaseline = length(clickbaselines)
		clickbaseline_noref = mean(clickbaselines_noref)
		lenclickbaseline_noref = length(clickbaselines_noref)
		clickbaselinestd = std(clickbaselines)/sqrt(length(clickbaselines));
		clickbaselinestd_noref = std(clickbaselines_noref)/sqrt(length(clickbaselines_noref));
		clickbaselinestdper = clickbaselinestd/clickbaseline
		clickbaselinestdper_noref = clickbaselinestd_noref/clickbaseline_noref
	else
		fibertype
		
		if completethings == 1
			%'clickbaselines', 'clickbaselines_noref'
			load(zcfilename('zsavef/rmdsbase', experiment, fibertype, 0));
		
		else
			clickbaselines = [];
			clickbaselines_noref = [];
		end
		
		for nr_exp_inner=1:1:10
			nrep = 400;
			
			% !!! really use of zuconcreteuse ? (for only zeros, probably ok)
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
		save(zcfilename('zsavef/rmdsbase', experiment, fibertype, 0), 'clickbaselines', 'clickbaselines_noref');
	
	end
	
end