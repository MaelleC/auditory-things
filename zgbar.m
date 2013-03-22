function [] = zgbar(rmd1_ref, rmd1_noref, rmd2_ref, rmd2_noref, rmd3_ref, rmd3_noref, rmd4_ref, rmd4_noref, fibertype)

figure;

y = [rmd1_ref rmd1_noref; rmd2_ref rmd2_noref; rmd3_ref rmd3_noref; rmd4_ref rmd4_noref;];

bar(y,'hist');
title(strcat('Rate modulation depth : fibertype ', num2str(fibertype)));
xlabel('Stimulus type');
ylabel('RMD');
leg = legend('normal', 'noref');
%set(leg, 'Location', 'EastOutside');
set(leg, 'Location', 'NorthEast');
set(gca, 'XTickLabel', {'click', 'pure tone step', 'noise step', 'pure tone'});
%bar(y,'grouped');
