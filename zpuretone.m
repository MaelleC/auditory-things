%1ms sin amplitude 1, fm: 100Hz, f = 1e3Hz
 cf = 1e3;
 nrep = 1000;
 tdres = 1/100e3;
 reptime = 0.01;
 pression = -6.32e-3; %50dB : ok
 
 
 t = 0:(reptime/tdres-1); 
 t = t*tdres;
 
 x = sin(2*pi*t*cf);
 
 fm = 100;
 m = sin(2*pi*t*fm);
 M=0;%modulation
 
 y = (1+M*m).*x;
 y = y*pression;
 
 [vihc, synout, psth, synout_noref, psth_noref] = zusemodel(y,cf,nrep,tdres,reptime, 1,1 ,2 ,0);
 
 gentitle = 'pure tone';
 %zfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
 
 %save 'zsavef/savetone'
 
 %save 'zsavef/savetone' psth psth_noref cf nrep tdres reptime pression gentitle;
 zpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);

 %
 %[vihc, synout, psth, synout_noref, psth_noref] = zusemodel(y,cf,nrep,tdres,reptime, cohc, cihc, fibertype, implnt)