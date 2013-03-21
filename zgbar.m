function [] = zgbar(rmd1_ref, rmd1_noref, rmd2_ref, rmd2_noref, rmd3_ref, rmd3_noref, rmd4_ref, rmd4_noref)

figure;
%rmd1_ref = 3; 
%rmd1_noref = 4; 
%rmd2_ref = 2; 
%rmd2_noref = 5;  
%rmd3_ref = 1; 
%rmd3_noref = 6;  
%rmd4_ref = 0;  
%rmd4_noref = 7; 

y = [rmd1_ref rmd1_noref; rmd2_ref rmd2_noref; rmd3_ref rmd3_noref; rmd4_ref rmd4_noref;];

bar(y,'hist');
title('Rate modulation depth');
xlabel('Stimulus type');
ylabel('RMD');
leg = legend('normal', 'noref');
set(leg, 'Location', 'EastOutside');
%bar(y,'grouped');