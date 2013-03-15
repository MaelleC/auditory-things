% model fiber parameters
clear all; 
CF    = 10.0e3; % CF in Hz;   
cohc  = 1.0;   % normal ohc function
cihc  = 1.0;   % normal ihc function
fiberType = 3; % spontaneous rate (in spikes/s) of the fiber BEFORE refractory effects; "1" = Low; "2" = Medium; "3" = High
implnt = 0;    % "0" for approximate or "1" for actual implementation of the power-law functions in the Synapse
% stimulus parameters
F0 = CF;     % stimulus frequency in Hz
Fs = 100e3;  % sampling rate in Hz (must be 100, 200 or 500 kHz)
T  = 50e-3;  % stimulus duration in seconds
rt = 5e-3;% rise/fall time in seconds
m  = 0.9;    % relative modulation depth of stimulus
Fm = 500.;    % modulation frequency in Hz
stimdb = 10; % stimulus intensity in dB SPL
% PSTH parameters
nrep = 100;               % number of stimulus repetitions (e.g., 50);
psthbinwidth = 0.5e-3; % binwidth in seconds;

t = 0:1/Fs:T-1/Fs; % time vector
mxpts = length(t);
irpts = rt*Fs;

pin = sqrt(2)*20e-6*10^(stimdb/20)*sin(2*pi*F0*t); % unramped unmodulated stimulus
%mod = ones(size(t)) + m*sin(2*pi*Fm*t); % modulation
% for i=1:1:mxpts
%      pin(i) = pin(i) * (1.0+m*sin(2*pi*Fm*t(i)));
% end


pin(1:irpts)=pin(1:irpts).*(0:(irpts-1))/irpts; 
pin((mxpts-irpts):mxpts)=pin((mxpts-irpts):mxpts).*(irpts:-1:0)/irpts;

vihc = catmodel_IHC(pin,CF,nrep,1/Fs,T*2,cohc,cihc); 
[synout,psth] = catmodel_Synapse(vihc,CF,nrep,1/Fs,fiberType,implnt); 
[synout_noref,psth_noref] = catmodel_Synapse_noref(vihc,CF,nrep,1/Fs,fiberType,implnt);

timeout = (1:length(psth))*1/Fs;
psthbins = round(psthbinwidth*Fs);  % number of psth bins per psth bin
psthtime = timeout(1:psthbins:end); % time vector for psth
pr = sum(reshape(psth,psthbins,length(psth)/psthbins))/nrep; % pr of spike in each bin
Psth = pr/psthbinwidth; % psth in units of spikes/s
pr_noref = sum(reshape(psth_noref,psthbins,length(psth)/psthbins))/nrep; % pr of spike in each bin
Psth_noref = pr_noref/psthbinwidth; % psth in units of spikes/s
 
figure
subplot(4,1,1)
plot(timeout,[pin zeros(1,length(timeout)-length(pin))])
title('Input Stimulus')

subplot(4,1,2)
plot(timeout,vihc(1:length(timeout)))
title('IHC output')

subplot(4,1,3)
plot(timeout,synout); 
title('Synapse Output')
xlabel('Time (s)')

subplot(4,1,4)
plot(psthtime,Psth,'-r' ,psthtime,Psth_noref,'-g',timeout,synout,'-b')
title('psth')
xlabel('Time (s)')


