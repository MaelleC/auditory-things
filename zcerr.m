function [errorProp] = zcerr(maxthings, baseline)

%correct this function

%http://en.wikipedia.org/wiki/Propagation_of_uncertainty#Example_formulas

%f = a - b
sigmaA1 = std(maxthings);
sigmaB1 = zcstdofmean(baseline);
covA1B1 = [];
%http://www.talkstats.com/showthread.php/19836-Covariance-Matrix-of-Sample-Means


for indexm=1:1:length(maxthings)
	covpart = 0;
	for indexb=1:1:length(baseline)
		covpart = covpart + (maxthings(indexm) - mean(maxthings))*(baseline(indexb) - mean(baseline));
	end
	covpart = covpart /length(baseline); %ok this division ? (will be float ?)
	covA1B1 = [covA1B1 covpart];
end

varianceOfSub = sigmaA1^2 + sigmaB1^2 - 2*covA1B1;

%f = a/b
sigmaA2 = sqrt(varianceOfSub);
sigmaB2 = zcstdofmean(baseline);
A2 = maxthings - mean(baseline);
B2 = mean(baseline);
covA2B2 = 0;%since, B2 is only one number that is its own expectation

F = A2/B2;
varianceOfDiv = F^2 .*( (sigmaA2 ./A2)^2 + (sigmaB2/ B2)^2 - 2 * covA2B2 ./(A2 * B2));

errorProp = sqrt(mean(varianceOfDiv));