%% load data for each subject and preprocessing: 17 subjects
clear all
close all
clc


load('All.mat');



%% Resampling spline

sub=[1:17];

for j=sub
    
    nHRbase=1:1:length(data.relax(j).HR);
    nGSRbase=1:1:length(data.relax(j).GSR);
    nRRbase=1:1:length(data.relax(j).RR);
    nBTbase=1:1:length(data.relax(j).ST);
    
    nHRhanoi1=1:1:length(data.hanoi1(j).HR);
    nGSRhanoi1=1:1:length(data.hanoi1(j).GSR);
    nRRhanoi1=1:1:length(data.hanoi1(j).RR);
    nBThanoi1=1:1:length(data.hanoi1(j).ST);
    
    nHRhanoi2=1:1:length(data.hanoi2(j).HR);
    nGSRhanoi2=1:1:length(data.hanoi2(j).GSR);
    nRRhanoi2=1:1:length(data.hanoi2(j).RR);
    nBThanoi2=1:1:length(data.hanoi2(j).ST);
    
    nHRbasesp=1:(nHRbase(end)-1)/(nGSRbase(end)-1):nHRbase(end);
    nRRbasesp=1:(nRRbase(end)-1)/(nGSRbase(end)-1):nRRbase(end);
    nBTbasesp=1:(nBTbase(end)-1)/(nGSRbase(end)-1):nBTbase(end);
    
    nHRhanoi1sp=1:(nHRhanoi1(end)-1)/(nGSRhanoi1(end)-1):nHRhanoi1(end);
    nRRhanoi1sp=1:(nRRhanoi1(end)-1)/(nGSRhanoi1(end)-1):nRRhanoi1(end);
    nBThanoi1sp=1:(nBThanoi1(end)-1)/(nGSRhanoi1(end)-1):nBThanoi1(end);
    
    nHRhanoi2sp=1:(nHRhanoi2(end)-1)/(nGSRhanoi2(end)-1):nHRhanoi2(end);
    nRRhanoi2sp=1:(nRRhanoi2(end)-1)/(nGSRhanoi2(end)-1):nRRhanoi2(end);
    nBThanoi2sp=1:(nBThanoi2(end)-1)/(nGSRhanoi2(end)-1):nBThanoi2(end);
        
    
    data_filt.relax(j).HR=zoh(nHRbase,data.relax(j).HR,nHRbasesp);
    data_filt.relax(j).RR=zoh(nRRbase,data.relax(j).RR,nRRbasesp);
    data_filt.relax(j).ST=zoh(nBTbase,data.relax(j).ST,nBTbasesp);
    
    data_filt.hanoi1(j).HR=zoh(nHRhanoi1,data.hanoi1(j).HR,nHRhanoi1sp);
    data_filt.hanoi1(j).RR=zoh(nRRhanoi1,data.hanoi1(j).RR,nRRhanoi1sp);
    data_filt.hanoi1(j).ST=zoh(nBThanoi1,data.hanoi1(j).ST,nBThanoi1sp);
    
    data_filt.hanoi2(j).HR=zoh(nHRhanoi2,data.hanoi2(j).HR,nHRhanoi2sp);
    data_filt.hanoi2(j).RR=zoh(nRRhanoi2,data.hanoi2(j).RR,nRRhanoi2sp);
    data_filt.hanoi2(j).ST=zoh(nBThanoi2,data.hanoi2(j).ST,nBThanoi2sp);
    
    outlierR=find(abs(diff(data.relax(j).GSR))>300);
    numGSRbase=nGSRbase;
    numGSRbase(outlierR+1)=[];
    data_filt.relax(j).GSR=interp1(numGSRbase,data.relax(j).GSR(numGSRbase),nGSRbase,'spline');
    
    outlierH=find(abs(diff(data.hanoi1(j).GSR))>300);
    numGSRhanoi1=nGSRhanoi1;
    numGSRhanoi1(outlierH+1)=[];
    data_filt.hanoi1(j).GSR=interp1(numGSRhanoi1,data.hanoi1(j).GSR(numGSRhanoi1),nGSRhanoi1,'spline');
    
    outlierHH=find(abs(diff(data.hanoi2(j).GSR))>300);
    numGSRhanoi2=nGSRhanoi2;
    numGSRhanoi2(outlierHH+1)=[];
    data_filt.hanoi2(j).GSR=interp1(numGSRhanoi2,data.hanoi2(j).GSR(numGSRhanoi2),nGSRhanoi2,'spline');
    
