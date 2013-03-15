 %10e-4 s click, 50db, rarefaction, 10 clicks per s, p21-22
 cf = 540;
 nrep = 5000;
 tdres = 1/100e3;
 reptime = 0.1;
 %pression = -6.32e-8; %-50dB, but does not work
 pression = -6.32e-3; %50dB : ok
 
 clicklen = 1e-4;%in sec


 y = ones(1, round(clicklen/tdres));
 y = pression*y;
 
[vihc, synout, psth, synout_noref, psth_noref] = zusemodel(y,cf,nrep,tdres,reptime, 1,1 ,2 ,0);


 gentitle = 'click';
 %save 'zsavef/saveclick'
 zfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle)
 
 %save 'zsavef/saveclick' psth psth_noref cf nrep tdres reptime pression gentitle clicklen;
 
 %zpsthgraph(psth(1 :length(psth)/10), psth_noref(1 :length(psth)/10), reptime/10, nrep, tdres, gentitle);
 
%
%[vihc, synout, psth, synout_noref, psth_noref] = zusemodel(y,cf,nrep,tdres,reptime, cohc, cihc, fibertype, implnt)