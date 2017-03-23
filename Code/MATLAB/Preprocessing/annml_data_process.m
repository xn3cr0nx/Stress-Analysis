clear all
close all
clc

dataset_path = '../../Dataset/';

% Dati di Luca, presi dagli esperimenti
load(strcat(dataset_path,'All.mat'));

patient = 1:17;
patient(9) = []; % i dati del paziente 9 non sono affidabili

%% Filtro dei dati
for j = patient
    % Relax
    HR_orig = data.relax(j).HR;
    GSR_orig = data.relax(j).GSR;
    stress_relax = data.relax(j).stress;
    
    [HR_filt_relax, GSR_filt_relax] = filter_data(HR_orig, GSR_orig, 'spline');
    
    data_filt.relax(j).HR = HR_filt_relax;
    data_filt.relax(j).GSR = GSR_filt_relax;
    data_filt.relax(j).stress = stress_relax;
    
    % Hanoi1
    HR_orig = data.hanoi1(j).HR;
    GSR_orig = data.hanoi1(j).GSR;
    stress_hanoi1 = data.hanoi2(j).stress; 
    
    [HR_filt_hanoi1, GSR_filt_hanoi1] = filter_data(HR_orig, GSR_orig, 'spline');
    
    data_filt.hanoi1(j).HR = HR_filt_hanoi1;
    data_filt.hanoi1(j).GSR = GSR_filt_hanoi1;
    data_filt.hanoi1(j).stress = stress_hanoi1;
    
    % Hanoi2
    HR_orig = data.hanoi2(j).HR;
    GSR_orig = data.hanoi2(j).GSR;
    stress_hanoi2 = data.hanoi2(j).stress; 
    
    % Usa 'linear' come interpolazione perchè la 'spline' dà problemi
    [HR_filt_hanoi2, GSR_filt_hanoi2] = filter_data(HR_orig, GSR_orig, 'linear');
    
    data_filt.hanoi2(j).HR = HR_filt_hanoi2;
    data_filt.hanoi2(j).GSR = GSR_filt_hanoi2;
    data_filt.hanoi2(j).stress = stress_hanoi2;
end

clear HR_orig GSR_orig stress_relax stress_hanoi1 stress_hanoi2

dataset = [];

%% Effettua la media sulle finestre temporali di 100 valori
for j = patient
    dataset_relax = [];
    dataset_hanoi1 = [];
    dataset_hanoi2 = [];
    
    finestra_temporale = 100; % GSR campionato a 5 Hz, quindi 5 dati = 1 sec
    
    % Relax
    for i = 1:length(data_filt.relax(j).HR)-finestra_temporale+1
        HR_median_relax = mean(data_filt.relax(j).HR(i:i+finestra_temporale-1));
        GSR_median_relax = mean(data_filt.relax(j).GSR(i:i+finestra_temporale-1));
        stress_relax = data.relax(j).stress;
        cluster_relax = cluster(stress_relax);
        dataset_relax(i, :) = [HR_median_relax, GSR_median_relax, stress_relax, cluster_relax];
    end
    
    % Hanoi1
    for i = 1:length(data_filt.hanoi1(j).HR)-finestra_temporale+1
        HR_median_hanoi1 = mean(data_filt.hanoi1(j).HR(i:i+finestra_temporale-1));
        GSR_median_hanoi1 = mean(data_filt.hanoi1(j).GSR(i:i+finestra_temporale-1));
        stress_hanoi1 = data.hanoi1(j).stress;
        cluster_hanoi1 = cluster(stress_hanoi1);
        dataset_hanoi1(i, :) = [HR_median_hanoi1, GSR_median_hanoi1, stress_hanoi1, cluster_hanoi1];
    end
    
    % Hanoi2
    for i = 1:length(data_filt.hanoi2(j).HR)-finestra_temporale+1
        HR_median_hanoi2 = mean(data_filt.hanoi2(j).HR(i:i+finestra_temporale-1));
        GSR_median_hanoi2 = mean(data_filt.hanoi2(j).GSR(i:i+finestra_temporale-1));
        stress_hanoi2 = data.hanoi2(j).stress;
        cluster_hanoi2 = cluster(stress_hanoi2);
        dataset_hanoi2(i, :) = [HR_median_hanoi2, GSR_median_hanoi2, stress_hanoi2, cluster_hanoi2]; 
    end
    
    temp = [dataset_relax; dataset_hanoi1; dataset_hanoi2];
    dataset = [dataset; temp];
end

% Un po' di pulizia
clear i j stress_relax stress_hanoi1 stress_hanoi2 
clear HR_filt_relax GSR_filt_relax HR_filt_hanoi1 GSR_filt_hanoi1 HR_filt_hanoi2 GSR_filt_hanoi2 
clear dataset_relax dataset_hanoi1 dataset_hanoi2 temp
clear cluster_relax cluster_hanoi1 cluster_hanoi2

% Logaritmo GSR, da scommentare nel caso serva
dataset(:,2) = log(dataset(:,2));

% Normalizzazione di HR e GSR tra 0 e 1
% TODO: sarebbe comodo avere delle variabili da usare al posto dei numeri
% quando si vogliono selezionare delle colonne di 'dataset'.
% Esempio: "dataset(:,HR)" per selezione l'HR invece che "dataset(:,1)"
dataset(:,1) = scaleData(dataset(:,1));
dataset(:,2) = scaleData(dataset(:,2));

% Shuffle dei dati
datasetrandom = dataset(randperm(length(dataset)), :);

% Da scommentare solo in caso di bisogno
%csvwrite(strcat(dataset_path,'dataset_stress.csv'), dataset);
%csvwrite(strcat(dataset_path,'shuffleData.csv'), datasetrandom);