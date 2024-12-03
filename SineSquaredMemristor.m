function [y,q,Ly]=SineSquaredMemristor(C,A,initial,N)
y=zeros(1,N);
q=y;
y(1)=initial(1);
q(1)=initial(2);
Q=eye(2);
ly1=0;ly2=0;
for i=2:N
    y(i)=C*sin(A*(q(i-1)^2-1)*y(i-1));
    q(i)=q(i-1)+y(i-1);
   
    J=[C*cos(A*(q(i-1)^2-1)*y(i-1))*(A*(q(i-1)^2-1)),C*cos(A*(q(i-1)^2-1)*y(i-1))*(2*A*q(i-1)*y(i-1));
        1,1];
    B=J*Q;
    [Q,R]=qr(B);
    ly1=ly1+log(abs(R(1,1)));
    ly2=ly2+log(abs(R(2,2)));
end
Ly=[ly1/N,ly2/N];