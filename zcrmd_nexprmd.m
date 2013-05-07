function [] = zcrmd_nexprmd(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, exp)

savethings = 1;

%must be divisible by 10e-5
binpeak = 2/1000;
binbase = 10/1000;


if strcmp('click', exp)
	%'max_clicks', 'max_clicks_noref', 'nrep_nexp'
	load(zcfilename('zsavef/rmdsnexp', '_maxclicks', fibertype, pressure_exp));
end
	
%, 'rmds', 'rmds_noref', 'rmds_wmean', 'rmds_wmean_noref', 'fouriers0', 'fouriers1', 'fouriers2', 'fouriers3', 'fouriers0_noref', 'fouriers1_noref', 'fouriers2_noref', 'fouriers3_noref', 'nrep_nexp'
load(zcfilename('zsavef/rmdsnexp', exp, fibertype, pressure_exp));

for nr_exp=0:1:(nr_use - 1)
	[vihc, synout, psth, synout_noref, psth_noref] = zuusemodel(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt);
		
	% meanrmd
	baserefmean = mean(psth);
	basenorefmean = mean(psth_noref);

	if(baserefmean ~= 0)
		rmds_wmean = [rmds_wmean  ((max(psth) - baserefmean) / baserefmean)];
	end

	if(basenorefmean ~= 0)
		rmds_wmean_noref = [rmds_wmean_noref ((max(psth_noref) - basenorefmean) / basenorefmean)];
	end
	
	
	%normal rmd
	psth2ms = zcconvertbin(tdres, binpeak, psth);
	psth2ms_noref = zcconvertbin(tdres, binpeak, psth_noref);
	
	if (strcmp('click', exp) || strcmp('tonestep', exp) || strcmp('noisestep', exp))
		psth2ms = zcconvertbin(tdres, binpeak, psth);
		psth2ms_noref = zcconvertbin(tdres, binpeak, psth_noref);
		
		maxref = max(psth2ms);
		maxnoref = max(psth2ms_noref);
		
		
		if strcmp('click', exp) 
			% gives us 'clickbaseline' and 'clickbaseline_noref' for the corresponding fibertype
			load(zcfilename('zsavef/rmds', 'clickbase', fibertype, 0));
			
			baseref = clickbaseline;
			basenoref = clickbaseline_noref;
			
			max_clicks = [max_clicks maxref];
			max_clicks_noref = [max_clicks_noref maxnoref];
		else
			psth10ms = zcconvertbin(tdres, binbase, psth);
			psth10ms_noref = zcconvertbin(tdres, binbase, psth_noref);
		
			baseref = psth10ms(5);
			basenoref = psth10ms_noref(5);	
		end
		
	elseif strcmp('tone', exp) 
		baseref = mean(psth);
		basenoref = mean(psth_noref);
		maxref = max(psth);
		maxnoref = max(psth_noref);
	else
		error('Invalid experiment : put click, tonestep, noisestep or tone');
	end
	if(baseref ~= 0)
		rmds = [rmds  ((maxref - baseref) / baseref)];
	end

	if(basenoref ~= 0)
		rmds_noref = [rmds_noref ((maxnoref - basenoref) / basenoref)];
	end

	
end

nrep_nexp  = nrep;

if savethings == 1
	%save the maxima for clicks
	if strcmp('click', exp)
		save(zcfilename('zsavef/rmdsnexp', '_maxclicks', fibertype, pressure_exp), 'max_clicks', 'max_clicks_noref', 'nrep_nexp');
	end

	%store rmds and fouriers
	save(zcfilename('zsavef/rmdsnexp', exp, fibertype, pressure_exp), 'rmds', 'rmds_noref', 'rmds_wmean', 'rmds_wmean_noref', 'fouriers0', 'fouriers1', 'fouriers2', 'fouriers3', 'fouriers0_noref', 'fouriers1_noref', 'fouriers2_noref', 'fouriers3_noref', 'nrep_nexp');
end