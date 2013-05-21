function [stdProp] = zcerr2(up, down) %when we do mean(up)/mean(down)

%F = A/B
A = mean(up);
B = mean(down);
stdA = zcstdofmean(up);
stdB = zcstdofmean(down);
F = A/B;

stdF = sqrt((stdA/A)^2 + (stdB/B)^2) * abs(F);

stdProp = stdF;
