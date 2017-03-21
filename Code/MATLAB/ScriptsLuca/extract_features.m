function [features]= extract_features(data,len)

check= find(data.RR(len,:)==0);
if length(check)==9 
len=len-1;
end

for i=1:len

    if i~=len
        cut=1:10;
        
    else
        aRR=find(data.RR(i,cut)==0);
        
        if isempty(aRR)
            cut=1:10;
            
        else
            cut=1:aRR(1)-1;
        end
    end

RR(i,cut)=data.RR(i,cut);
GSR(i,cut)=data.GSR(i,cut);
BT(i,cut)=data.ST(i,cut);
    
%Normalization
RR_norm(i,cut)=(RR(i,cut)-mean(RR(i,cut)))./std(RR(i,cut));
GSR_norm(i,cut)=(GSR(i,cut)-mean(GSR(i,cut)))./std(GSR(i,cut));
BT_norm(i,cut)=(BT(i,cut)-mean(BT(i,cut)))./std(BT(i,cut));

pari=mod(numel(RR(i,cut)),2);
k=1:2:numel(RR(i,cut));
j=2:2:numel(RR(i,cut));
if pari~=0 
    k=k(1:end-1);
end

% HR Time-features
features(i,1)=std(RR(i,cut));                                  %SDNN SDRR
features(i,2)=std(diff(RR(i,cut)));                            %SDSD
features(i,3)=rms(diff(RR(i,cut)));                            %RMSSD
features(i,4)=sum(abs(diff(RR(i,cut)))>0.05);                    %NN50
features(i,5)=sum(diff(RR(i,cut))>0.05);                         %dNN50
features(i,6)=sum(diff(RR(i,cut))<0.05);                         %aNN50
features(i,7)=sum(abs(diff(RR(i,cut)))>0.05)./numel(RR(i,cut));     %pNN50
features(i,8)=mean(abs(diff(RR(i,cut))));                      %sigmax   
features(i,9)=mean(abs(diff(RR_norm(i,cut))));                 %Nsigmax
features(i,10)=mean(abs(RR(i,j)-RR(i,k)));              %gammax
features(i,11)=mean(abs(RR_norm(i,j)-RR_norm(i,k)));    %Ngammax

% HR Frequency-features
LF = bandpower(RR(i,cut),2,[0.04 0.15]);                    %fs=2Hz?                    
features(i,12)=LF;                                          %P(LF)  

HF = bandpower(RR(i,cut),2,[0.15 0.4]);                     %fs=2Hz?       
features(i,13)=HF;                                          %P(HF)

features(i,14)=LF/HF;                                       %P(LF)/P(HF)

features(i,15)=LF/(LF+HF);                                  %P(LF)/(P(LF)+P(HF))

features(i,16)=HF/(LF+HF);                                  %P(HF)/(P(LF)+P(HF))

features(i,17)=bandpower(RR(i,cut),2,[0.04 0.4]);           %P(TP)

% HR Poincare Plot Features
SDSD=std(diff(RR(i,cut)));
SD1=sqrt(1/2*(SDSD^2)); 
features(i,18)=SD1;                                         %SD1

SDRR=std(RR(i,cut)); 
SD2=sqrt(2*SDRR^2-1/2*(SDSD^2));
features(i,19)=SD2;                                         %SD2

features(i,20)=SD1/SD2;                                     %SD1/SD2

% HR extra features
features(i,21)=mean(RR(i,cut));                                %MRR


% SC features
ts=1/5; %%%% gradient o diff

features(i,22)=mean(GSR(i,cut)); 
features(i,23)=std(GSR(i,cut)); 
features(i,24)=mean(gradient(GSR(i,cut))/ts); 
features(i,25)=rms(gradient(GSR(i,cut))/ts); 

% SCR (first 50s, 4Hz)
% SC_cut=SC(1:500); %1:200
% [peak,loc]= findpeaks(SC_cut,'MinPeakHeight',max(SC_cut)*0.1);
% features(1,25)=mean(peak);
% features(1,26)=mean(diff(loc));
% features(1,27)=max(peak);


% Body Temperature (first 0.05s, 4Hz)
features(i,26)=mean(BT(i,cut));
features(i,27)=max(BT(i,cut));

end

end