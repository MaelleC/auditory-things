%1ms sin amplitude 1, fm: 100Hz, f = 1e3Hz
 cf = 1e3;
 f = cf;
 nrep = 1000;
 tdres = 1/100e3;
 reptime = 0.01;
 pression = -6.32e-3; %50dB : ok
 cohc = 1;
 cihc = 1;
 fibertype = 2;
 implnt = 0;

 t = 0:(reptime/tdres-1); 
 t = t*tdres;
 
 x = sin(2*pi*t*f);
 
 fm = 100; 
 m = sin(2*pi*t*fm);
 M=0;%modulation
 
 y = (1+M*m).*x;
 y = y*pression;
 
 [vihc, synout, psth, synout_noref, psth_noref] = zusemodel(y,cf,nrep,tdres,reptime, cohc, cihc, fibertype, implnt);
 
 gentitle = 'pure tone';
 %vihc = vihc(1: length(synout));
 %save 'zsavef/savetone'
 
 zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
 %zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);

 %
 %[vihc, synout, psth, synout_noref, psth_noref] = zusemodel(y,cf,nrep,tdres,reptime, cohc, cihc, fibertype, implnt)