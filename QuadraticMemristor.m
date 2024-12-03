function [V,q]=QuadraticMemristor(B,I,m0)
dot=length(I);
q=zeros(1,dot);
M=q;
V=q;
for t=1:dot
    m0=m0+I(t);
    q(t)=m0;
    M(t)=B*(q(t)^2-1);  
    V(t)=M(t)*I(t);
end