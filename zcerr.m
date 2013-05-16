function [errorProp] = zcerr(maxthings, baseline, rmds)

%http://en.wikipedia.org/wiki/Propagation_of_uncertainty#Example_formulas

%f = a - b
sigmaA1 = zcstdofmean(maxthings);
sigmaB1 = zcstdofmean(baseline);
covA1B1 = -1 * sigmaA1 * sigmaA2; % !! how to do the covariance of two means ? 
%http://www.talkstats.com/showthread.php/19836-Covariance-Matrix-of-Sample-Means
%cov(max_tonests, tonestepbaselines)
varianceOfSub = sigmaA1^2 + sigmaB1^2 - 2*covA1B1;

%f = a/b
sigmaA2 = sqrt(varianceOfSub);
sigmaB2 = zcstdofmean(baseline);
A2 = mean(maxthings) - mean(baseline);
B2 = mean(baseline);
covA2B2 = -1 * sigmaA2 * sigmaA1;%%%cvarianceof2means ?
corrA2B2 = covA2B2/(sigmaA2 * sigmaB2);
F = mean(rmds);
varianceOfDiv = F^2 *( (sigmaA2 /A2)^2 + (sigmaB2/ B2)^2 - 2 * covA2B2 /(A2 * B2));

errorProp = sqrt(varianceOfDiv);