function [] = zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle)

nbCol = 2;
nbLig = 2;

color = 'k';

figure;
 %a = (0:length(y)-1);
 %a = a * tdres;
 i = (0:length(synout)-1);
 i = i * tdres;
 m = [y zeros(1, length(i) - length(y))];
 subplot(nbLig,nbCol,1);
 %plot(a, y);
 plot(i, m, color);
 title(strcat(gentitle, ' : stimulus'));
 xlabel('Time (sec)');
 ylabel('Pressure (Pa)');
 
 b = (0:length(vihc)-1);
 b = b * tdres;
 subplot(nbLig,nbCol,2);
 plot(b, vihc(1: length(vihc)), color);
 title(strcat(gentitle, ' : IHC potential'));
 xlabel('Time (sec)');
 ylabel('IHC potential (volt)');
 
 c = (0:length(synout)-1);
 c = c * tdres;
 
 subplot(nbLig,nbCol,3);
 plot(c, synout, color);
 title(strcat(gentitle, ' : synapse output'));
 xlabel('Time (sec)');
 %ylabel('Spikes');
 
 c = (0:length(psth)-1);
 c = c * tdres;
 
 subplot(nbLig,nbCol,4);
 fact = tdres * nrep;
 plot(c, psth/fact, color);
 title(strcat(gentitle, ' : periodogram'));
 xlabel('Time (sec)');
 ylabel('Firing rate (Hz)');