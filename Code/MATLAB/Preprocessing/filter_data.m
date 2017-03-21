function [HR_filt, GSR_filt] = filter_data(HR_orig, GSR_orig, interp_method)
    nHRbase = 1:1:length(HR_orig);
    nGSRbase = 1:1:length(GSR_orig);
    nHRbasesp = 1:(nHRbase(end)-1)/(nGSRbase(end)-1):nHRbase(end);
    
    % Filtro HR
    outlierHR = find(HR_orig < 50);
    numHRbase = nHRbase;
    numHRbase(outlierHR) = []; % elimina outlier
    HR_clean = interp1(numHRbase, HR_orig(numHRbase), nHRbase, interp_method)';
    
    HR_zoh = zoh(nHRbase,HR_clean,nHRbasesp);
    HR_filt = smooth(HR_zoh);
    
    % Filtro GSR
    outlierR = find(abs(diff(GSR_orig)) > 300);
    numGSRbase = nGSRbase;
    numGSRbase(outlierR+1) = [];
    GSR_clean = interp1(numGSRbase, GSR_orig(numGSRbase), nGSRbase, interp_method)';
    GSR_filt = smooth(GSR_clean);

end
