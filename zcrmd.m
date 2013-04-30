clear;
%graphs
%zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
%zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);

%find rate modulation depth
% rmd = (peak - baseline)/baseline
fib = 2;
pression_exp = -3;

clickfile = zcfilename('zsavef/rmdsave', 'click', fib, pression_exp);
puretonestepfile = zcfilename('zsavef/rmdsave', 'tonestep', fib, pression_exp);
noisestepfile = zcfilename('zsavef/rmdsave', 'noisestep', fib, pression_exp);
puretonefile = zcfilename('zsavef/rmdsave', 'tone', fib, pression_exp);

showexpgraphs = 0;
showintermgraph = 0;

%must be divisible by 10e-5
binpeak = 2/1000;
binbase = 10/1000;

%zeclick
%----------

load(clickfile);

if showexpgraphs ~= 0
	zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
	zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);
end

psth2ms = zcconvertbin(tdres, binpeak, psth);
psth2ms_noref = zcconvertbin(tdres, binpeak, psth_noref);

psth10ms = zcconvertbin(tdres, binbase, psth);
psth10ms_noref = zcconvertbin(tdres, binbase, psth_noref);

if showintermgraph ~= 0
	zgpsthgraph(psth2ms, psth2ms_noref, reptime, nrep, tdres, strcat(gentitle, ' 2ms bins'));
	zgpsthgraph(psth10ms, psth10ms_noref, reptime, nrep, tdres, strcat(gentitle, ' 10ms bins'));
end

baseref = psth10ms(10);
basenoref = psth10ms_noref(10);

if(baseref == 0)
click_ref = -0.05;
else
click_ref = (max(psth2ms)- baseref) / baseref;
end

if(basenoref == 0)
click_noref = -0.05;
else
click_noref = (max(psth2ms_noref) - basenoref) / basenoref;
end

%zepuretonestep
%----------

load(puretonestepfile);

if showexpgraphs ~= 0
	zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
	zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);
end

psth2ms = zcconvertbin(tdres, binpeak, psth);
psth2ms_noref = zcconvertbin(tdres, binpeak, psth_noref);

psth10ms = zcconvertbin(tdres, binbase, psth);
psth10ms_noref = zcconvertbin(tdres, binbase, psth_noref);

if showintermgraph ~= 0
	zgpsthgraph(psth2ms, psth2ms_noref, reptime, nrep, tdres, strcat(gentitle, ' 2ms bins'));
	zgpsthgraph(psth10ms, psth10ms_noref, reptime, nrep, tdres, strcat(gentitle, ' 10ms bins'));
end

baseref = psth10ms(5);
basenoref = psth10ms_noref(5);

if(baseref == 0)
tonestep_ref = -0.05;
else
tonestep_ref = (max(psth2ms)- baseref) / baseref;
end

if(basenoref == 0)
tonestep_noref = -0.05;
else
tonestep_noref = (max(psth2ms_noref) - basenoref) / basenoref;
end

%zenoisestep
%----------

load(noisestepfile);

if showexpgraphs ~= 0
	zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
	zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);
end

psth2ms = zcconvertbin(tdres, binpeak, psth);
psth2ms_noref = zcconvertbin(tdres, binpeak, psth_noref);

psth10ms = zcconvertbin(tdres, binbase, psth);
psth10ms_noref = zcconvertbin(tdres, binbase, psth_noref);

if showintermgraph ~= 0
	zgpsthgraph(psth2ms, psth2ms_noref, reptime, nrep, tdres, strcat(gentitle, ' 2ms bins'));
	zgpsthgraph(psth10ms, psth10ms_noref, reptime, nrep, tdres, strcat(gentitle, ' 10ms bins'));
end

baseref = psth10ms(5);
basenoref = psth10ms_noref(5);

if(baseref == 0)
noisestep_ref = -0.05;
else
noisestep_ref = (max(psth2ms)- baseref) / baseref;
end

if(basenoref == 0)
noisestep_noref = -0.05;
else
noisestep_noref = (max(psth2ms_noref) - basenoref) / basenoref;
end

%zepuretone
%----------

load(puretonefile);

if showexpgraphs ~= 0
	zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
	zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);
end

%psth2ms = zcconvertbin(tdres, binpeak, psth);
%psth2ms_noref = zcconvertbin(tdres, binpeak, psth_noref);

if showintermgraph ~= 0
	%zgpsthgraph(psth2ms, psth2ms_noref, reptime, nrep, tdres, strcat(gentitle, ' 2ms bins'));
end

baseref = mean(psth);
basenoref = mean(psth_noref);

if(baseref == 0)
tone_ref = -0.05;
else
%tone_ref = (max(psth2ms)- baseref) / baseref;
tone_ref = (max(psth)- baseref) / baseref;
end

if(basenoref == 0)
tone_noref = -0.05;
else
%tone_noref = (max(psth2ms_noref) - basenoref) / basenoref;
tone_noref = (max(psth_noref) - basenoref) / basenoref;
end

%1: click, 2: pure tone step, 3: noise step, 4: pure tone
zgbarrmd(click_ref, click_noref, tonestep_ref, tonestep_noref, noisestep_ref, noisestep_noref, tone_ref, tone_noref, fib, pression_exp)
