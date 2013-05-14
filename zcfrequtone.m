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

doonlygraph = 0

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
		
		%nrep = 1;
		nrep = 1000;
		
		%reptime = 1000 * reptimes(index);
		reptime = reptimes(index)

		t = 0:(knum-1); 
		t = t*tdres;
		 
		x = sin(2*pi*t*f);
		 
		y = x*pressure;
		
		leny = length(y)
		
		zcfrequ_nexp(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt, nr_use, pressure_exp, knum)
	end
else
	
	%for takeabs=0:1:1
		takeabs = 1 %%% change that
	
		fouriers1g = [];
		fouriers1g_noref = [];
		fouriers1gerr = [];
		fouriers1gerr_noref = [];
		
		fouriers2g = [];
		fouriers2g_noref = [];
		fouriers2gerr = [];
		fouriers2gerr_noref = [];
		
		fouriers3g = [];
		fouriers3g_noref = [];
		fouriers3gerr = [];
		fouriers3gerr_noref = [];
		
		for index=1:1:length(frequs)
			knum = k(index);
			%gives us 'fouriers1', 'fouriers1_noref', 'fouriers2', 'fouriers2_noref', 'fouriers3', 'fouriers3_noref', 'nrep_nexp'
			load(zcfilename('zsavef/frequ_k', num2str(knum), fibertype, pressure_exp) );
			if takeabs == 1
				
				fouriers1g = [fouriers1g mean(abs(fouriers1))];
				fouriers1g_noref = [fouriers1g_noref mean(abs(fouriers1_noref))];
				fact = 1/sqrt(length(fouriers1));
				fouriers1gerr = [fouriers1gerr std(abs(fouriers1))*fact];
				fact = 1/sqrt(length(fouriers1_noref));
				fouriers1gerr_noref = [fouriers1gerr_noref std(abs(fouriers1_noref))*fact];
				
				if 1 == 0 % put that away when 2, 3 ok
				fouriers2g = [fouriers2g mean(abs(fouriers2))];
				fouriers2g_noref = [fouriers2g_noref mean(abs(fouriers2_noref))];
				fact = 1/sqrt(length(fouriers2));
				fouriers2gerr = [fouriers2gerr std(abs(fouriers2))*fact];
				fact = 1/sqrt(length(fouriers2_noref));
				fouriers2gerr_noref = [fouriers2gerr_noref std(abs(fouriers2_noref))*fact];
				
				fouriers3g = [fouriers3g mean(abs(fouriers3))];
				fouriers3g_noref = [fouriers3g_noref mean(abs(fouriers3_noref))];
				fact = 1/sqrt(length(fouriers3));
				fouriers3gerr = [fouriers3gerr std(abs(fouriers3))*fact];
				fact = 1/sqrt(length(fouriers3_noref));
				fouriers3gerr_noref = [fouriers3gerr_noref std(abs(fouriers3_noref))*fact];
				end
				
			else
				fouriers1g = [fouriers1g mean(angle(fouriers1))];
				fouriers1g_noref = [fourier1sg_noref mean(angle(fouriers1_noref))];
				fact = 1/sqrt(length(fouriers1));
				fouriers1gerr = [fouriers1gerr std(angle(fouriers1))*fact];
				fact = 1/sqrt(length(fouriers1_noref));
				fouriers1gerr_noref = [fouriers1gerr_noref std(angle(fouriers1_noref))*fact];
				
				fouriers2g = [fouriers2g mean(angle(fouriers2))];
				fouriers2g_noref = [fouriers2g_noref mean(angle(fouriers2_noref))];
				fact = 1/sqrt(length(fouriers2));
				fouriers2gerr = [fouriers2gerr std(angle(fouriers2))*fact];
				fact = 1/sqrt(length(fouriers2_noref));
				fouriers2gerr_noref = [fouriers2gerr_noref std(angle(fouriers2_noref))*fact];
				
				fouriers3g = [fouriers3g mean(angle(fouriers3))];
				fouriers3g_noref = [fouriers3g_noref mean(angle(fouriers3_noref))];
				fact = 1/sqrt(length(fouriers3));
				fouriers3gerr = [fouriers3gerr std(angle(fouriers3))*fact];
				fact = 1/sqrt(length(fouriers3_noref));
				fouriers3gerr_noref = [fouriers3gerr_noref std(angle(fouriers3_noref))*fact];
			end
			
			
		end
		
		if takeabs == 1
			graphf = 'Norm ';	
		else
			graphf = 'Angle ';
		end
		
		
		%fouriers1
		figure
		errorbar(frequs, fouriers1g, fouriers1gerr);
		hold on;
		errorbar(frequs, fouriers1g_noref, fouriers1gerr_noref, 'g');
		hold off;
		title([graphf 'fourier1'])
		legend('normal', 'no ref');
		xlabel('Frequ Hz');
		ylabel([graphf ' fourier 1']);
		
		if 1 == 0
		%fouriers2
		figure
		errorbar(frequs, fouriers2g, fouriers2gerr);
		hold on;
		errorbar(frequs, fouriers2g_noref, fouriers2gerr_noref, 'g');
		hold off;
		title([graphf 'fourier2'])
		legend('normal', 'no ref');
		xlabel('Frequ Hz');
		ylabel([graphf ' fourier 2']);
		
		%fouriers3
		figure
		errorbar(frequs, fouriers3g, fouriers3gerr);
		hold on;
		errorbar(frequs, fouriers3g_noref, fouriers3gerr_noref, 'g');
		hold off;
		title([graphf 'fourier3'])
		legend('normal', 'no ref');
		xlabel('Frequ Hz');
		ylabel([graphf ' fourier 3']);
		end
		
		if takeabs == 1
			figure
			errorbar(frequs, fouriers1g ./ fouriers1g_noref, fouriers1gerr);  
			title([graphf 'fourier1 / fourier1 noref'])
			xlabel('Frequ Hz');
			ylabel([graphf ' fourier 1 / fourier1 noref']);
			
			if 1 == 0 % put that away when 2, 3 ok
			figure
			errorbar(frequs, fouriers2g ./ fouriers2g_noref, fouriers2gerr);  
			title([graphf 'fourier2 / fourier2 noref'])
			xlabel('Frequ Hz');
			ylabel([graphf ' fourier 2 / fourier 2 noref']);
			
			figure
			errorbar(frequs, fouriers3g ./ fouriers3g_noref, fouriers3gerr);  
			title([graphf 'fourier3 / fourier3 noref'])
			xlabel('Frequ Hz');
			ylabel([graphf ' fourier 3 / fourier3 noref']);
			end
		end
		
	%end
	
end

%gentitle = 'pure tone';
%semilogx(x, y)
%zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
%zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);