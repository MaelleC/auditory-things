function [rmd, rmd_noref, rmd_wmean, rmd_wmean_noref] = zcrmd_nexp(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, exp)

%must be divisible by 10e-5
binpeak = 2/1000;
binbase = 10/1000;

nr_exp = 0;

rmds = [];
rmds_noref = [];
rmds_wmean = [];
rmds_wmean_noref = [];

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
	if (strcmp('click', exp) || strcmp('tonestep', exp) || strcmp('noisestep', exp))
		psth2ms = zcconvertbin(tdres, binpeak, psth);
		psth2ms_noref = zcconvertbin(tdres, binpeak, psth_noref);

		psth10ms = zcconvertbin(tdres, binbase, psth);
		psth10ms_noref = zcconvertbin(tdres, binbase, psth_noref);
		
		if strcmp('click', exp)
			baseref = psth10ms(10);
			basenoref = psth10ms_noref(10);
		else 
			baseref = psth10ms(5);
			basenoref = psth10ms_noref(5);
		end
		
		maxref = max(psth2ms);
		maxnoref = max(psth2ms_noref);
	
		
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

	nr_exp = nr_exp + 1;
end

%TODO : if a experiment have a division by zero, what to show in the mean ? 
%TODO : if some are empty  (or size not max ?) : put -1 -1 and don't show in the 9 graphs ?

rmd = [mean(rmds), var(rmds), std(rmds)];
rmd_noref = [mean(rmds_noref), var(rmds_noref), std(rmds_noref)];
rmd_wmean = [mean(rmds_wmean), var(rmds_wmean), std(rmds_wmean)];
rmd_wmean_noref = [mean(rmds_wmean_noref), var(rmds_wmean_noref), std(rmds_wmean_noref)];


%store rmds
save(zcfilename('zsavef/rmdsnexp', exp, fibertype, pressure_exp), 'rmds', 'rmds_noref', 'rmds_wmean', 'rmds_wmean_noref');





