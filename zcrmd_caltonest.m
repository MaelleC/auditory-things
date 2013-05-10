experiment = 'tonestep';

low_pressure_exp = -3; %50db
middle_pressure_exp = -1; %90db
high_pressure_exp = 1; %130db

fibertype = 1;
pressure_exp = low_pressure_exp;

for nr_exp=1:1:9

	% gives 'rmds', 'rmds_noref', 'rmds_wmean', 'rmds_wmean_noref', 
	%'fouriers0', 'fouriers1', 'fouriers2', 'fouriers3', 
	%'fouriers0_noref', 'fouriers1_noref', 'fouriers2_noref', 'fouriers3_noref'
	% we will update 'rmds' and 'rmds_noref' with new baseline values
	load(zcfilename('zsavef/rmdsnexp', experiment, fibertype, pressure_exp));
	
	% gives 'tonestepbaselines', 'tonestepbaselines_noref'
	load(zcfilename('zsavef/rmdsbase', experiment, fibertype, pressure_exp));
	
	% gives 'max_tonests', 'max_tonests_noref', 'nrep_nexp'
	load(zcfilename('zsavef/rmdsnexp', '_maxtonestep', fibertype, pressure_exp));
	
	rmds = [];
	rmds_noref = [];
	
	tonestepbaseline = mean(tonestepbaselines);
	for elem=1:1:length(max_tonests)
		rmds = [rmds ((max_tonests(elem) - tonestepbaseline) / tonestepbaseline)];	
	end
	
	tonestepbaseline_noref = mean(tonestepbaselines_noref);
	for elem=1:1:length(max_tonests_noref)
		rmds_noref = [rmds_noref ((max_tonests_noref(elem) - tonestepbaseline_noref) / tonestepbaseline_noref)];
	end
	
	
	%store back rmds and fouriers
	save(zcfilename('zsavef/rmdsnexp', experiment, fibertype, pressure_exp), 'rmds', 'rmds_noref', 'rmds_wmean', 'rmds_wmean_noref', 'fouriers0', 'fouriers1', 'fouriers2', 'fouriers3', 'fouriers0_noref', 'fouriers1_noref', 'fouriers2_noref', 'fouriers3_noref');
	
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