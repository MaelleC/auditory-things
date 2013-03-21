%find rate modulation depth
%zeclick
load 'zsavef/rmdsaveclick'

zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);

baseref = ??
basenoref = ??

click_ref = max(psth) / baseref;
click_noref = max(psth) / basenoref;


%zepuretonestep
load 'zsavef/rmdsavetonestep'

baseref = mean(psth(floor(length(psth)/4):floor(length(psth)/2)));
basenoref = mean(psth_noref(floor(length(psth)/4):floor(length(psth)/2)));

tonestep_ref = max(psth) / baseref;
tonestep_noref = max(psth) / basenoref;

%zenoisestep
load 'zsavef/rmdsavenoisestep'

baseref = ??
basenoref = ??

noisestep_ref = max(psth) / baseref;
noisestep_noref = max(psth) / basenoref;

%zepuretone
load 'zsavef/rmdsavetone'

baseref = ??
basenoref = ??

tone_ref = max(psth) / baseref;
tone_noref = max(psth) / basenoref;

%1: click, 2: pure tone step, 3: noise step, 4: pure tone
zgbar(click_ref, click_noref, tonestep_ref, tonestep_noref, noisestep_ref, noisestep_noref, tone_ref, tone_noref)
