%1ms sin amplitude 1
 cf = 1e3;
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
		f = frequs(index)
		
		nrep = 1;
		reptime = 1000 * reptimes(index);
		%reptime = reptimes(index);
		%reptime = 1;

		t = 0:(floor(reptime/tdres)-1); 
		t = t*tdres;
		 
		x = sin(2*pi*t*f);
		 
		y = x*pressure;
		
		zcfrequ_nexp(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, knum)
	end
else
	
	for takeabs=0:1:1
		fouriersg = [];
		fouriersg_noref = [];
		fouriersgerr = [];
		fouriersgerr_noref = [];
		for index=1:1:length(frequs)
			knum = k(index);
			%gives us 'fouriers1', 'fouriers1_noref', 'nrep_nexp'
			load(zcfilename('zsavef/frequ_k', num2str(knum), fibertype, pressure_exp) );
			if takeabs == 1
				fouriersg = [fouriersg mean(abs(fouriers1))];
				fouriersg_noref = [fouriersg_noref mean(abs(fouriers1_noref))];
				fouriersgerr = [fouriersgerr std(abs(fouriers1))];
				fouriersgerr_noref = [fouriersgerr_noref std(abs(fouriers1_noref))];
			else
				fouriersg = [fouriersg mean(angle(fouriers1))];
				fouriersg_noref = [fouriersg_noref mean(angle(fouriers1_noref))];
				fouriersgerr = [fouriersgerr std(angle(fouriers1))];
				fouriersgerr_noref = [fouriersgerr_noref std(angle(fouriers1_noref))];
			end
			
			
		end
		
		if takeabs == 1
			graphf = 'Norm';

			
		else
			graphf = 'Angle';
		end
		
		
		
		figure
		errorbar(frequs, fouriersg, fouriersgerr);
		hold on;
		errorbar(frequs, fouriersg_noref, fouriersgerr_noref, 'g');
		hold off;
		title(graphf)
		legend('normal', 'no ref');
		xlabel('Frequ Hz');
		ylabel([graphf ' fourier 1']);
		
		if 0 == 1
		figure
		semilogx(frequs, fouriersg)
		title(graphf)
		xlabel('Frequ Hz');
		ylabel([graphf ' fourier 1 normal']);
		
		figure
		semilogx(frequs, fouriersg_noref)
		title(graphf)
		xlabel('Frequ Hz');
		ylabel([graphf ' fourier 1 noref']);
		end
		
	end
	
end

%gentitle = 'pure tone';
%semilogx(x, y)
%zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
%zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);