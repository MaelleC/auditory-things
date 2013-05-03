function [] = zcrmd_nexp(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, exp)

savethings = 1;

%must be divisible by 10e-5
binpeak = 2/1000;
binbase = 10/1000;

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
	% gives us 'clickbaseline' and 'clickbaseline_noref' for the corresponding fibertype
	load(zcfilename('zsavef/rmds', 'clickbase', fibertype, 0));
	
	psth2ms = zcconvertbin(tdres, binpeak, psth);
	psth2ms_noref = zcconvertbin(tdres, binpeak, psth_noref);
	
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
		onermd = ((maxref - baseref) / baseref);
		
		if onermd < 0
			onermd
			((maxref - baseref) / baseref)
			maxref
			baseref
			gentitle = 'click'
			%zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
			%zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);
			%zgpsthgraph(psth2ms, psth2ms_noref, reptime, nrep, tdres, strcat(gentitle, ' 2ms bins'));
		end
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

	
end

nrep_nexp  = nrep;

if savethings == 0
	%save the maxima for clicks
	if strcmp('click', exp)
		save(zcfilename('zsavef/rmdsnexp', '_maxclicks', fibertype, pressure_exp), 'max_clicks', 'max_clicks_noref', 'nrep_nexp');
	end

	%store rmds and fouriers
	save(zcfilename('zsavef/rmdsnexp', exp, fibertype, pressure_exp), 'rmds', 'rmds_noref', 'rmds_wmean', 'rmds_wmean_noref', 'fouriers0', 'fouriers1', 'fouriers2', 'fouriers3', 'fouriers0_noref', 'fouriers1_noref', 'fouriers2_noref', 'fouriers3_noref', 'nrep_nexp');
end




