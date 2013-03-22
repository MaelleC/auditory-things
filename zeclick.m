 %10e-4 s click, 50db, rarefaction, 10 clicks per s, p21-22
 cf = 540;
 nrep = 500;
 tdres = 1/100e3;
 reptime = 0.1;
 pression = -6.32e-3; %50dB : ok
 cohc = 1;
 cihc = 1;
 fibertype = 2;
 implnt = 0;
 
 clicklen = 1e-4;%in sec


 y = ones(1, round(clicklen/tdres));
 y = pression*y;
 
[vihc, synout, psth, synout_noref, psth_noref] = zusemodel(y,cf,nrep,tdres,reptime, cohc, cihc, fibertype, implnt);


 gentitle = 'click';
 
 vihc = vihc(1: length(synout));
 %save 'zsavef/saveclick';
 %save 'zsavef/rmdsaveclick';
 
 zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
 zgpsthgraph(psth(1 :length(psth)/10), psth_noref(1 :length(psth)/10), reptime/10, nrep, tdres, gentitle);
 
%
%[vihc, synout, psth, synout_noref, psth_noref] = zusemodel(y,cf,nrep,tdres,reptime, cohc, cihc, fibertype, implnt)