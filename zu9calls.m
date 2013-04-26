low_pressure_exp = -3; %50db
middle_pressure_exp = 0; %110db
high_pressure_exp = 3; %170db

cf = 1e3;
tdres = 1/100e3;
cohc = 1;
cihc = 1;
implnt = 0;

nr_use = 10;

nr_exp = 1;
fibertype = 1;
pressure_exp = low_pressure_exp;

while nr_exp <= 9
	
	%click
	%-----
	%10e-4 s click, 50db, rarefaction, 10 clicks per s, p21-22
	nrep = 400;
	reptime = 0.1;
	pressure = -6.32 * exp(pressure_exp);

	clicklen = 1e-4;%in sec


	y = ones(1, round(clicklen/tdres));
	y = [y zeros(1, reptime/tdres - length(y))];
	y = y*pressure;

	[rmd1, rmd1_noref, rmd1_wmean, rmd1_wmean_noref] = zcrmd_nexp(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, 'click');


	%tonestep
	%--------
	
	fc = 1e4;
	
	nrep = 800; 
	reptime = 0.1;
	pressure = -6.32 * exp(pressure_exp);
 
	t = 0:(ceil(reptime/tdres) - 1); 
	t = t*tdres;
 
	x = sin(2*pi*t*fc);
 
	m = [ones(1, ceil(reptime/tdres * 0.5)) (-1 * ones(1, ceil(reptime/tdres  * 0.5)))];

	M=1;%modulation
 
	y = (1+M*m).*x;
	y = y*pressure;

	[rmd2, rmd2_noref, rmd2_wmean, rmd2_wmean_noref] = zcrmd_nexp(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, 'tonestep');
	

	%noisestep
	%---------
	
	nrep = 800;
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
	
	[rmd3, rmd3_noref, rmd3_wmean, rmd3_wmean_noref] = zcrmd_nexp(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, 'noisestep');

	%tone
	%----

	f = 1e3;
	
	nrep = 1000;
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
	
	
	[rmd4, rmd4_noref, rmd4_wmean, rmd4_wmean_noref] = zcrmd_nexp(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, 'tone');
	
	
	%save what is necessary
	
	
	%TODO : 
	bargraph_rmd = [rmd1(1) rmd1_noref(1); rmd2(1) rmd2_noref(1); rmd3(1) rmd3_noref(1); rmd4(1) rmd4_noref(1);];
	bargraph_rmd_wmean  = [rmd1_wmean(1) rmd1_wmean_noref(1); rmd2_wmean(1) rmd2_wmean_noref(1); rmd3_wmean(1) rmd3_wmean_noref(1); rmd4_wmean(1) rmd4_wmean_noref(1);];
	
	bargraph_rmd_all = [rmd1 rmd1_noref; rmd2 rmd2_noref; rmd3 rmd3_noref; rmd4 rmd4_noref;];
	bargraph_rmd_wmean_all  = [rmd1_wmean rmd1_wmean_noref; rmd2_wmean rmd2_wmean_noref; rmd3_wmean rmd3_wmean_noref; rmd4_wmean rmd4_wmean_noref;];
	
	save(zcfilename('zsavef/rmds', 'arrays', fibertype, pressure_exp), 'bargraph_rmd', 'bargraph_rmd_wmean', 'bargraph_rmd_all', 'bargraph_rmd_wmean_all');
	
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
	
	nr_exp = nr_exp + 1;
	
end


