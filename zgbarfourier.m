function [] = zgbarfourier(valuevars, valuevars_noref, fibertype, pressurexp, experiment, isabs)

%valuevars, and noref = [fourier0, var0; fourier1, var1; fourier2, var2; fourier3, var3]
test = 0;

%numbers : see XTickLabel here
%[fourier0_ref fourier0_noref; fourier1_ref fourier1_noref; fourier2_ref fourier2_noref; fourier3_ref fourier3_noref;];
values = [valuevars(1, 1) valuevars_noref(1, 1); valuevars(2, 1) valuevars_noref(2, 1); valuevars(3, 1) valuevars_noref(3, 1); valuevars(4, 1) valuevars_noref(4, 1);];
bar(values, 'hist');

%or put the decibel value ?
if isabs == 1
	t = 'Fourier coeff. norm ';
else
	t = 'Fourier coeff. angle ';
end
t = [t, 'for ', experiment, ', fibertype ', num2str(fibertype), ', pressure 6.32 exp(', num2str(pressurexp), ') Pa'];
title(t);
xlabel('Coefficients');
ylabel('Value');
leg = legend('normal', 'noref');
set(leg, 'Location', 'NorthEast');
set(gca, 'XTickLabel', {'0', '1', '2', '3'});

hold on ;
x = [0.86, 1.14, 1.86, 2.14, 2.86, 3.14, 3.86, 4.14];
y = [valuevars(1, 1), valuevars_noref(1, 1), valuevars(2, 1), valuevars_noref(2, 1), valuevars(3, 1), valuevars_noref(3, 1), valuevars(4, 1), valuevars_noref(4, 1)];
variance =  [valuevars(1, 2), valuevars_noref(1, 2), valuevars(2, 2), valuevars_noref(2, 2), valuevars(3, 2), valuevars_noref(3, 2), valuevars(4, 2), valuevars_noref(4, 2)];
errorbar(x, y, variance, '.');
hold off ;