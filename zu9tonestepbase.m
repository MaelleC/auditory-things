%3h

low_pressure_exp = -3; %50db
middle_pressure_exp = -1; %90db
high_pressure_exp = 1; %130db

experiment = 'tonestep';

cf = 1e3;
tdres = 1/100e3;
cohc = 1;
cihc = 1;
implnt = 0;
fc = 1e4;

nr_use = 10;

reptime = 0.1;

only_show = 0;
completethings = 1;
%complete all , so that tonestepbaselinestdper tonestepbaselinestdper_noref < = 0.01
%then, zcrmd_caltonest

fibertype = 1;
pressure_exp = low_pressure_exp;

for nr_exp=1:1:9

	if only_show == 1
	
		fibertype
		pressure_exp
		
		%'tonestepbaselines', 'tonestepbaselines_noref'
		load(zcfilename('zsavef/rmdsbase', experiment, fibertype, pressure_exp));
		tonestepbaseline = mean(tonestepbaselines)
		lentonestepbaseline = length(tonestepbaselines)
		tonestepbaseline_noref = mean(tonestepbaselines_noref)
		lentonestepbaseline_noref = length(tonestepbaselines_noref)
		tonestepbaselinestd = std(tonestepbaselines)/sqrt(length(tonestepbaselines));
		tonestepbaselinestd_noref = std(tonestepbaselines_noref)/sqrt(length(tonestepbaselines_noref));
		tonestepbaselinestdper = tonestepbaselinestd/tonestepbaseline
		tonestepbaselinestdper_noref = tonestepbaselinestd_noref/tonestepbaseline_noref
	
	else
	
		fibertype
		pressure_exp
		
		if completethings == 1
			%'tonestepbaselines', 'tonestepbaselines_noref'
			load(zcfilename('zsavef/rmdsbase', experiment, fibertype, pressure_exp));
		
		else
			tonestepbaselines = [];
			tonestepbaselines_noref = [];
		end
		
		t = 0:(ceil(reptime/tdres) - 1); 
		
		t = t*tdres;	 
		y = sin(2*pi*t*fc);	
		pressure = -6.32 * exp(pressure_exp);
		y = y*pressure;
		
		nrep = 800;
		
		stim = repmat(y, 1, nrep);
		for index =1:1:nr_use

			[vihc, synout, psth, synout_noref, psth_noref] = zuusemodel_rep(stim, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt);
			
			%2000 -> 0.02 seconds : 
			tonestepbaselines = [tonestepbaselines mean(psth(2000 : length(psth)))];
			tonestepbaselines_noref = [tonestepbaselines_noref mean(psth_noref(2000 : length(psth_noref)))];
		end
		
		%save what is necessary
		save(zcfilename('zsavef/rmdsbase', experiment, fibertype, pressure_exp), 'tonestepbaselines', 'tonestepbaselines_noref');
		
	end

	if (nr_exp == 3 || nr_exp == 6)
		if fibertype == 1
			fibertype = 2;
		else
			fibertype = 3;
		end
	end
	
	if pressure_exp == low_pressure_exp
		pressure_exp = middle_pressure_exp;
	elseif pressure_exp == middle_pressure_exp
		pressure_exp = high_pressure_exp;
	else
		pressure_exp = low_pressure_exp;
	end
	
	

end