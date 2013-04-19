function [coeff] = zcfourierk(signal, deltaT, period, k)

coeff1 = 1/(2 * pi * period);

if(rem(period, deltaT) ~= 0 )
	error('deltaT must be a multiple of period');
end

step_max = period/deltaT;

omega = 2 * pi / period;

index = 0;
buffer = 0;

while (index < step_max)
	term = exp(complex(0, 1) * omega * k * index* deltaT) * signal((index + 1)* deltaT) * deltaT;
	buffer = buffer + term;
	
	 index = index + 1;
end

coeff = coeff1 * buffer;