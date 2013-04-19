function [] = zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle)

figure;
 %a = (0:length(y)-1);
 %a = a * tdres;
 i = (0:length(synout)-1);
 i = i * tdres;
 m = [y zeros(1, length(i) - length(y))];
 subplot(2,2,1);
 %plot(a, y);
 plot(i, m);
 title(strcat(gentitle, ' : stimulus'));
 xlabel('Time (sec)');
 ylabel('Pressure (Pa)');
 
 b = (0:length(vihc)-1);
 b = b * tdres;
 subplot(2,2,2);
 plot(b, vihc(1: length(vihc)));
 title(strcat(gentitle, ' : IHC potential'));
 xlabel('Time (sec)');
 ylabel('IHC potential (volt)');
 
 c = (0:length(synout)-1);
 c = c * tdres;
 

 subplot(2,2,3);
 plot(c, synout);
 title(strcat(gentitle, ' : synapse output'));
 xlabel('Time (sec)');
 %ylabel('Spikes');
 
 subplot(2,2,4);
 fact = tdres * nrep;
 plot(c, psth/fact);
 title(strcat(gentitle, ' : psth'));
 xlabel('Time (sec)');
 ylabel('Firing rate (Hz)');