function [y,q,Ly1,Ly2]=SineSquaredMemristorShuiyin(C,A1,y0,q0,N)
y=zeros(1,N);
q=y;
for i=1:1000
    y0=C*sin(A1*(q0^2-1)*y0);
    q0=q0+y0;
end
y(1)=y0;
q(1)=q0;
Ly1=0;Ly2=0;
for i=2:N
    y(i)=C*sin(A1*(q(i-1)^2-1)*y(i-1));
    q(i)=q(i-1)+y(i-1);

     Ly1=Ly1+log(C*abs(sin(A1*(q(i-1)^2-1)*y(i-1))));
     Ly2=Ly2+log(abs(q(i-1)+y(i-1)));
end
Ly1=Ly1/(N-1);Ly2=Ly2/(N-1);