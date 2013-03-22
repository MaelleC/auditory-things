 cf = 1e3;
 nrep = 5000;
 tdres = 1/100e3;
 reptime = 0.1;
 %pression = -6.32e-3; %50dB : ok
 pression = -6.32;
 cohc = 1;
 cihc = 1;
 fibertype = 2;
 implnt = 0;
 
 t = 0:(ceil(reptime/tdres) - 1); 
 t = t*tdres;
 
 x = normrnd(0,1 * sqrt(tdres),1, length(t));
 
 %fm = 100;
 %m = sin(2*pi*t*fm);
 m = [ones(1, ceil(reptime/tdres * 0.5)) (-1 * ones(1, ceil(reptime/tdres  * 0.5)))];

 M=1;%modulation
 
 y = (1+M*m).*x;
 y = y*pression;
 
 [vihc, synout, psth, synout_noref, psth_noref] = zusemodel(y,cf,nrep,tdres,reptime, cohc, cihc, fibertype, implnt);
 
 gentitle = 'modnoise';

 vihc = vihc(1: length(synout));
 %save 'zsavef/savenoisestep';
 %save 'zsavef/rmdsavenoisestepf2p0';
 
 zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
 zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);

 %
 %[vihc, synout, psth, synout_noref, psth_noref] = zusemodel(y,cf,nrep,tdres,reptime, cohc, cihc, fibertype, implnt)