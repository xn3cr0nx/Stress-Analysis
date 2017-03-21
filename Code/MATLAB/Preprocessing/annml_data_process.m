clear all
close all
clc

load('/home/patrick/Scrivania/Stress Analysis/Script/All.mat');

patient = 1:17;
patient(9) = [];

for j = patient
    HR_orig = data.relax(j).HR;
    GSR_orig = data.relax(j).GSR;
    stress_relax = data.relax(j).stress; 
    [HR_filt_relax, GSR_filt_relax] = filter_data(HR_orig, GSR_orig, 'linear');
    data_filt.relax(j).HR = HR_filt_relax;
    data_filt.relax(j).GSR = GSR_filt_relax;
    data_filt.relax(j).stress = stress_relax;
        
    HR_orig = data.hanoi1(j).HR;
    GSR_orig = data.hanoi1(j).GSR;
    stress_hanoi1 = data.hanoi2(j).stress; 
    [HR_filt_hanoi1, GSR_filt_hanoi1] = filter_data(HR_orig, GSR_orig, 'linear');
    data_filt.hanoi1(j).HR = HR_filt_hanoi1;
    data_filt.hanoi1(j).GSR = GSR_filt_hanoi1;
    data_filt.hanoi1(j).stress = stress_hanoi1;
       
    HR_orig = data.hanoi2(j).HR;
    GSR_orig = data.hanoi2(j).GSR;
    stress_hanoi2 = data.hanoi2(j).stress; 
    [HR_filt_hanoi2, GSR_filt_hanoi2] = filter_data(HR_orig, GSR_orig, 'linear');
    data_filt.hanoi2(j).HR = HR_filt_hanoi2;
    data_filt.hanoi2(j).GSR = GSR_filt_hanoi2;
    data_filt.hanoi2(j).stress = stress_hanoi2;
end

clear HR_orig GSR_orig stress_relax stress_hanoi1 stress_hanoi2


dataset = [];

%% effettuata la media sulle finestre temporali di 100 valori
for j = patient
    dataset_relax = [];
    dataset_hanoi1 = [];
    dataset_hanoi2 = [];
    for i = 1:length(data_filt.relax(j).HR)-100+1
        HR_median_relax = mean(data_filt.relax(j).HR(i:i+99));
        GSR_median_relax = mean(data_filt.relax(j).GSR(i:i+99));
        stress_relax = data.relax(j).stress;
        cluster_relax = cluster(stress_relax);
        dataset_relax(i, :) = [HR_median_relax, GSR_median_relax, stress_relax, cluster_relax];
    end
    for i = 1:length(data_filt.hanoi1(j).HR)-100+1
        HR_median_hanoi1 = mean(data_filt.hanoi1(j).HR(i:i+99));
        GSR_median_hanoi1 = mean(data_filt.hanoi1(j).GSR(i:i+99));
        stress_hanoi1 = data.hanoi1(j).stress;
        cluster_hanoi1 = cluster(stress_hanoi1);
        dataset_hanoi1(i, :) = [HR_median_hanoi1, GSR_median_hanoi1, stress_hanoi1, cluster_hanoi1];
    end
    for i = 1:length(data_filt.hanoi2(j).HR)-100+1
        HR_median_hanoi2 = mean(data_filt.hanoi2(j).HR(i:i+99));
        GSR_median_hanoi2 = mean(data_filt.hanoi2(j).GSR(i:i+99));
        stress_hanoi2 = data.hanoi2(j).stress;
        cluster_hanoi2 = cluster(stress_hanoi2);
        dataset_hanoi2(i, :) = [HR_median_hanoi2, GSR_median_hanoi2, stress_hanoi2, cluster_hanoi2]; 
    end
    temp = [dataset_relax; dataset_hanoi1; dataset_hanoi2];
    dataset = [dataset; temp];
end
    
datasetrandom = dataset(randperm(length(dataset)), :);

clear i j stress_relax stress_hanoi1 stress_hanoi2 
clear HR_filt_relax GSR_filt_relax HR_filt_hanoi1 GSR_filt_hanoi1 HR_filt_hanoi2 GSR_filt_hanoi2 
clear dataset_relax dataset_hanoi1 dataset_hanoi2 temp
clear cluster_relax cluster_hanoi1 cluster_hanoi2

csvwrite('dataset_stress.csv', dataset);
csvwrite('dataset_random.csv', datasetrandom);