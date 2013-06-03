low_pressure_exp = -7; %49db
middle_pressure_exp = -3; %84db
high_pressure_exp = 1; %120db

%low_pressure_exp = -3; %84db
%middle_pressure_exp = -1; %100db
%high_pressure_exp = 1; %120db

figure
fibertype = 1;
pressure_exp = low_pressure_exp;

scfacts = [10,30,80, 5,10,20, 1,4,4];

for nr_exp=1:1:9
	if nr_exp == 3
		showLeg = 1;
	else
		showLeg = 0;
	end
	

	%valuevars, and noref = [rmd1, var1; rmd2, var2; rmd3, var3; rmd4, var4]
	valuevars = [];
	valuevars_noref = [];
	
	thescfact = scfacts(nr_exp);
	
	for ndiff_exp=1:1:4
		if ndiff_exp == 1
			experiment = 'click';
		elseif ndiff_exp == 2
			experiment = 'tonestep';
		elseif ndiff_exp == 3
			experiment = 'noisestep';
		else
			experiment = 'tone';
		end
		
		%gives 'rmds', 'rmds_noref', 'rmds_wmean', 'rmds_wmean_noref', 'fouriers0', 'fouriers1', 'fouriers2', 'fouriers3', 'fouriers0_noref', 'fouriers1_noref', 'fouriers2_noref', 'fouriers3_noref', 'nrep_nexp'
		load(zcfilename('zsavef/rmdsnexp', experiment, fibertype, pressure_exp));
		
		experiment
		fibertype
		pressure_exp
		lenrmd = length(rmds)
		
		%% scaling for beautyful graph
		if strcmp('tonestep', experiment) || strcmp('click', experiment)
			scfact = thescfact;
		else
			scfact = 1;
		end
			
		if strcmp('click', experiment) || strcmp('tonestep', experiment)
		
			if strcmp('click', experiment)
				% gives 'max_clicks' and 'max_clicks_noref'
				load(zcfilename('zsavef/rmdsnexp', '_maxclicks', fibertype, pressure_exp));
				
				% gives 'clickbaselines' and 'clickbaselines_noref'
				load(zcfilename('zsavef/rmdsbase', experiment, fibertype, 0));
				
				theMax = max_clicks;
				baseline = clickbaselines;
				
				theMax_noref = max_clicks_noref;
				baseline_noref = clickbaselines_noref;
			else
			
				%'max_tonests', 'max_tonests_noref', 'nrep_nexp'
				load(zcfilename('zsavef/rmdsnexp', '_maxtonestep', fibertype, pressure_exp));
				
				%'tonestepbaselines', 'tonestepbaselines_noref'
				load(zcfilename('zsavef/rmdsbase', experiment, fibertype, pressure_exp));
				
				theMax = max_tonests;
				baseline = tonestepbaselines;
				
				theMax_noref = max_tonests_noref;
				baseline_noref = tonestepbaselines_noref;
			
			end
			
			rmd = mean(theMax)/ mean(baseline) - 1;
			rmd_noref = mean(theMax_noref)/ mean(baseline_noref) - 1;
			
			valuevars = [ valuevars; rmd/scfact zcerr2(theMax, baseline)/scfact];
			valuevars_noref = [ valuevars_noref; rmd_noref/scfact zcerr2(theMax_noref, baseline_noref)/scfact];
		
		else
			stdnormal = zcstdofmean(rmds);
			stdnoref = zcstdofmean(rmds_noref);
			
			valuevars = [ valuevars; mean(rmds)/scfact stdnormal/scfact];
			valuevars_noref = [ valuevars_noref; mean(rmds_noref)/scfact stdnoref/scfact];
			
		end	
	end
	
	
	subplot(3, 3, nr_exp);
	zgbarrmd2(valuevars, valuevars_noref, fibertype, pressure_exp, 0, thescfact, showLeg);

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




