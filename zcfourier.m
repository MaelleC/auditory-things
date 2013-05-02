function [coeff] = zcfourierk(signal, deltaT, period, k)

coeff1 = 1/period;

if(rem(period, deltaT) ~= 0 )
	error('deltaT must be a multiple of period');
end

step_max = period/deltaT;

omega = 2 * pi/period;

index = 0;
buffer = 0;

for index=0:1:(step_max - 1)
	term = exp(complex(0, 1) * omega * k * index * deltaT);
	term = term * signal((index + 1)) * deltaT; 
	buffer = buffer + term;
end

coeff = coeff1 * buffer;