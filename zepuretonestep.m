clear;
%step, best effect with fibertype = 3
 cf = 1e3;
 fc = 1e4;
 nrep = 800; %800 ok
 tdres = 1/100e3;
 reptime = 0.1;
 %pression = -6.32e-3; %50dB : ok
 pression_exp = 1;
 pression = -6.32 * exp(pression_exp);
 cohc = 1;
 cihc = 1;
 fibertype = 1;
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
 
  gentitle = 'pure tone step';
 
 [vihc, synout, psth, synout_noref, psth_noref] = zuusemodel(y,cf,nrep,tdres,reptime, cohc, cihc, fibertype, implnt);
 

 
 
  %!! if save, clear before !
 %save 'zsavef/savetonestep';
 %save 'zsavef/rmdsavetonestepf2p-3';
 
 %save(zcfilename('zsavef/rmdsave', 'tonestep', fibertype, pression_exp));
 
 zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
 zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);
 
 
 binpeak = 2/1000;
binbase = 10/1000;

 psth2ms = zcconvertbin(tdres, binpeak, psth);
psth2ms_noref = zcconvertbin(tdres, binpeak, psth_noref);

psth10ms = zcconvertbin(tdres, binbase, psth);
psth10ms_noref = zcconvertbin(tdres, binbase, psth_noref);

zgpsthgraph(psth2ms, psth2ms_noref, reptime, nrep, tdres, strcat(gentitle, ' 2ms bins'));
zgpsthgraph(psth10ms, psth10ms_noref, reptime, nrep, tdres, strcat(gentitle, ' 10ms bins'));


 %
 %[vihc, synout, psth, synout_noref, psth_noref] = zusemodel(y,cf,nrep,tdres,reptime, cohc, cihc, fibertype, implnt)