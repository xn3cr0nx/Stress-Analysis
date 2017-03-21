
function z = mutInfo2(x, y)

% x=[0 0 0 0 0 0];
% x=x';
% y=[1 2 3 4 5 6];
% y=y';
% optimal n of bins for each variable
n = length(x);
maxmin_range = max(x)-min(x);
qq=(2.0*iqr(x)*n^(-1/3)+10^2);
if qq==0 fd_bins==1; end
fd_bins1 = ceil(maxmin_range/qq)
% Freedman?Diaconis
n = length(y);
maxmin_range = max(y)-min(y);
fd_bins2 =ceil(maxmin_range/(2.0*iqr(y)*n^(-1/3)))
% Freedman?Diaconis
% and use the average...
fd_bins = ceil((fd_bins1+fd_bins2)/2);
%fd_bins=10;

[hdat1,x1] = hist(x,fd_bins);
[hdat2,x2] = hist(y,fd_bins);

hdat1 = hdat1./sum(hdat1);
hdat2 = hdat2./sum(hdat2);

Hx=-sum(hdat1.*log2(hdat1 + eps));
Hy=-sum(hdat2.*log2(hdat2 + eps));

% jointprobs=zeros(fd_bins);
% for i1=1:fd_bins
% for i2=1:fd_bins
% jointprobs(i1,i2) =sum(hdat1(i1) & hdat2(i2));
% end
% end
[hjointprobs, xc]=hist3([x y],[fd_bins fd_bins]);
hjointprobs=hjointprobs./(sum(sum(hjointprobs)));

Hxy=-sum(sum((hjointprobs.*log2(hjointprobs + eps))));
% 
% % for i=1:2
% % eval([ 'entro(' num2str(i) ') = ?sum(hdat' num2str(i)
% % '.*log2(hdat' num2str(i) '+eps));' ]);
% % end
% 
% 
% % 
z = Hx+Hy-Hxy;
z = max(0,z);


% lh1 = log(sum(hjointprobs,1));
% lh2 = log(sum(hjointprobs,2));
% z = sum(sum(hjointprobs .* bsxfun(@minus,bsxfun(@minus,log(hjointprobs+eps),lh1),lh2) ));

end



