function [psth_good] = zcomputePSTH(psth, nrep)

%length gives us the index for the last, counted from 1

old_psth_len = length(psth);

if(rem(old_psth_len, nrep) ~= 0 )
	error('newsize must be a multiple of oldsize.');
end

good_length = old_psth_len / nrep;


remainder = 1;
index = 1;
psth_good = zeros(1, good_length);

while(index <= old_psth_len)
	psth_good(remainder) = psth_good(remainder) + psth(index);
	
	if remainder == good_length
		remainder = 1;
	else
		remainder = remainder + 1;
	end
	
	index = index + 1;
	
end
