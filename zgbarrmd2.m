function [] = zgbarrmd(rmdgraph_matrix, all, fibertype, pressurexp)

%what to do with std deviation ?

test = 0;

matrix = rmdgraph_matrix;
bar(matrix, 'hist');


t = strcat('Rate modulation depth : fibertype ', num2str(fibertype));
t = strcat(t, ' pressure 6.32e');
title(strcat(t, num2str(pressurexp))); %put unit ?
xlabel('Stimulus type');
ylabel('RMD');
leg = legend('normal', 'noref');
set(leg, 'Location', 'NorthEast');
set(gca, 'XTickLabel', {'click', 'pure tone step', 'noise step', 'pure tone'});

hold on ;
x = [0.86, 1.14, 1.86, 2.14, 2.86, 3.14, 3.86, 4.14];
y = [matrix(1, 1), matrix(1, 2), matrix(2, 1), matrix(2, 2), matrix(3, 1), matrix(3, 2), matrix(4, 1), matrix(4, 2)];
variance =  [all(1, 2), all(1, 5), all(2, 2), all(2, 5), all(3, 2), all(3, 5), all(4, 2), all(4, 5)];
errorbar(x,y,variance,'+');
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