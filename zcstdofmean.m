function [stdOfMean] = zcstdofmean(aVector)
stdOfMean = std(aVector)/sqrt(length(aVector));