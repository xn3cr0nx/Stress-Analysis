function [feat_relax]= preprocessing_relax(data, len)
%load HR_baseline SC_baseline, BT_baseline....


    

check= find(data.RR(len,:)==0);
if length(check)==9 len=len-1;
end
for count=1:len


    RR(count,:)=data.RR(count,:);
        SC(count,:)=data.GSR(count,:);
        BT(count,:)=data.ST(count,:);

    if count~=len
        
        
    else
        aRR=find(data.RR(count,:)==0);
        aRR
        if isempty(aRR)
            RR(count,:)=data.RR(count,:);
            SC(count,:)=data.GSR(count,:);
            BT(count,:)=data.ST(count,:);
            
        else
            data.RR(count,1:aRR(1)-1)
            RR(count,:)=data.RR(count,1:aRR(1)-1);
            SC(count,:)=data.GSR(count,1:aRR(1)-1);
            BT(count,:)=data.ST(count,1:aRR(1)-1);
            
        end
    end
    
clear aRR check    

%% Features etxraction
feat_relax = extract_features(RR, SC, BT);

end


end