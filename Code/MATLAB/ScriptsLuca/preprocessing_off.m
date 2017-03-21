function [feat_out_off]= preprocessing_off(data, data_wind, len)
%load HR_baseline SC_baseline, BT_baseline....


    
HR_baseline=data.HR_baseline;
HR_baseline=60./HR_baseline;  %HR in ms
BT_baseline=data.BT_baseline;

feat_baseline= extract_features_baseline(HR_baseline, BT_baseline);

check= find(data_wind.RR_off(len,:)==0);
if length(check)==9 len=len-1;
end
for count=1:len


if count~=len
    HR_off=data_wind.RR_off(count,:);
    SC_off=data_wind.GSR_off(count,:);
    BT_off=data_wind.BT_off(count,:);

else
    aHRoff=find(data_wind.RR_off(count,:)==0);

    if isempty(aHRoff)
        HR_off=data_wind.RR_off(count,:);
        SC_off=data_wind.GSR_off(count,:);
        BT_off=data_wind.BT_off(count,:);

    else     
        HR_off=data_wind.RR_off(count,1:aHRoff(1)-1);
        SC_off=data_wind.GSR_off(count,1:aHRoff(1)-1);
        BT_off=data_wind.BT_off(count,1:aHRoff(1)-1);  
        
    end    
end     
    
clear aHRoff check
%% Features calculation


% feat_state_on= extract_features(HR_on, SC_on, BT_on);
feat_state_off= extract_features(HR_off, SC_off, BT_off);


%diff features normalization
i=[4 5 6 21];
feat_base=feat_baseline(1,i);
% feat_on=feat_state_on(1,i);
feat_off=feat_state_off(1,i);

% diff_feat_on=feat_on-feat_base;
diff_feat_off=feat_off-feat_base;


%std_baseline
% num1=numel(HR_on);
num2=numel(HR_off);
HR_baseline_mean=feat_baseline(1,21);

a=sum((HR_off-HR_baseline_mean).^2);

% DSD_on=sqrt((1/(num1-1))*sum((HR_on-HR_baseline_mean).^2));
DSD_off=sqrt((1/(num2-1)).*sum((HR_off-HR_baseline_mean).^2));

%ratio SD1 SD2
del=[18 19];
feat_base2=feat_baseline(1,del);
% feat_on2=feat_state_on(1,j);
feat_off2=feat_state_off(1,del);

% ratio_feat_on=feat_on2/feat_base2;
ratio_feat_off=feat_off2./feat_base2;

% feat_state_on=[feat_state_on diff_feat_on DSD_on ratio_feat_on];
% feat_baseline=[feat_baseline 0 0 0 0 0 0 ];
feat_state_off=[feat_state_off diff_feat_off DSD_off ratio_feat_off];
feat_out_off(count,:)=feat_state_off;

end


feat_baseline=[feat_baseline ];

end