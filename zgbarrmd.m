function [] = zgbarrmd(rmd1_ref, rmd1_noref, rmd2_ref, rmd2_noref, rmd3_ref, rmd3_noref, rmd4_ref, rmd4_noref, fibertype, pressureexp)

figure;

y = [rmd1_ref rmd1_noref; rmd2_ref rmd2_noref; rmd3_ref rmd3_noref; rmd4_ref rmd4_noref;];

bar(y,'hist');
t = strcat('Rate modulation depth : fibertype ', num2str(fibertype));
t = strcat(t, ' pressure 6.32 exp (');
t = [t ') Pa'];
title(strcat(t, num2str(pressureexp)));
xlabel('Stimulus type');
ylabel('RMD');
leg = legend('normal', 'noref');
%set(leg, 'Location', 'EastOutside');
set(leg, 'Location', 'NorthEast');
set(gca, 'XTickLabel', {'click', 'pure tone step', 'noise step', 'pure tone'});
%bar(y,'grouped');
