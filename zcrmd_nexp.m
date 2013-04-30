function [] = zcrmd_nexp(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, exp)

%must be divisible by 10e-5
binpeak = 2/1000;
binbase = 10/1000;

nr_exp = 0;

rmds = [];
rmds_noref = [];
rmds_wmean = [];
rmds_wmean_noref = [];
fouriers0 = [];
fouriers1 = [];
fouriers2 = [];
fouriers3 = [];
fouriers0_noref = [];
fouriers1_noref = [];
fouriers2_noref = [];
fouriers3_noref = [];

max_clicks = [];
max_clicks_noref = [];

while(nr_exp < nr_use)
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
	% gives us 'clickbaseline' and 'clickbaseline_noref' for the corresponding fibertype
	load(zcfilename('zsavef/rmds', 'clickbase', fibertype, 0));
	
	if (strcmp('click', exp) || strcmp('tonestep', exp) || strcmp('noisestep', exp))
		psth2ms = zcconvertbin(tdres, binpeak, psth);
		psth2ms_noref = zcconvertbin(tdres, binpeak, psth_noref);
		
		maxref = max(psth2ms);
		maxnoref = max(psth2ms_noref);
		
		
		if strcmp('click', exp) 
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
	
	
	%fourier
	fouriers0 = [fouriers0 zcfourier(psth, tdres, reptime, 0)];
	fouriers1 = [fouriers1 zcfourier(psth, tdres, reptime, 1)];
	fouriers2 = [fouriers2 zcfourier(psth, tdres, reptime, 2)];
	fouriers3 = [fouriers3 zcfourier(psth, tdres, reptime, 3)];
	fouriers0_noref = [fouriers0_noref zcfourier(psth_noref, tdres, reptime, 0)];
	fouriers1_noref = [fouriers1_noref zcfourier(psth_noref, tdres, reptime, 1)];
	fouriers2_noref = [fouriers2_noref zcfourier(psth_noref, tdres, reptime, 2)];
	fouriers3_noref = [fouriers3_noref zcfourier(psth_noref, tdres, reptime, 3)];

	nr_exp = nr_exp + 1;
	
end

%inutiles
rmd = [mean(rmds), var(rmds), std(rmds)];
rmd_noref = [mean(rmds_noref), var(rmds_noref), std(rmds_noref)];
rmd_wmean = [mean(rmds_wmean), var(rmds_wmean), std(rmds_wmean)];
rmd_wmean_noref = [mean(rmds_wmean_noref), var(rmds_wmean_noref), std(rmds_wmean_noref)];
fourier0 = [mean(fouriers0), var(fouriers0), std(fouriers0)];
fourier1 = [mean(fouriers1), var(fouriers1), std(fouriers1)];
fourier2 = [mean(fouriers2), var(fouriers2), std(fouriers2)];
fourier3 = [mean(fouriers3), var(fouriers3), std(fouriers3)];
fourier0_noref = [mean(fouriers0_noref), var(fouriers0_noref), std(fouriers0_noref)];
fourier1_noref = [mean(fouriers1_noref), var(fouriers1_noref), std(fouriers1_noref)];
fourier2_noref = [mean(fouriers2_noref), var(fouriers2_noref), std(fouriers2_noref)];
fourier3_noref = [mean(fouriers3_noref), var(fouriers3_noref), std(fouriers3_noref)];

save = 1;
if save == 1
	%save the maxima for clicks
	if strcmp('click', exp)
		save(zcfilename('zsavef/rmdsnexp', '_maxclicks', fibertype, pressure_exp), 'max_clicks', 'max_clicks_noref');
	end

	%store rmds and fouriers
	save(zcfilename('zsavef/rmdsnexp', exp, fibertype, pressure_exp), 'rmds', 'rmds_noref', 'rmds_wmean', 'rmds_wmean_noref', 'fouriers0', 'fouriers1', 'fouriers2', 'fouriers3', 'fouriers0_noref', 'fouriers1_noref', 'fouriers2_noref', 'fouriers3_noref');
end




