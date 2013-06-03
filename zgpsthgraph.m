function [] = zgpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle)

ifprint = 1

figure;
x = (0:length(psth)-1);
x = x * reptime/ (length(psth)-1);
fact = tdres * nrep;
y1 = psth/fact;
y2 = psth_noref/fact;

%http://www.mathworks.ch/ch/help/matlab/creating_plots/using-high-level-plotting-functions.html

if ifprint == 1
	style1 = 'k-';
	style2 = 'g-';
else
	style1 = 'b-';
	style2 = 'g-';
end

%plot(x, y1, style1, x, y2, style2);
stairs(x, y1, style1);
hold on;
stairs(x, y2, style2); 
hold off;

title(strcat(gentitle, ' : periodogram normal and without absolute refraction period'));

noreflegend = 'minus no ref';
if(max(psth_noref > 0))
	noreflegend = 'no ref';
end
legend('normal', noreflegend);
xlabel('Time (sec)');
ylabel('Firing rate (Hz)');
 

%2 lines :

%p1:
%plot(x, y1 ); 
%hold on;
%plot(x, y2); 
%hold off;

%p2:
%plot(x, y1, x, y2);
%http://www.mathworks.ch/ch/help/matlab/ref/colorspec.html

