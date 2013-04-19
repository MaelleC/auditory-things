function [filename] = zcfilename(exp, fibertype, pressionexp) % pression is -6.32ex, where x exponent

fibertypestr = num2str(fibertype);
pressionexpstr = num2str(pressionexp);

fibsuff = strcat('f', fibertypestr);
pressionsuff = strcat('p', pressionexpstr);

filsuff = strcat(fibsuff, pressionsuff);

filprein = strcat('zsavef/rmdsave', exp);

filename = strcat(filprein, filsuff);