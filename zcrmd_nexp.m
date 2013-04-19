function [rmd, rmd_noref, rmd_wmean, rmd_wmean_noref] = zcrmd_nexp(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, usespecbins)

%usespecbins : 1 if use of 2ms bins for max, and 10ms bins for baseline, when rmd

%must be divisible by 10e-5
binpeak = 2/1000;
binbase = 10/1000;

nr_exp = 0;

while(nr_exp < nr_use)
	
	
	

	nr_exp = nr_exp + 1;
end