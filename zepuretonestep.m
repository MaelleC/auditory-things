%step, best effect with fibertype = 3
 cf = 1e3;
 fc = 1e4;
 nrep = 500;
 tdres = 1/100e3;
 reptime = 0.1;
 %pression = -6.32e-3; %50dB : ok
 pression = 6.32e2; 
 cohc = 1;
 cihc = 1;
 fibertype = 3;
 implnt = 0;
 
 
 t = 0:(ceil(reptime/tdres) - 1); 
 t = t*tdres;
 
 x = sin(2*pi*t*fc);
 
 %fm = 100;
 %m = sin(2*pi*t*fm);
 m = [ones(1, ceil(reptime/tdres * 0.5)) (-1 * ones(1, ceil(reptime/tdres  * 0.5)))];

 M=1;%modulation
 
 y = (1+M*m).*x;
 y = y*pression;
 
 [vihc, synout, psth, synout_noref, psth_noref] = zusemodel(y,cf,nrep,tdres,reptime, cohc, cihc, fibertype, implnt);
 
 gentitle = 'pure tone step';
 
 %vihc = vihc(1: length(synout));
 %save 'zsavef/savepuretonestep'
 
 zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
 %zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle)

 %
 %[vihc, synout, psth, synout_noref, psth_noref] = zusemodel(y,cf,nrep,tdres,reptime, cohc, cihc, fibertype, implnt)