%     figure
%     plot(nRRbase,data.relax(j).RR,'r')
%     hold on
%     plot(nRRbasesp,data_filt.relax(j).RR,'b')
    
    data_filt.relax(j).HR=smooth(data_filt.relax(j).HR,5);
    data_filt.relax(j).GSR=smooth(data_filt.relax(j).GSR,5);
    data_filt.relax(j).RR=smooth(data_filt.relax(j).RR,5);
    data_filt.relax(j).ST=smooth(data_filt.relax(j).ST,5);

    data_filt.hanoi1(j).HR=smooth(data_filt.hanoi1(j).HR,5);
    data_filt.hanoi1(j).GSR=smooth(data_filt.hanoi1(j).GSR,5);
    data_filt.hanoi1(j).RR=smooth(data_filt.hanoi1(j).RR,5);
    data_filt.hanoi1(j).ST=smooth(data_filt.hanoi1(j).ST,5);
    
    data_filt.hanoi2(j).HR=smooth(data_filt.hanoi2(j).HR,5);
    data_filt.hanoi2(j).GSR=smooth(data_filt.hanoi2(j).GSR,5);
    data_filt.hanoi2(j).RR=smooth(data_filt.hanoi2(j).RR,5);
    data_filt.hanoi2(j).ST=smooth(data_filt.hanoi2(j).ST,5);
    
    data_wind.relax(j).HR=vec2mat(data_filt.relax(j).HR,10);
    data_wind.relax(j).GSR=vec2mat(data_filt.relax(j).GSR,10);
    data_wind.relax(j).RR=vec2mat(data_filt.relax(j).RR,10);
    data_wind.relax(j).ST=vec2mat(data_filt.relax(j).ST,10);
    data_wind.hanoi1(j).HR=vec2mat(data_filt.relax(j).HR,10);
    data_wind.hanoi1(j).GSR=vec2mat(data_filt.relax(j).GSR,10);
    data_wind.hanoi1(j).RR=vec2mat(data_filt.relax(j).RR,10);
    data_wind.hanoi1(j).ST=vec2mat(data_filt.relax(j).ST,10);
    data_wind.hanoi2(j).HR=vec2mat(data_filt.hanoi2(j).HR,10);
    data_wind.hanoi2(j).GSR=vec2mat(data_filt.hanoi2(j).GSR,10);
    data_wind.hanoi2(j).RR=vec2mat(data_filt.hanoi2(j).RR,10);
    data_wind.hanoi2(j).ST=vec2mat(data_filt.hanoi2(j).ST,10);
    
    len_relax(j)=size(data_wind.relax(j).RR,1);
    len_hanoi1(j)=size(data_wind.hanoi1(j).RR,1);
    len_hanoi2(j)=size(data_wind.hanoi2(j).RR,1);
    
    
end
 
%% FERMATI

for i=sub  
    
      
    [featrelax]=extract_features(data_wind.relax(i),len_relax(i));
    [feathanoi1]=extract_features(data_wind.hanoi1(i),len_hanoi1(i));          
    [feathanoi2]=extract_features(data_wind.hanoi2(i),len_hanoi2(i));          

    relaxiamo{i,1}=featrelax;
    hanoiamo1{i,1}=feathanoi1;
    hanoiamo2{i,1}=feathanoi2;
    
end    

relaxx=cell2mat(relaxiamo);
%hanoiamo11=cell2mat(hanoiamo1);
hanoiamo22=cell2mat(hanoiamo2);

%hanoiamo11=[hanoiamo11 2*ones(size(hanoiamo11,1),1)];

dataready=[relaxx;hanoiamo22];
response=[ones(size(relaxx,1),1); 2*ones(size(hanoiamo22,1),1)];

dataALL=[dataready response];



%response=[repmat([0 1],size(relaxx,1),1); repmat([1 0],size(hanoiamo22,1),1)];



% nfeat=27;
% Y=dataready(:,end);
% 
% for i=1:nfeat
%     i
%     A=dataready(:,i);
%     
%     z(1,i)=kernelmi(A',Y');
%      
% end 
% 
% 
% for i=1:nfeat
%     
%     A=dataready(:,i);
%     
%     z2(1,i)=mutInfo2(A,Y);
%      
% end 
% 
% for i=1:nfeat
%     
%     A=dataready(:,i);
%     
%     cc(1,i)=corr(A,Y);
%      
% end 
% 
% clearvars -except dataready z z2 cc
% % 
% % [aa, idx]=sort(z,'descend');
% % 
% % figure
% % plot(z)
% % hold on
% % plot(idx(1:14),aa(1:14),'*r')
% 
% [aa, idx]=sort(z2,'descend');
% 
% figure
% plot(z2)
% hold on
% plot(idx(1:10),aa(1:10),'*r')
% 
% [aa, idx]=sort(cc,'descend');
% 
% figure
% plot(cc)
% hold on
% plot(idx(1:10),aa(1:10),'*r')
