clear;
%1ms sin amplitude 1
 cf = 1e3;
 
 f = 1e3;
 %f = 700;
 
 nrep = 10000; %10000 ok
 %nrep = 1;
 
 tdres = 1/100e3;
 
 reptime = 0.001;
 %reptime = 1;
 
 %pression = -6.32e-3; %50dB : ok
 pression_exp = -3;
 pression = -6.32 * exp(pression_exp);
 cohc = 1;
 cihc = 1;
 fibertype = 2;
 implnt = 0;

 t = 0:(round(reptime/tdres)-1); 
 t = t*tdres;
 
 x = sin(2*pi*t*f);
 
 fm = 100; 
 m = sin(2*pi*t*fm);
 M=0;%modulation
 
 y = (1+M*m).*x;
 y = y*pression;
 
 
 gentitle = 'pure tone';
 
 %[vihc, synout, psth, synout_noref, psth_noref] = zuconcreteuse(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt);
 
 [vihc, synout, psth, synout_noref, psth_noref] = zuusemodel(y, cf, nrep, tdres, reptime, cohc, cihc, fibertype, implnt);

 
  %!! if save, clear before !
 %save 'zsavef/savetone';
 %save 'zsavef/rmdsavetonef2p-3';
 
 %save(zcfilename('zsavef/rmdsave', 'tone', fibertype, pression_exp));
 
 zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
 zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);
 
 zgstim_psth(y, psth, psth_noref, reptime, nrep, tdres, gentitle)

 %
 %[vihc, synout, psth, synout_noref, psth_noref] = zusemodel(y,cf,nrep,tdres,reptime, cohc, cihc, fibertype, implnt)