 %1ms noise
 y = ffGn(1e3, 1/1e2, 0.75, 0, 100);
 plot(1:length(y), y);
 title('1ms noise : y');
 pause;
 vihc = catmodel_IHC(y,1e3,10,1/100e3,0.100,1,1);
 plot(1:length(vihc), vihc);
 title('1ms noise : vihc');
 pause;
 [synout,psth] = catmodel_Synapse(vihc,1e3,10,1/100e3,2,0.5);
 plot(1:length(synout), synout);
 title('1ms noise : synout');
 pause;
 
 plot(1:length(psth), psth);
 title('1ms noise : psth');
 pause;
 
  
 %10e-4 s click, -600Pa
 y = ones(1, 10);
 y = -600*y;
 plot(1:length(y), y);
 title('click : y');
 pause;
 vihc = catmodel_IHC(y,1e3,10,1/100e3,0.100,1,1);
 plot(1:length(vihc), vihc);
 title('click : vihc');
 pause;
 [synout,psth] = catmodel_Synapse(vihc,1e3,10,1/100e3,2,0.5);

 plot(1:length(synout), synout);
 title('click : synout');
 pause;
 
 plot(1:length(psth), psth);
 title('click : psth');
 pause;
 
 %1ms sin amplitude 1, f = 100Hz
 y = 0:9999;
 y = y /1000*2*pi;
 y = sin(y);
 plot(1:length(y), y);
 title('pure tone : y');
 pause;
 vihc = catmodel_IHC(y,100,10,1/100e3,0.100,1,1);
 plot(1:length(vihc), vihc);
 title('pure tone : vihc');
 pause;
 [synout,psth] = catmodel_Synapse(vihc,100,10,1/100e3,2,0.5);
 
 plot(1:length(synout), synout);
 title('pure tone : synout');
 pause;
 
 plot(1:length(psth), psth);
 title('pure tone : psth');
 pause;