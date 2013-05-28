carrierfrequ = 1e4;
cf = 1e3;
nr_use = 1;
tdres = 1e-5;
 
% 1334, 2667 Hz  
%frequs = [ 10, 200, 500, 800, 1000, 1250, 2000, 2500, 3125, 4000]; these are ok, other have glitches

frequs = [50 *(1 : 80)];

doonlygraph = 0
fouriergraph = 0

pressure_exp = -7;
pressure = -6.32 * exp(pressure_exp);
cohc = 1;
cihc = 1;
fibertype = 2; 
implnt = 0;

nrep = 1; % must be one, since we use zuconcreteuse
reptime = 2;

if doonlygraph == 0
	for index=1:1:length(frequs) %not draw everything
	
		index
		
		fm = frequs(index)
		
		index

		t = 0:(round(reptime/tdres)-1); 
		t = t*tdres;
		 
		x = sin(2*pi*t*carrierfrequ);
		
		m = sin(2*pi*t*fm);
		M=1;%modulation
		 
		y = (1+M*m).*x;
		 
		y = y*pressure;
		
		if rem(index, 10) == 0 && 1== 0
		figure
		plot(y);
		end
		
		zcfrequ_psth_nrep(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, fm);
	end
else
	if fouriergraph == 1
		
	
	else
		for index=10:10:length(frequs)
			frequ = frequs(index)
					
			filename = 'zsavef/frequ_psth'
			%gives us  'bpsth', 'bpsth_noref' 'repstot'
			load(zcfilename(filename, num2str(frequ), fibertype, pressure_exp));
			gentitle = ['pure tone ' num2str(frequ)];
			
			zgpsthgraph(bpsth, bpsth_noref, (reptime - 1), repstot, tdres, gentitle);
		end
		
	end		
end