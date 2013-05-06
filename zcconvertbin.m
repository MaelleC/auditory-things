function [vec2] = zcconvertbin(oldsize, newsize, vector)


if(rem(newsize, oldsize) ~= 0 )
	error('newsize must be a multiple of oldsize.');
elseif (rem(length(vector), newsize/oldsize) ~= 0)
	error('vector must be a multiple of newsize/oldsize.');
end

factor = round(newsize / oldsize);

begin = 1;
end0 = factor;
vec2 = [];

while(end0 <= length(vector))
	mean0 = mean(vector(begin : end0));
	vec2 = [vec2 mean0];
	begin = begin + factor;
	end0 = end0 + factor;
end