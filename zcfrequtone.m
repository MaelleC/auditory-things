%1ms sin amplitude 1
 cf = 1e3;
 nr_use = 10;
 
% 1 must be able to be divided by f in the space given for a float; 
%16 ok, pas plus
% reptime must be a multiple of tdres
% reptime must correspond to a period
 
% f from 10 to 4000 => reptime from 25e-5 to 0.1
% 1334, 2667 Hz  
%frequs = [ 10, 200, 500, 800, 1000, 1250, 2000, 2500, 3125, 4000]; these are ok, other have glitches

frequs = [  10,  200,  500,  800, 1000, 1250, 1400, 1700, 1800, 2000, 2300, 2500, 2800, 3000, 3125, 3400, 3800, 4000];
nrepti = [ 200, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000,  400, 1000, 1000, 1000, 1000, 1000, 1000, 1000];

%1400,  3500

doonlygraph = 1

pressure_exp = -3;
pressure = -6.32 * exp(pressure_exp);
cohc = 1;
cihc = 1;
fibertype = 2;
implnt = 0;

if doonlygraph == 0
	for index=1:1:length(frequs)

		%index = 10
		f = frequs(index)
		nrep = nrepti(index)
		reptime = 1/f; 
		tdres = 1e-5;

		t = 0:(ceil(reptime/tdres)-1); 
		t = t*tdres;
		 
		x = sin(2*pi*t*f);
		
		reptime = length(t) * tdres;
		 
		y = x*pressure;
		 
		zcfrequ_nexp(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, f)
	end
else

	for takeabs=0:1:1
		fouriersg = [];
		fouriersg_noref = [];
		fouriersgerr = [];
		fouriersgerr_noref = [];
		for index=1:1:length(frequs)
		
			%gives us 'fouriers1', 'fouriers1_noref', 'nrep_nexp'
			load(zcfilename('zsavef/frequ_', num2str(frequs(index)), fibertype, pressure_exp) );
			if takeabs == 1
				fouriersg = [fouriersg mean(abs(fouriers1))];
				fouriersg_noref = [fouriersg_noref mean(abs(fouriers1_noref))];
				fouriersgerr = [fouriersgerr var(abs(fouriers1))];
				fouriersgerr_noref = [fouriersgerr_noref var(abs(fouriers1_noref))];
			else
				fouriersg = [fouriersg mean(angle(fouriers1))];
				fouriersg_noref = [fouriersg_noref mean(angle(fouriers1_noref))];
				fouriersgerr = [fouriersgerr var(angle(fouriers1))];
				fouriersgerr_noref = [fouriersgerr_noref var(angle(fouriers1_noref))];
			end
			
			
		end
		figure
		errorbar(frequs, fouriersg, fouriersgerr);
		hold on;
		errorbar(frequs, fouriersg_noref, fouriersgerr_noref, 'g');
		hold off;
		if takeabs == 1
			title('Norm')
		else
			title('Angle')
		end
		legend('normal', 'no ref');
		xlabel('Frequ Hz');
		ylabel('Abs(fourier 1)');
	end
	
end

%gentitle = 'pure tone';
%semilogx(x, y)
%zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
%zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);