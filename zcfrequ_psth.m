carrierfrequ = 1e4;
cf = 1e3;

%if 10 : 35'
nr_use = 10;
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
		for takeAbs=0:1:1
			for calc=0:1:3
			
				normal = [];
				noref = [];
				
				for index=1:1:length(frequs)
					frequ = frequs(index)
					
					filename = 'zsavef/frequ_psth';
					%gives us  'bpsth', 'bpsth_noref' 'repstot'
					load(zcfilename(filename, num2str(frequ), fibertype, pressure_exp));
					
					%%% Q : normalize psth ? (/nrep)
					
					freptime = round(length(bpsth)*tdres);
					
					fourier = zcfourier(bpsth, tdres, freptime, calc);
					fourier_noref = zcfourier(bpsth_noref, tdres, freptime, calc);
					
					if takeAbs == 1
						normal = [ normal abs(fourier)];
						noref = [ noref abs(fourier_noref)];
						
						graphf = 'Norm';
					else
						normal = [ normal angle(fourier)];
						noref = [ noref angle(fourier_noref)];
						
						graphf = 'Angle';
					end
					
				end
				corrStr = [' fourier ' num2str(calc)];
				
				figure
				plot(frequs, normal, 'b', frequs, noref, 'g');
				title([graphf corrStr])
				legend('normal', 'no ref');
				xlabel('Frequ Hz');
				ylabel([graphf corrStr]);
					
				figure
				plot(frequs, normal ./ noref);
				title([graphf corrStr '/' corrStr ' noref'])
				xlabel('Frequ Hz');
				ylabel([graphf corrStr '/' corrStr ' noref']);
				
			end	
		
		end
		repstot
	
	else
		for index=10:10:length(frequs)
			frequ = frequs(index)
					
			filename = 'zsavef/frequ_psth';
			%gives us  'bpsth', 'bpsth_noref' 'repstot'
			load(zcfilename(filename, num2str(frequ), fibertype, pressure_exp));
			
			
			gentitle = ['pure tone ' num2str(frequ)];
			
			zgpsthgraph(bpsth, bpsth_noref, (reptime - 1), repstot, tdres, gentitle);
		end
		repstot
	end		
end