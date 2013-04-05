clear;
%find rate modulation depth
% rmd = (peak - baseline)/baseline
fib = 2;
fibertypestr = num2str(fib);
pressionexp = -3;
pressionexpstr = num2str(pressionexp);% pression is -6.32ex, where x exponent
fibsuff = strcat('f', fibertypestr);
pressionsuff = strcat('p', pressionexpstr);
filsuff = strcat(fibsuff, pressionsuff);

clickfile = strcat('zsavef/rmdsaveclick', filsuff);
puretonestepfile = strcat('zsavef/rmdsavetonestep', filsuff);
noisestepfile = strcat('zsavef/rmdsavenoisestep', filsuff);
puretonefile = strcat('zsavef/rmdsavetone', filsuff);

%must be divisible by 10e-5
binpeak = 2/1000;
binbase = 10/1000;

%zeclick
load(clickfile);

%zgfourgraphs(y, vihc, psth, synout, reptime, nrep, tdres, gentitle);
%zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);

psth2ms = zcconvertbin(tdres, binpeak, psth);
psth2ms_noref = zcconvertbin(tdres, binpeak, psth_noref);

psth10ms = zcconvertbin(tdres, binbase, psth);
psth10ms_noref = zcconvertbin(tdres, binbase, psth_noref);

%zgpsthgraph(psth2ms, psth2ms_noref, reptime, nrep, tdres, strcat(gentitle, ' 2ms bins'));
%zgpsthgraph(psth10ms, psth10ms_noref, reptime, nrep, tdres, strcat(gentitle, ' 10ms bins'));

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
load(puretonestepfile);
 zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);

psth2ms = zcconvertbin(tdres, binpeak, psth);
psth2ms_noref = zcconvertbin(tdres, binpeak, psth_noref);

psth10ms = zcconvertbin(tdres, binbase, psth);
psth10ms_noref = zcconvertbin(tdres, binbase, psth_noref);

zgpsthgraph(psth2ms, psth2ms_noref, reptime, nrep, tdres, strcat(gentitle, ' 2ms bins'));
zgpsthgraph(psth10ms, psth10ms_noref, reptime, nrep, tdres, strcat(gentitle, ' 10ms bins'));

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
load(noisestepfile);
 zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle);

psth2ms = zcconvertbin(tdres, binpeak, psth);
psth2ms_noref = zcconvertbin(tdres, binpeak, psth_noref);

psth10ms = zcconvertbin(tdres, binbase, psth);
psth10ms_noref = zcconvertbin(tdres, binbase, psth_noref);

zgpsthgraph(psth2ms, psth2ms_noref, reptime, nrep, tdres, strcat(gentitle, ' 2ms bins'));
zgpsthgraph(psth10ms, psth10ms_noref, reptime, nrep, tdres, strcat(gentitle, ' 10ms bins'));



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
load(puretonefile);

psth2ms = zcconvertbin(tdres, binpeak, psth);
psth2ms_noref = zcconvertbin(tdres, binpeak, psth_noref);

%zgpsthgraph(psth2ms, psth2ms_noref, reptime, nrep, tdres, strcat(gentitle, ' 2ms bins'));

baseref = mean(psth);
basenoref = mean(psth_noref);

if(baseref == 0)
tone_ref = -0.05;
else
tone_ref = (max(psth2ms)- baseref) / baseref;
end

if(basenoref == 0)
tone_noref = -0.05;
else
tone_noref = (max(psth2ms_noref) - basenoref) / basenoref;
end

%1: click, 2: pure tone step, 3: noise step, 4: pure tone
zgbar(click_ref, click_noref, tonestep_ref, tonestep_noref, noisestep_ref, noisestep_noref, tone_ref, tone_noref, fib, pressionexp)
