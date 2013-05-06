low_pressure_exp = -3; %50db
middle_pressure_exp = -1; %90db
high_pressure_exp = 1; %130db

cf = 1e3;
tdres = 1/100e3;
cohc = 1;
cihc = 1;
implnt = 0;

nr_use = 10;

fibertype = 1;
pressure_exp = low_pressure_exp;

onlyclick = 1;


for nr_exp=1:1:9
	nr_exp
	%click
	%-----
	%10e-4 s click, 50db, rarefaction, 10 clicks per s, p21-22
	nrep = 400;%400 ok
	reptime = 0.1;
	pressure = -6.3245 * exp(pressure_exp);

	clicklen = 1e-4;%in sec


	y = ones(1, round(clicklen/tdres));
	y = [y zeros(1, round(reptime/tdres) - length(y))];
	y = y*pressure;

	%zcrmd_nexp(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, 'click');%also in other experiments
	zcrmd_nexprmd(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, 'click');

if onlyclick == 0

	%tonestep
	%--------
	fc = 1e4;
	
	nrep = 800; %800 ok
	reptime = 0.1;
	pressure = -6.32 * exp(pressure_exp);
 
	t = 0:(ceil(reptime/tdres) - 1); 
	t = t*tdres;
 
	x = sin(2*pi*t*fc);
 
	m = [ones(1, ceil(reptime/tdres * 0.5)) (-1 * ones(1, ceil(reptime/tdres  * 0.5)))];

	M=1;%modulation
 
	y = (1+M*m).*x;
	y = y*pressure;

	
	zcrmd_nexprmd(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, 'tonestep');
	

	%noisestep
	%---------
	nrep = 800;%800 ok
	reptime = 0.1;
	pressure = -6.32 * exp(pressure_exp);
 
	t = 0:(ceil(reptime/tdres) - 1); 
	t = t*tdres;
 
	x = normrnd(0, 1, 1, length(t));
	x = x / sqrt(tdres);
 
	%fm = 100;
	%m = sin(2*pi*t*fm);
	m = [ones(1, ceil(reptime/tdres * 0.5)) (-1 * ones(1, ceil(reptime/tdres  * 0.5)))];

	M=1;%modulation
 
	y = (1+M*m).*x;
	y = y*pressure;
	
	zcrmd_nexprmd(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, 'noisestep');

	%tone
	%----
	f = 1e3;
	
	nrep = 1000;%1000 ok
	reptime = 0.001;
	pressure = -6.32 * exp(pressure_exp);

	t = 0:(reptime/tdres-1); 
	t = t*tdres;
 
	x = sin(2*pi*t*f);
 
	fm = 100; 
	m = sin(2*pi*t*fm);
	M=0;%modulation
 
	y = (1+M*m).*x;
	y = y*pressure;
		
	%zcrmd_nexp(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, 'tone');
	zcrmd_nexprmd(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, 'tone');
	
end %onlyclick
	
	%iteration
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


