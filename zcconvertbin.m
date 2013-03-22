function [vec2] = zcconvertbin(oldsize, newsize, vector)

factor = newsize / oldsize;

if(rem(newsize, oldsize) ~= 0 )
	error('newsize must be a multiple of oldsize.');
elseif (rem(length(vector), newsize/oldsize) ~= 0)
	error('vector must be a multiple of newsize/oldsize.');
end

factor = newsize / oldsize;

begin = 1;
end0 = factor;
vec2 = [];

while(floor(end0) <= length(vector))
	mean0 = mean(vector(floor(begin) : floor(end0)));
	vec2 = [vec2 mean0];
	begin = begin + factor;
	end0 = end0 + factor;
end

%1/100e3 bins to 2/1e3 (2ms)