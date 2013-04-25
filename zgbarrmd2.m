function [] = zgbarrmd(rmdgraph_matrix, all, fibertype, pressurexp)


%TODO : use std deviations
test = 0;

bar(rmdgraph_matrix,'hist');
t = strcat('Rate modulation depth : fibertype ', num2str(fibertype));
t = strcat(t, ' pression -6.32e');
title(strcat(t, num2str(pressurexp)));
xlabel('Stimulus type');
ylabel('RMD');
leg = legend('normal', 'noref');
set(leg, 'Location', 'NorthEast');
set(gca, 'XTickLabel', {'click', 'pure tone step', 'noise step', 'pure tone'});

hold on ;
%h = errorbar(x,y,'+') ;
hold off ;


if test == 1
%http://www.mathworks.com/matlabcentral/newsreader/view_thread/140517
x=1:10 ;
y = 10*rand(size(x)) ;
bar(x,y)
hold on ;
h = errorbar(x,y,'+') ;
hold off ;
end