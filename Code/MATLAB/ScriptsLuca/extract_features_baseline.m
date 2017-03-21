function [features]= extract_features_baseline(HR_IBI, BT)


HR_IBI_norm=(HR_IBI-mean(HR_IBI))./std(HR_IBI);
pari=mod(numel(HR_IBI),2);
k=1:2:numel(HR_IBI);
j=2:2:numel(HR_IBI);
if pari~=0 
    k=k(1:end-1);
end

% HR Time-features
features(1,1)=std(HR_IBI);                                  %SDNN SDRR
features(1,2)=std(diff(HR_IBI));                            %SDSD
features(1,3)=rms(diff(HR_IBI));                            %RMSSD
features(1,4)=sum(abs(diff(HR_IBI))>0.05);                    %NN50
features(1,5)=sum(diff(HR_IBI)>0.05);                         %dNN50
features(1,6)=sum(diff(HR_IBI)<0.05);                         %aNN50
features(1,7)=sum(abs(diff(HR_IBI))>0.05)./numel(HR_IBI);     %pNN50
features(1,8)=mean(abs(diff(HR_IBI)));                      %sigmax   
features(1,9)=mean(abs(diff(HR_IBI_norm)));                 %Nsigmax
features(1,10)=mean(abs(HR_IBI(j)-HR_IBI(k)));              %gammax
features(1,11)=mean(abs(HR_IBI_norm(j)-HR_IBI_norm(k)));    %Ngammax

% HR Frequency-features
LF = bandpower(HR_IBI,2,[0.04 0.15]);                    %fs=2Hz?                    
features(1,12)=LF;                                          %P(LF)  

HF = bandpower(HR_IBI,2,[0.15 0.4]);                     %fs=2Hz?       
features(1,13)=HF;                                          %P(HF)

features(1,14)=LF/HF;                                       %P(LF)/P(HF)

features(1,15)=LF/(LF+HF);                                  %P(LF)/(P(LF)+P(HF))

features(1,16)=HF/(LF+HF);                                  %P(HF)/(P(LF)+P(HF))

features(1,17)=bandpower(HR_IBI,2,[0.04 0.4]);           %P(TP)

% HR Poincare Plot Features
SDSD=std(diff(HR_IBI));
SD1=sqrt(1/2*(SDSD^2)); 
features(1,18)=SD1;                                         %SD1

SDRR=std(HR_IBI); 
SD2=sqrt(2*SDRR^2-1/2*(SDSD^2));
features(1,19)=SD2;                                         %SD2

features(1,20)=SD1/SD2;                                     %SD1/SD2

% HR extra features
features(1,21)=mean(HR_IBI);                                %MRR


% SC features
ts=1/5; %%%% gradient o diff

features(1,22)=0; 
features(1,23)=0;
features(1,24)=0; 
features(1,25)=0; 

% SCR (first 50s, 4Hz)
%SC_cut=SC(1:500); %1:200
%[peak,loc]= findpeaks(SC_cut,'MinPeakHeight',max(SC_cut)*0.1);
features(1,26)=0;
features(1,27)=0;
features(1,28)=0;

% Body Temperature (first 50s, 4Hz)
BT_cut=BT(:);  %1:200

features(1,29)=0;
features(1,30)=0;

end