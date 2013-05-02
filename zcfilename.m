function [filename] = zcfilename(prefix, exp, fibertype, pressureexp) % pression is -6.32ex, where x exponent
%can use [a, b] also for concatenation, if want spaces
fibertypestr = num2str(fibertype);
pressureexpstr = num2str(pressureexp);

fibsuff = strcat('f', fibertypestr);
pressuresuff = strcat('p', pressureexpstr);

filsuff = strcat(fibsuff, pressuresuff);

filprein = strcat(prefix, exp);

filename = strcat(filprein, filsuff);