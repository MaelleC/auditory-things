low_pressure_exp = -3; %50db
middle_pressure_exp = -1; %90db
high_pressure_exp = 1; %130db


%takeabs = 1; %if not 1, take angle
for takeabs=0:1:1

	for ndiff_exp=1:1:4

		if ndiff_exp == 1
			experiment = 'click';
		elseif ndiff_exp == 2
			experiment = 'tonestep';
		elseif ndiff_exp == 3
			experiment = 'noisestep';
		else
			experiment = 'tone';
		end



		figure
		fibertype = 1;
		pressure_exp = low_pressure_exp;

		for nr_exp=1:1:9

			%valuevars, and noref = [fourier0, var0; fourier1, var1; fourier2, var2; fourier3, var3]
			valuevars = [];
			valuevars_noref = [];
		
			%gives 'rmds', 'rmds_noref', 'rmds_wmean', 'rmds_wmean_noref', 'fouriers0', 'fouriers1', 'fouriers2', 'fouriers3', 'fouriers0_noref', 'fouriers1_noref', 'fouriers2_noref', 'fouriers3_noref', 'nrep_nexp'
			load(zcfilename('zsavef/rmdsnexp', experiment, fibertype, pressure_exp));
		
			if takeabs == 1
				fouriers0 = abs(fouriers0);
				fouriers1 = abs(fouriers1);
				fouriers2 = abs(fouriers2);
				fouriers3 = abs(fouriers3);
				fouriers0_noref = abs(fouriers0_noref);
				fouriers1_noref = abs(fouriers1_noref);
				fouriers2_noref = abs(fouriers2_noref);
				fouriers3_noref = abs(fouriers3_noref);
			else
				fouriers0 = angle(fouriers0);
				fouriers1 = angle(fouriers1);
				fouriers2 = angle(fouriers2);
				fouriers3 = angle(fouriers3);
				fouriers0_noref = angle(fouriers0_noref);
				fouriers1_noref = angle(fouriers1_noref);
				fouriers2_noref = angle(fouriers2_noref);
				fouriers3_noref = angle(fouriers3_noref);
			end
			
			valuevars = [mean(fouriers0) var(fouriers0); mean(fouriers1) var(fouriers1); mean(fouriers2) var(fouriers2); mean(fouriers3) var(fouriers3);];
			valuevars_noref = [mean(fouriers0_noref) var(fouriers0_noref); mean(fouriers1_noref) var(fouriers1_noref); mean(fouriers2_noref) var(fouriers2_noref); mean(fouriers3_noref) var(fouriers3_noref);];
			
			
			subplot(3, 3, nr_exp);
			zgbarfourier(valuevars, valuevars_noref, fibertype, pressure_exp, experiment, takeabs);

			if (nr_exp == 3 || nr_exp == 6)
				if fibertype == 1
					fibertype = 2;
				else
					fibertype = 3;
				end
			end
			
			if pressure_exp == low_pressure_exp
				pressure_exp = middle_pressure_exp;
			elseif pressure_exp == middle_pressure_exp
				pressure_exp = high_pressure_exp;
			else
				pressure_exp = low_pressure_exp;
			end

		end

	end
end