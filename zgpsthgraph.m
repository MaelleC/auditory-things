function [] = zpsthgraph(psth, psth_noref, reptime, nrep, tdres, gentitle)

figure;
x = (0:length(psth)-1);
x = x * reptime/ (length(psth)-1);
fact = tdres * nrep;
y1 = psth/fact;
y2 = psth_noref/fact;


%http://www.mathworks.ch/ch/help/matlab/creating_plots/using-high-level-plotting-functions.html
style1 = 'b-';
style2 = 'g-';
style3 = 'w-';
style4 = 'm-';
plot(x, y1, style1, x, y2, style2);
title(strcat(gentitle, ' : psth normal and psth without absolute refraction period'));

noreflegend = 'minus no ref';
if(max(psth_noref > 0))
	noreflegend = 'no ref';
end
legend('normal', noreflegend);
xlabel('Time (sec)');
ylabel('Firing rate');
 

%2 lines :

%p1:
%plot(x, y1 ); 
%hold on;
%plot(x, y2); 
%hold off;

%p2:
%plot(x, y1, x, y2);


