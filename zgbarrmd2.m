function [] = zgbarrmd(valuevars, valuevars_noref, fibertype, pressurexp, ismean, scfact, showLeg)

%valuevars, and noref = [rmd1, var1; rmd2, var2; rmd3, var3; rmd4, var4]
test = 0;

%numbers : see XTickLabel here
%[rmd1_ref rmd1_noref; rmd2_ref rmd2_noref; rmd3_ref rmd3_noref; rmd4_ref rmd4_noref;];
values = [valuevars(1, 1) valuevars_noref(1, 1); valuevars(2, 1) valuevars_noref(2, 1); valuevars(3, 1) valuevars_noref(3, 1); valuevars(4, 1) valuevars_noref(4, 1);];
bar(values, 'hist');
if ismean == 1
	t = 'RMD (mean)';
else
	t = 'RMD ';
end

%or put the decibel value ?
%low_pressure_exp = -7; %49db
%middle_pressure_exp = -3; %84db
%high_pressure_exp = 1; %120db

if pressurexp == -7
	decibel = 49;
elseif pressurexp == -3
	decibel = 84;
elseif pressurexp == 1
	decibel = 120;
else
	error('Unexpected pressurexp');
end

if fibertype == 1
	sr = 'low';
elseif fibertype == 2
	sr = 'medium';
else
	sr = 'high';
end
t = [t, ', ', sr, ' SR, ', num2str(decibel), 'dB'];

%t = [t, ', fb ', num2str(fibertype), ', press. 6.32 exp(', num2str(pressurexp), ') Pa'];
title(t);
xlabel('Stimulus type');
ylabel('RMD');
if showLeg == 1
	leg = legend('normal', 'noref');
	set(leg, 'Location', 'NorthEast');
end

if round(num2str(scfact)) == 1
	thetext = '';
else
	thetext = [' /' num2str(scfact)];
end

%set(gca, 'XTickLabel', {['click' thetext], ['pure tone st.' thetext], 'noise st.', 'pure tone'});
set(gca, 'XTickLabel', {['c.' thetext], ['p.t.st.' thetext], 'n.st.', 'p.t.'});


% * 9/8
if 1 == 0
decalage = 1;

text(0.6, values(1, 1) + decalage, thetext);
text(1.1, values(1, 2) + decalage, thetext);
text(1.6, values(2, 1) + decalage, thetext);
text(2.05, values(2, 2) + decalage, thetext);
end

hold on ;
x = [0.86, 1.14, 1.86, 2.14, 2.86, 3.14, 3.86, 4.14];
y = [valuevars(1, 1), valuevars_noref(1, 1), valuevars(2, 1), valuevars_noref(2, 1), valuevars(3, 1), valuevars_noref(3, 1), valuevars(4, 1), valuevars_noref(4, 1)];
variance =  [valuevars(1, 2), valuevars_noref(1, 2), valuevars(2, 2), valuevars_noref(2, 2), valuevars(3, 2), valuevars_noref(3, 2), valuevars(4, 2), valuevars_noref(4, 2)];

variancelow = [];
for index=1:1:length(y)
	variancelow = [variancelow min([variance(index) y(index)])];
end
errorbar(x, y, variancelow, variance,  '.');
hold off ;