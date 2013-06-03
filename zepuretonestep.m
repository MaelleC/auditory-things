clear;
%step, best effect with fibertype = 3
cf = 1e3;
fc = 1e4;
nrep = 800; %800 ok
tdres = 1/100e3;
reptime = 0.1;
 %pression = -6.32e-3; %50dB : ok
pression_exp = -3; %84db
pression = -6.32 * exp(pression_exp);
cohc = 1;
cihc = 1;
fibertype = 3;
implnt = 0;
 
 
t = 0:(ceil(reptime/tdres) - 1); 
t = t*tdres;
 
x = sin(2*pi*t*fc);
 
 %fm = 100;
 %m = sin(2*pi*t*fc);
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
 
  zgstim_psth(y, psth, psth_noref, reptime, nrep, tdres, gentitle)

 %
 %[vihc, synout, psth, synout_noref, psth_noref] = zusemodel(y,cf,nrep,tdres,reptime, cohc, cihc, fibertype, implnt)