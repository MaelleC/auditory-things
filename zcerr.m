function [errorProp] = zcerr(maxthings, baseline)

%http://en.wikipedia.org/wiki/Propagation_of_uncertainty#Example_formulas

%f = a - b
sigmaA1 = zcstdofmean(maxthings);
sigmaB1 = zcstdofmean(baseline);
covA1B1 = 0;
%http://www.talkstats.com/showthread.php/19836-Covariance-Matrix-of-Sample-Means

if 1 == 0
for indexm=1:1:length(maxthings)
	for indexb=1:1:length(baseline)
		covA1B1 = covA1B1 + (maxthings(indexm) - mean(maxthings))*(baseline(indexb) - mean(baseline));
	end
end
covA1B1 = covA1B1/(length(baseline) * length(maxthings))
end

varianceOfSub = sigmaA1^2 + sigmaB1^2 - 2*covA1B1;

%f = a/b
sigmaA2 = sqrt(varianceOfSub);
sigmaB2 = zcstdofmean(baseline);
A2 = mean(maxthings) - mean(baseline);
B2 = mean(baseline);
covA2B2 = 0;

if 1 == 0
for indexm=1:1:length(A2)
	for indexb=1:1:length(baseline)
		covA2B2 = covA2B2 + (A2(indexm) - mean(A2))*(baseline(indexb) - mean(baseline));
	end
end
covA2B2 = covA2B2/(length(baseline) * length(maxthings))
end

%corrA2B2 = covA2B2/(sigmaA2 * sigmaB2);
F = A2/B2;
varianceOfDiv = F^2 *( (sigmaA2 /A2)^2 + (sigmaB2/ B2)^2 - 2 * covA2B2 /(A2 * B2));

errorProp = sqrt(varianceOfDiv);