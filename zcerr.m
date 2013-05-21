function [stdProp] = zcerr(maxthings, baselines)

%see :
%http://en.wikipedia.org/wiki/Propagation_of_uncertainty#Example_formulas

%f1 = a1 - b1
A1 = maxthings;
B1 = mean(baselines);
F1 = A1 - B1;
sigmaB1 = zcstdofmean(baselines);
varA1 = []; % varA1 = sigmaA1^2

for index=1:1:length(A1)
	varA1 = [varA1 (A1(index) - mean(A1))^2]; %correct that 
end

varF1 = varA1 + sigmaB1^2;

%f2 = a2/b2
A2 = F1;
B2 = mean(baselines);
F2 = F1/B2;
varA2 = varF1;
sigmaB2 = zcstdofmean(baselines);
stdOverB2Sq = (sigmaB2/B2)^2;
stdOverA2Sq = [];

for index=1:1:length(A2)
	stdOverA2Sq = [stdOverA2Sq varA2(index)/(A2(index))^2];
end

sigmaF2 = [];
for index=1:1:length(F2)
	sigmaF2 = [sigmaF2 sqrt(stdOverA2Sq(index) + stdOverB2Sq) * abs(F2(index))];
end


stdProp = sqrt(sum(sigmaF2.^2)) / sqrt(length(F2));%std of mean