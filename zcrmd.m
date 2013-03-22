%find rate modulation depth
% rmd = (peak - baseline)/baseline

%zeclick
load 'zsavef/rmdsaveclick'

zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);

psth2ms = zcconvertbin(tdres, 2/1000, psth);
psth2ms_noref = zcconvertbin(tdres, 2/1000, psth_noref);

psth10ms = zcconvertbin(tdres, 10/1000, psth);
psth10ms_noref = zcconvertbin(tdres, 10/1000, psth_noref);

zgpsthgraph(psth2ms, psth2ms_noref, reptime, nrep, 2/1000, strcat(gentitle, ' 2ms bins'));
zgpsthgraph(psth10ms, psth10ms_noref, reptime, nrep, 10/1000, strcat(gentitle, ' 10ms bins'));

baseref = psth10ms(10);
basenoref = psth10ms_noref(10);

click_ref = (max(psth2ms)- baseref) / baseref;
click_noref = (max(psth2ms_noref) - basenoref) / basenoref;


%zepuretonestep
load 'zsavef/rmdsavetonestep'

zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);

psth2ms = zcconvertbin(tdres, 2/1000, psth);
psth2ms_noref = zcconvertbin(tdres, 2/1000, psth_noref);

psth10ms = zcconvertbin(tdres, 10/1000, psth);
psth10ms_noref = zcconvertbin(tdres, 10/1000, psth_noref);

zgpsthgraph(psth2ms, psth2ms_noref, reptime, nrep, 2/1000, strcat(gentitle, ' 2ms bins'));
zgpsthgraph(psth10ms, psth10ms_noref, reptime, nrep, 10/1000, strcat(gentitle, ' 10ms bins'));

baseref = psth10ms(5);
basenoref = psth10ms_noref(5);

tonestep_ref = (max(psth2ms)- baseref) / baseref;
tonestep_noref = (max(psth2ms_noref) - basenoref) / basenoref;

%zenoisestep
load 'zsavef/rmdsavenoisestep'

zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);

psth2ms = zcconvertbin(tdres, 2/1000, psth);
psth2ms_noref = zcconvertbin(tdres, 2/1000, psth_noref);

psth10ms = zcconvertbin(tdres, 10/1000, psth);
psth10ms_noref = zcconvertbin(tdres, 10/1000, psth_noref);

zgpsthgraph(psth2ms, psth2ms_noref, reptime, nrep, 2/1000, strcat(gentitle, ' 2ms bins'));
zgpsthgraph(psth10ms, psth10ms_noref, reptime, nrep, 10/1000, strcat(gentitle, ' 10ms bins'));

baseref = psth10ms(5);
basenoref = psth10ms_noref(5);

noisestep_ref = (max(psth2ms)- baseref) / baseref;
noisestep_noref = (max(psth2ms_noref) - basenoref) / basenoref;

%zepuretone
load 'zsavef/rmdsavetone'

psth2ms = zcconvertbin(tdres, 2/1000, psth);
psth2ms_noref = zcconvertbin(tdres, 2/1000, psth_noref);

zgpsthgraph(psth2ms, psth2ms_noref, reptime, nrep, 2/1000, strcat(gentitle, ' 2ms bins'));

baseref = mean(psth);
basenoref = mean(psth_noref);

tone_ref = (max(psth2ms)- baseref) / baseref;
tone_noref = (max(psth2ms_noref) - basenoref) / basenoref;

%1: click, 2: pure tone step, 3: noise step, 4: pure tone
zgbar(click_ref, click_noref, tonestep_ref, tonestep_noref, noisestep_ref, noisestep_noref, tone_ref, tone_noref)
