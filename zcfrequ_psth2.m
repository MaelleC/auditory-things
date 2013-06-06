carrierfrequ = 1e4;
cf = 5 * 1e3;

%if 10 : 35'
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
fibertype = 3; 
implnt = 0;

nrep = 200; %50 : 20', 100: 36' if all frequencies ; 60 :: 200 : 51 ' % !!!!!!
reptime = 2;

endfrequ = 60; %

if doonlygraph == 0
	for index=1:1:endfrequ
	
		index
		
		fm = frequs(index)

		t = 0:(round(reptime/tdres)-1); 
		t = t*tdres;
		 
		x = sin(2*pi*t*carrierfrequ);
		
		m = sin(2*pi*t*fm);
		M=0.5;%modulation
		 
		y = (1+M*m).*x;
		 
		y = y*pressure;
		
		if rem(index, 10) == 0 && 1== 0
		figure
		plot(y);
		end
		
		zcfrequ_psth_nrep2(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, fm);
	end
else
	ifprint = 0
	if ifprint == 1
		style1 = 'k';
		style2 = 'g';
	else
		style1 = 'b';
		style2 = 'g';
	end
	
	if fouriergraph == 1
		for takeAbs=0:1:1
			for calc=0:1:3
			
				normal = [];
				noref = [];
				
				for index=1:1:endfrequ
					frequ = frequs(index);
					
					filename = 'zsavef/frequ_psth2';
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
				plot(frequs(1 : endfrequ), normal, style1, frequs(1: endfrequ), noref, style2);
				title([graphf corrStr])
				legend('normal', 'no ref');
				xlabel('Frequ Hz');
				ylabel([graphf corrStr]);
					
				figure
				plot(frequs(1: endfrequ), normal ./ noref, style1);
				title([graphf corrStr '/' corrStr ' noref'])
				xlabel('Modulation frequency (Hz)');
				ylabel([graphf corrStr '/' corrStr ' noref']);
				
			end	
		
		end
		repstot
	
	else
		for index=10:10:endfrequ
			frequ = frequs(index)
					
			filename = 'zsavef/frequ_psth2';
			%gives us  'bpsth', 'bpsth_noref' 'repstot'
			load(zcfilename(filename, num2str(frequ), fibertype, pressure_exp));
			
			
			gentitle = ['pure tone ' num2str(frequ)];
			
			zgpsthgraph(bpsth, bpsth_noref, (reptime - 1), repstot, tdres, gentitle);
		end
		repstot
	end		
end