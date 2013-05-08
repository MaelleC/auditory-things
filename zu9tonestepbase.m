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


reptime = 0.1;

only_show = 1;

fibertype = 3;
pressure_exp = low_pressure_exp;

for nr_exp=1:1:9
	
	fibertype
	pressure_exp
	
	tonestepbaselines = [];
	tonestepbaselines_noref = [];
	
	t = 0:(round(reptime/tdres) - 1); 
	
	t = t*tdres;	 
	y = sin(2*pi*t*fc);	 
	y = y*pression;
	
	nrep = 400;% !! changed from 800 !
	
	[vihc, synout, psth, synout_noref, psth_noref] = zuusemodel(y,cf,nrep,tdres,reptime, cohc, cihc, fibertype, implnt);
	
	%2000 -> 0.02 seconds : 
	tonestepbaselines = [tonestepbaselines mean(psth(2000 : length(psth)))];
	tonestepbaselines_noref = [tonestepbaselines_noref mean(psth_noref(2000 : length(psth_noref)))];
	
	gentitle = 'pure tone st.';	
	zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
	gentitle = [gentitle ' no_ref'];
	zgfourgraphs(y, vihc, psth_noref, synout_noref, reptime, nrep, tdres, gentitle);


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
	
	%save what is necessary
	save(zcfilename('zsavef/rmdsbase', experiment, fibertype, pressure_exp), 'tonestepbaselines', 'tonestepbaselines_noref');

end