function y=myBitXor(in,Temp)
[m,n]=size(in);
y=zeros(m,n);
for i=1:m
    for j=1:n
        if in(i,j)==Temp(i,j)
            y(i,j)=0;
        else
            y(i,j)=1;
        end
    end
end