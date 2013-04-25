low_pressure_exp = -3; %50db
middle_pressure_exp = 0; %110db
high_pressure_exp = 3; %170db


figure
nr_exp = 1;
fibertype = 1;
pressure_exp = low_pressure_exp;

while nr_exp <= 9

	load(zcfilename('zsavef/rmds', 'arrays', fibertype, pressure_exp));

	subplot(3, 3, nr_exp);
	
	
	zgbarrmd2(bargraph_rmd, bargraph_rmd_all, fibertype, pressure_exp);
	%zgbarrmd2(bargraph_rmd_wmean, bargraph_rmd_wmean_all, fibertype, pressure_exp);

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




