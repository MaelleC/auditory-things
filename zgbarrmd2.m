function [] = zgbarrmd(valuevars, valuevars_noref, fibertype, pressurexp, ismean)

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
t = [t, ', fibertype ', num2str(fibertype), ', pressure 6.32e', num2str(pressurexp), ' Pa'];
title(t);
xlabel('Stimulus type');
ylabel('RMD');
leg = legend('normal', 'noref');
set(leg, 'Location', 'NorthEast');
set(gca, 'XTickLabel', {'click', 'pure tone st.', 'noise st.', 'pure tone'});

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