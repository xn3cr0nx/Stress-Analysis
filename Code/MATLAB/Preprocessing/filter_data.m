function [HR_filt, GSR_filt, RR_filt, ST_filt] = filter_data(HR_orig, GSR_orig, RR_orig, ST_orig, interp_method)
    nHRbase = 1:1:length(HR_orig);
    nGSRbase = 1:1:length(GSR_orig);
    nRRbase = 1:1:length(RR_orig);
    nSTbase = 1:1:length(ST_orig);
    nHRbasesp = 1:(nHRbase(end)-1)/(nGSRbase(end)-1):nHRbase(end); % passi per il sovracampionamento dell' HR
    nRRbasesp = 1:(nRRbase(end)-1)/(nGSRbase(end)-1):nRRbase(end); % passi per il sovracampionamento dell' RR
    nSTbasesp = 1:(nSTbase(end)-1)/(nGSRbase(end)-1):nSTbase(end); % passi per il sovracampionamento dell' ST
    
    
%     % Filtro HR
    outlierHR = find(HR_orig < 50);
    numHRbase = nHRbase;
    numHRbase(outlierHR) = []; % elimina outlier
    HR_clean = interp1(numHRbase, HR_orig(numHRbase), nHRbase, interp_method)';
    
    HR_zoh = zoh(nHRbase,HR_clean,nHRbasesp);
    HR_filt = smooth(HR_zoh);
    
    
%     % Filtro GSR
    outlierGSR = find(abs(diff(GSR_orig)) > 300);
    numGSRbase = nGSRbase;
    numGSRbase(outlierGSR+1) = []; % +1 perchè viene fatta la differenza tra l'elemento j-esimo+1 e il j-esimo. Se vero restituisce il j-esimo, ma è il j-esmo+1 che va eliminato
    GSR_clean = interp1(numGSRbase, GSR_orig(numGSRbase), nGSRbase, interp_method)';
    GSR_filt = smooth(GSR_clean);
    
    
%     % Filtro RR
    outlierRR = find(RR_orig < 0.2);
    numRRbase = nRRbase;
    numRRbase(outlierRR) = []; % elimina outlier
    RR_clean = interp1(numRRbase, RR_orig(numRRbase), nRRbase, interp_method)';
    
    RR_zoh = zoh(nRRbase,RR_clean,nRRbasesp);
    RR_filt = smooth(RR_zoh);
    
    
%     % Filtro ST
    numSTbase = nSTbase;
    ST_clean = interp1(numSTbase, ST_orig(numSTbase), nSTbase, interp_method)';
    
    ST_zoh = zoh(nSTbase,ST_clean,nSTbasesp);
    ST_filt = smooth(ST_zoh);

end
