%1ms sin amplitude 1
 cf = 1e3;

 nrep = 20;
 
% 1 must be able to be divided by f in the space given for a float; 
%16 ok, pas plus
% reptime must be a multiple of tdres
 
% f from 10 to 4000 => reptime from 25e-5 to 0.1
% 1334, 2667 Hz  
frequ = [ 10, 200, 500, 800, 1000, 1250, 2000, 2500, 3125, 4000];

pression_exp = -3;
pression = -6.32 * exp(pression_exp);
cohc = 1;
cihc = 1;
fibertype = 2;
implnt = 0;

test = 1;
if test == 1
	for index=1:1:length(frequ)
		f = frequ(index)
		reptime = 1/f; 
		tdres = 1e-5;
		reptime/tdres
		
		t = 0:(ceil(reptime/tdres)-1); 
		length(t)
		
	end
end

for index=1:1:length(frequ)
	f = frequ(index);
	reptime = 1/f; 
	tdres = 1e-5;

	t = 0:(ceil(reptime/tdres)-1); 
	t = t*tdres;
	 
	x = sin(2*pi*t*f);
	 
	%fm = 100; 
	%m = sin(2*pi*t*fm);
	%M=0;%modulation
	 
	%y = (1+M*m).*x;
	%y = y*pression;
	y = x*pression;
	 
	gentitle = 'pure tone';
	 
	[vihc, synout, psth, synout_noref, psth_noref] = zuusemodel(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt);
end
%semilogx(x, y)
%zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
%zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);