%find rate modulation depth
zeclick
baseref = ??
basenoref = ??

click_ref = max(psth) / baseref;
click_noref = max(psth) / basenoref;


zepuretonestep
tonestep_ref = max(psth) / baseref;
tonestep_noref = max(psth) / basenoref;

zenoisestep
noisestep_ref = max(psth) / baseref;
noisestep_noref = max(psth) / basenoref;

zepuretone
tone_ref = max(psth) / baseref;
tone_noref = max(psth) / basenoref;

%1: click, 2: pure tone step, 3: noise step, 4: pure tone
zgbar(click_ref, click_noref, tonestep_ref, tonestep_noref, noisestep_ref, noisestep_noref, tone_ref, tone_noref)

%rmd1 = max(psth) / min (psth); %rate modulation depth, problem : division by 0
%rmd1 = ones(1, length(x)) * rmd1(1);
%rmd2 = max(psth_noref) / min (psth_noref);
%rmd2 = ones(1, length(x)) * rmd2(1);