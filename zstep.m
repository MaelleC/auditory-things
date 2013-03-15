 %step, best effect with fibertype = 3
 cf = 1e3;
 fc = 1e4;
 nrep = 500;
 tdres = 1/100e3;
 reptime = 0.1;
 %pression = -6.32e-3; %50dB : ok
 pression = 6.32e2; %50dB : ok
 
 
 t = 0:(ceil(reptime/tdres) - 1); 
 t = t*tdres;
 
 x = sin(2*pi*t*fc);
 
 %fm = 100;
 %m = sin(2*pi*t*fm);
 m = [ones(1, ceil(reptime/tdres * 0.5)) (-1 * ones(1, ceil(reptime/tdres  * 0.5)))];

 M=1;%modulation
 
 y = (1+M*m).*x;
 y = y*pression;
 
 [vihc, synout, psth, synout_noref, psth_noref] = zusemodel(y,cf,nrep,tdres,reptime, 1, 1 ,3,0);
 
 gentitle = 'step';
 zfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
 
 %save 'zsavef/savestep'
 
 %save 'zsavef/savestep' psth psth_noref cf nrep tdres reptime pression gentitle;
 zpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle)

 %
 %[vihc, synout, psth, synout_noref, psth_noref] = zusemodel(y,cf,nrep,tdres,reptime, cohc, cihc, fibertype, implnt)