cf = 1e3;
tdres = 1/100e3;
cohc = 1;
cihc = 1;
implnt = 0;


reptime = 10;
nrep = 1;
y = [0];
y = repmat(y, 1, round(reptime / tdres));
	

nr_exp = 1;
nr_exp_inner = 1;
fibertype = 1;

test = 0;

only_show = 1;

while nr_exp <= 3

	if only_show == 1
		load(zcfilename('zsavef/rmds', 'clickbase', fibertype, 0));
		fibertype
		clickbaseline
		clickbaseline_noref
	else
	fibertype%
	clickbaselines = [];
	clickbaselines_noref = [];

	nr_exp_inner = 1;
	reptime = 10;
	nrep = 1;
	
	while nr_exp_inner < 50 %TODO : make more than 10 repetitions : too high variability now
		[vihc, synout, psth, synout_noref, psth_noref] = zuconcreteuse(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt);
		clickbaselines = [clickbaselines sum(psth)/reptime];
		clickbaselines_noref = [clickbaselines_noref sum(psth_noref)/reptime];
		
		%iteration
		nr_exp_inner = nr_exp_inner + 1;
	end
	clickbaseline = mean(clickbaselines);
	clickbaseline_noref = mean(clickbaselines_noref);
	
	
	if test == 1
		figure
		x = 0 : (round(reptime / tdres) - 1);
		x = x * tdres;	
		subplot(2, 1, 1);
		plot(x, psth);
		title(strcat('psth, fb ', num2str(fibertype)));
		subplot(2, 1, 2);
		plot(x, psth_noref);
		title(strcat('psth_noref, fb ', num2str(fibertype)));
	end
	
	%save what is necessary
	save(zcfilename('zsavef/rmds', 'clickbase', fibertype, 0), 'clickbaseline', 'clickbaseline_noref');
	
	end%only_show
	
	%iteration	
	fibertype = fibertype + 1;
	nr_exp = nr_exp + 1;
	
	
	
end