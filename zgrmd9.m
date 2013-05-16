low_pressure_exp = -3; %50db
middle_pressure_exp = -1; %90db
high_pressure_exp = 1; %130db


use_rmdmean = 0;

figure
fibertype = 1;
pressure_exp = low_pressure_exp;

for nr_exp=1:1:9

	%valuevars, and noref = [rmd1, var1; rmd2, var2; rmd3, var3; rmd4, var4]
	valuevars = [];
	valuevars_noref = [];
	
	if fibertype == 1
		thescfact = 20;
	elseif fibertype == 2
		thescfact = 10;
	else
		thescfact = 3;
	end
	
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
		
		%gives 'rmds', 'rmds_noref', 'rmds_wmean', 'rmds_wmean_noref', 'fouriers0', 'fouriers1', 'fouriers2', 'fouriers3', 'fouriers0_noref', 'fouriers1_noref', 'fouriers2_noref', 'fouriers3_noref', 'nrep_nexp'
		load(zcfilename('zsavef/rmdsnexp', experiment, fibertype, pressure_exp));
		
		if strcmp('tonestep', experiment) || strcmp('click', experiment)
			scfact = thescfact;
		else
			scfact = 1;
		end
		
		
		if strcmp('tonestep', experiment) && 1==0
			fibertype
			pressure_exp
			lenofrmds = length(rmds)
		end
		
		if use_rmdmean == 1
			valuevars = [ valuevars; mean(rmds_wmean)/scfact std(rmds_wmean)*factor/scfact];
			valuevars_noref = [ valuevars_noref; mean(rmds_wmean_noref)/scfact std(rmds_wmean_noref)*factor_noref/scfact];
		else
			
			if strcmp('tonestep', experiment) && 1== 0
				%stdnormal = ?;
				%stdnoref = ?;
			
			elseif strcmp('tonestep', experiment) && 1 == 0
				%'max_tonests', 'max_tonests_noref', 'nrep_nexp'
				load(zcfilename('zsavef/rmdsnexp', '_maxtonestep', fibertype, pressure_exp));
				
				%'tonestepbaselines', 'tonestepbaselines_noref'
				load(zcfilename('zsavef/rmdsbase', experiment, fibertype, pressure_exp));
				
				%http://en.wikipedia.org/wiki/Propagation_of_uncertainty#Example_formulas
				%f = A - B, 	\sigma_f^2 = \sigma_A^2 + \sigma_B^2 - 2\,\text{cov}_{AB}
				
				%f = A/B, 	\left(\frac{\sigma_f}{f}\right)^2 \approx \left(\frac{\sigma_A}{A}\right)^2 + \left(\frac{\sigma_B}{B}\right)^2 - 2\frac{\sigma_A\sigma_B}{AB}\rho_{AB}
				
				%f = a - b
				sigmaA1 = zcstdofmean(max_tonests);
				sigmaB1 = zcstdofmean(tonestepbaselines);
				covA1B1 = 0; % !! how to do the covariance of two means ? 
				%http://www.talkstats.com/showthread.php/19836-Covariance-Matrix-of-Sample-Means
				%cov(max_tonests, tonestepbaselines)
				varianceOfSub = sigmaA1^2 + sigmaB1^2 - 2* covA1B1;
				
				%f = a/b
				sigmaA2 = sqrt(varianceOfSub);
				sigmaB2 = zcstdofmean(tonestepbaselines);
				A2 = mean(max_tonest) - mean(tonestepbaselines);
				B2 = mean(tonestepbaselines);
				corrA2B2 = 0; %
				F = mean(rmds);
				varianceOfDiv = F^2 *( (sigmaA2 /A2)^2 + (sigmaB2/ B2)^2 - 2* sigmaA2 * sigmaB2 /(A2 * B2)* corrA2B2);
				
				%stdnormal = ?;
				%stdnoref = ?;
				
			else
				stdnormal = zcstdofmean(rmds);
				stdnoref = zcstdofmean(rmds_noref);
			end
			stdnormalshow = stdnormal * factor;
			stdnorefshow = stdnoref * factor_noref;
			
			valuevars = [ valuevars; mean(rmds)/scfact stdnormalshow];
			valuevars_noref = [ valuevars_noref; mean(rmds_noref)/scfact stdnorefshow];
			
		end
	end
	
	
	subplot(3, 3, nr_exp);
	zgbarrmd2(valuevars, valuevars_noref, fibertype, pressure_exp, use_rmdmean, thescfact);

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




