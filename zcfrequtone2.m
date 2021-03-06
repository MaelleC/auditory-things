%45'
%not ok - use zcfrequtone3
cf = 1e4;
nr_use = 10;
tdres = 1e-5;
 
% 1334, 2667 Hz  
%frequs = [ 10, 200, 500, 800, 1000, 1250, 2000, 2500, 3125, 4000]; these are ok, other have glitches

k = [25:100,  103, (100 + 10 * (1: 19)), 320, (50 * (7 : 20))];
lenk = length(k)
%k = 10 * (1 : 100);
reptimes = k * tdres;
frequs = 1. ./ reptimes;
%figure
%plot(frequs, k, '.')

doonlygraph = 1

pressure_exp = -3;
pressure = -6.32 * exp(pressure_exp);
cohc = 1;
cihc = 1;
fibertype = 2;
implnt = 0;

if doonlygraph == 0
	for index=1:1:length(frequs)
		%we go from high frequences to low frequences
	
		index
		knum = k(index)
		
		fm = frequs(index)
			
		nrep = 1000;
		reptime = reptimes(index)
		index

		t = 0:(knum-1); 
		t = t*tdres;
		 
		x = sin(2*pi*t*cf);
		
		m = sin(2*pi*t*fm);
		M=1;%modulation
		 
		y = (1+M*m).*x;
		 
		y = y*pressure;
		
		leny = length(y)
		
		zcfrequ_nexp2(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, knum)
	end
else
	for takeabs=0:1:1
		%takeabs = 0 %%% change that
		
		for calcs=0:1:3
			
			normal = [];
			noref = [];
			normalerr = [];
			noreferr = [];
			
			diverr = [];
			
			for index=1:1:length(frequs)
			
				knum = k(index);
				
				%gives us  'fouriers0', 'fouriers0_noref' 'fouriers1', 'fouriers1_noref', 'fouriers2', 'fouriers2_noref', 'fouriers3', 'fouriers3_noref', 'nrep_nexp'
				load(zcfilename('zsavef/frequ_kmod', num2str(knum), fibertype, pressure_exp) );
				
				if calcs == 0
					normalIt = fouriers0;
					norefIt = fouriers0_noref;
					
					corrStr = ' fourier0';
				elseif calcs == 1
					normalIt = fouriers1;
					norefIt = fouriers1_noref;
					
					corrStr = ' fourier1';
				elseif calcs == 2
					normalIt = fouriers2;
					norefIt = fouriers2_noref;
					
					corrStr = ' fourier2';
				else
					normalIt = fouriers3;
					norefIt = fouriers3_noref;
					
					corrStr = ' fourier3';
				end

				
				if takeabs == 1
				
					normal = [normal mean(abs(normalIt))];
					noref = [noref mean(abs(norefIt))];
					fact = 1/sqrt(length(normalIt));
					normalerr = [normalerr std(abs(normalIt))*fact];
					fact = 1/sqrt(length(norefIt));
					noreferr = [noreferr std(abs(norefIt))*fact];
					
					diverr = [diverr zcerr2(abs(normalIt), abs(norefIt))];
					
					graphf = 'Norm';
				
				else
				
					normal = [normal mean(angle(normalIt))];
					noref = [noref mean(angle(norefIt))];
					fact = 1/sqrt(length(normalIt));
					normalerr = [normalerr std(angle(normalIt))*fact];
					fact = 1/sqrt(length(norefIt));
					noreferr = [noreferr std(angle(norefIt))*fact];
					
					diverr = [diverr zcerr2(angle(normalIt), angle(norefIt))];
					
					graphf = 'Angle';
				
				end
				
				
				
				
			end
		
			
			figure
			errorbar(frequs, normal, normalerr);
			hold on;
			errorbar(frequs, noref, noreferr, 'g');
			hold off;
			title([graphf corrStr])
			legend('normal', 'no ref');
			xlabel('Frequ Hz');
			ylabel([graphf corrStr]);
			
			%if  takeabs == 1  %calcs ~=0 % && takeabs == 1 
			
				figure
				errorbar(frequs, normal ./ noref, diverr);  
				title([graphf corrStr '/' corrStr ' noref'])
				xlabel('Frequ Hz');
				ylabel([graphf corrStr '/' corrStr ' noref']);
				
				figure
				plot(frequs, normal ./ noref)
				title([graphf corrStr '/' corrStr ' noref'])
				xlabel('Frequ Hz');
				ylabel([graphf corrStr '/' corrStr ' noref']);
				
			%end
			
		
		end
	end
end

%gentitle = 'pure tone';
%semilogx(x, y)
%zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
%zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);