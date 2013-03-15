function [] = zfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle)

figure;
 a = (0:length(y)-1);
 a = a * tdres;
 subplot(2,2,1);
 plot(a, y);
title(strcat(gentitle, ' : y'));
 
 b = (0:length(synout)-1);
 b = b * tdres;
 subplot(2,2,2);
 plot(b, vihc(1: length(synout)));
 title(strcat(gentitle, ' : vihc'));
 
 c = (0:length(synout)-1);
 c = c * tdres;
 

 subplot(2,2,3);
 plot(c, synout);
 title(strcat(gentitle, ' : synout'));
 
 subplot(2,2,4);
 plot(c, psth);
 title(strcat(gentitle, ' : psth'));