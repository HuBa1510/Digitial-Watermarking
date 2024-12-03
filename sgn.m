function y_out=sgn(y_in)
[m,n]=size(y_in);
y_out=zeros(size(y_in));
for i=1:m
    for j=1:n
        if y_in(i,j)>0
            y_out(i,j)=1;
        else
            y_out(i,j)=0;
        end
    end
end
