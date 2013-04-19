 clear;
 %10e-4 s click, 50db, rarefaction, 10 clicks per s, p21-22
 cf = 1e3; %540
 nrep = 400;
 tdres = 1/100e3;
 reptime = 0.1;
 %pression = -6.32e-3; %50dB : ok
 pression_exp = -3;
 pression = -6.32 * exp(pression_exp);
 cohc = 1;
 cihc = 1;
 fibertype = 2;
 implnt = 0;
 
 clicklen = 1e-4;%in sec


 y = ones(1, round(clicklen/tdres));
 y = pression*y;
 y = [y zeros(1, reptime/tdres - length(y))];
 
  gentitle = 'click';
 
[vihc, synout, psth, synout_noref, psth_noref] = zuusemodel(y,cf,nrep,tdres,reptime, cohc, cihc, fibertype, implnt);

 
 %!! if save, clear before !
 %save 'zsavef/saveclick';
 %save 'zsavef/rmdsaveclickf2p-3';
 
 %save(zcfilename('click', fibertype, pression_exp));
 
 zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
 zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);
 %zgpsthgraph(psth(1 :length(psth)/10), psth_noref(1 :length(psth)/10), reptime/10, nrep, tdres, gentitle);
 
%
%[vihc, synout, psth, synout_noref, psth_noref] = zusemodel(y,cf,nrep,tdres,reptime, cohc, cihc, fibertype, implnt)