function W=MyHopfield(T)
[n,m]=size(T);
W= zeros(n,n);
for i=1:m
    W=W+T(:,i)*T(:,i)';
end
W=(1/n)*(W-m*eye(n, n));
end