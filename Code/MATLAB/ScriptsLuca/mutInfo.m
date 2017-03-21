function z = mutInfo(x, y)
% Compute mutual information I(x,y) of two discrete variables x and y.
% Input:
%   x, y: two integer vector of the same length 
% Output:
%   z: mutual information z=I(x,y)
% Written by Mo Chen (sth4nth@gmail.com).
assert(numel(x) == numel(y));
n = numel(x);
%n=floor(n);
x = reshape(x,1,n);
y = reshape(y,1,n);

l = min(min(x),min(y));
x = x-l+1;
y = y-l+1;
k = max(max(x),max(y));
% k=floor(k);
% k=ceil(k);
k=round(k);
% x=floor(x);
% y=floor(y);

idx = 1:n;
%idx=floor(idx);
%Mx=sparse(idx,1,x,n,k,n); 
y
x
n
k
My = sparse(idx,round(y),1,n,k,n);
Mx = sparse(idx,round(x),1,n,k,n);
Pxy = nonzeros(Mx'*My/n); %joint distribution of x and y
Hxy = -dot(Pxy,log2(Pxy));

Px = nonzeros(mean(Mx,1));
Py = nonzeros(mean(My,1));

% entropy of Py and Px
Hx = -dot(Px,log2(Px));
Hy = -dot(Py,log2(Py));
% mutual information
z = Hx+Hy-Hxy;
z = max(0,z);