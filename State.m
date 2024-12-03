function Out=State(x,LEs)
ee=0.01;
if LEs(1)>ee && LEs(2)>ee
    Out=20;%超混沌
elseif LEs(1)>ee && abs(LEs(2))<ee
    Out=19;%混沌
elseif  abs(LEs(1))<ee 
    Out=18;%拟周期
else%周期态；涉及到序列
    xtemp=[];
     for i=2:length(x)-1
         if x(i)>=x(i-1) && x(i)>=x(i+1)
             xtemp=[xtemp,x(i)];
         end
     end
     
     data=xtemp;
     xtemp=[];

     for i=2:length(data)-1
         if data(i)>=data(i-1) && data(i)>=data(i+1)
             xtemp=[xtemp,data(i)];
         end
     end
     if isempty(xtemp)
         Out=1;
     else
        data=xtemp;
%     ff=tabulate(categorical(data));
        ff=tabulate(data);
        [m,n]=size(ff);
        if m>=10
            m=10;
        end
        Out=m;
     end
end