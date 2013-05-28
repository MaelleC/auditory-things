function [] = zcrmd_nexprmd(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, experiment)

savethings = 1;

%must be divisible by 10e-5
binpeak = 2/1000;
binbase = 10/1000;

domeanrmd = 0;
dormd = 1;
dofourier = 0;

completethings = 0; % !!! change that !!

if completethings == 1

	if strcmp('click', experiment)
		%'max_clicks', 'max_clicks_noref', 'nrep_nexp'
		load(zcfilename('zsavef/rmdsnexp', '_maxclicks', fibertype, pressure_exp));
	end
	
	if strcmp('tonestep', experiment)
		%'max_tonests', 'max_tonests_noref', 'nrep_nexp'
		load(zcfilename('zsavef/rmdsnexp', '_maxtonestep', fibertype, pressure_exp));
	end
		
	%'rmds', 'rmds_noref', 'rmds_wmean', 'rmds_wmean_noref', 'fouriers0', 'fouriers1', 'fouriers2', 'fouriers3', 'fouriers0_noref', 'fouriers1_noref', 'fouriers2_noref', 'fouriers3_noref', 'nrep_nexp'
	load(zcfilename('zsavef/rmdsnexp', experiment, fibertype, pressure_exp));
	
	
	if strcmp('click', experiment) && 1 == 0
		experiment
		fibertype
		pressure_exp
		length(rmds)
	end
	
	if strcmp('tonestep', experiment)  && 1 == 0
		experiment
		fibertype
		pressure_exp
		length(rmds)
	end
	
else

	fouriers0 = [];
	fouriers1 = [];
	fouriers2 = [];
	fouriers3 = [];
	fouriers0_noref = [];
	fouriers1_noref = [];
	fouriers2_noref = [];
	fouriers3_noref = [];
	
	if dofourier == 0
		%'rmds', 'rmds_noref', 'rmds_wmean', 'rmds_wmean_noref', 'fouriers0', 'fouriers1', 'fouriers2', 'fouriers3', 'fouriers0_noref', 'fouriers1_noref', 'fouriers2_noref', 'fouriers3_noref', 'nrep_nexp'
		load(zcfilename('zsavef/rmdsnexp', experiment, fibertype, pressure_exp));
	end

	rmds = [];
	rmds_noref = [];
	rmds_wmean = [];
	rmds_wmean_noref = [];
	
	max_clicks = [];
	max_clicks_noref = [];
	
	max_tonests = [];
	max_tonests_noref =[];
end

%stim = repmat(y, 1, nrep);

for nr_exp=0:1:(nr_use - 1)
	[vihc, synout, psth, synout_noref, psth_noref] = zuusemodel(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt);
	
	% meanrmd
	if domeanrmd == 1
		baserefmean = mean(psth);
		basenorefmean = mean(psth_noref);

		if(baserefmean ~= 0)
			rmds_wmean = [rmds_wmean  ((max(psth) - baserefmean) / baserefmean)];
		end

		if(basenorefmean ~= 0)
			rmds_wmean_noref = [rmds_wmean_noref ((max(psth_noref) - basenorefmean) / basenorefmean)];
		end
	end
	
	
	%normal rmd
	if dormd == 1
		if (strcmp('click', experiment) || strcmp('tonestep', experiment) || strcmp('noisestep', experiment))
			psth2ms = zcconvertbin(tdres, binpeak, psth);
			psth2ms_noref = zcconvertbin(tdres, binpeak, psth_noref);
			
			maxref = max(psth2ms);
			maxnoref = max(psth2ms_noref);
			
			
			if strcmp('click', experiment) 
				% gives us 'clickbaselines', 'clickbaselines_noref' for the corresponding fibertype
				load(zcfilename('zsavef/rmdsbase', experiment, fibertype, 0));
				
				baseref = mean(clickbaselines);
				basenoref = mean(clickbaselines_noref);
				
				max_clicks = [max_clicks maxref];
				max_clicks_noref = [max_clicks_noref maxnoref];
			
			elseif strcmp('tonestep', experiment)

				%'tonestepbaselines', 'tonestepbaselines_noref'
				load(zcfilename('zsavef/rmdsbase', experiment, fibertype, pressure_exp));
					
				baseref = mean(tonestepbaselines);
				basenoref = mean(tonestepbaselines_noref);

				max_tonests = [max_tonests maxref];
				max_tonests_noref = [max_tonests_noref maxnoref];
					
			else
				
				psth10ms = zcconvertbin(tdres, binbase, psth);
				psth10ms_noref = zcconvertbin(tdres, binbase, psth_noref);
			
				baseref = psth10ms(5);
				basenoref = psth10ms_noref(5);		
				
			end
			
		elseif strcmp('tone', experiment) 
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
	
	if dofourier == 1
		%fourier
		fouriers0 = [fouriers0 zcfourier(psth, tdres, reptime, 0)];
		fouriers1 = [fouriers1 zcfourier(psth, tdres, reptime, 1)];
		fouriers2 = [fouriers2 zcfourier(psth, tdres, reptime, 2)];
		fouriers3 = [fouriers3 zcfourier(psth, tdres, reptime, 3)];
		fouriers0_noref = [fouriers0_noref zcfourier(psth_noref, tdres, reptime, 0)];
		fouriers1_noref = [fouriers1_noref zcfourier(psth_noref, tdres, reptime, 1)];
		fouriers2_noref = [fouriers2_noref zcfourier(psth_noref, tdres, reptime, 2)];
		fouriers3_noref = [fouriers3_noref zcfourier(psth_noref, tdres, reptime, 3)];
	end
	
end

nrep_nexp = nrep;

if savethings == 1
	%save the maxima for clicks
	if strcmp('click', experiment)
		save(zcfilename('zsavef/rmdsnexp', '_maxclicks', fibertype, pressure_exp), 'max_clicks', 'max_clicks_noref', 'nrep_nexp');
	end
	
	%save the maxima for tonestep
	if strcmp('tonestep', experiment)
		save(zcfilename('zsavef/rmdsnexp', '_maxtonestep', fibertype, pressure_exp), 'max_tonests', 'max_tonests_noref', 'nrep_nexp');
	end
	
	%store rmds and fouriers
	save(zcfilename('zsavef/rmdsnexp', experiment, fibertype, pressure_exp), 'rmds', 'rmds_noref', 'rmds_wmean', 'rmds_wmean_noref', 'fouriers0', 'fouriers1', 'fouriers2', 'fouriers3', 'fouriers0_noref', 'fouriers1_noref', 'fouriers2_noref', 'fouriers3_noref', 'nrep_nexp');
end