%As amplitude A increases, the system '8' loop line 
clc;clear
T=1:200000;
f=0.01;m0=0;B=0.1;

figure
A=1;I=A*sin(2*pi*f*T);
[V,q]=QuadraticMemristor(B,I,m0);
plot(I,V,'r','Linewidth',1)
hold on

A=2;I=A*sin(2*pi*f*T);
[V,q]=QuadraticMemristor(B,I,m0);
plot(I,V,'k','Linewidth',1)
hold on

A=3;I=A*sin(2*pi*f*T);
[V,q]=QuadraticMemristor(B,I,m0);
plot(I,V,'b','Linewidth',1)
xlabel('{\it I_n}')
ylabel('{\it V_n}')
grid minor
grid on
set(gca,'linewidth',0.5,'fontsize',12,'fontname','Times');
legend('{\it A}=1','{\it A}=2','{\it A}=3')
%----------------------------------------------
%As frequencies f increases, the system '8' loop line 
clc;clear
T=1:200000;
A=0.5;m0=0;B=0.1;

figure
f=0.003;I=A*sin(2*pi*f*T);
[V,q]=QuadraticMemristor(B,I,m0);
plot(I,V,'r','Linewidth',1)
hold on

f=0.005;I=A*sin(2*pi*f*T);
[V,q]=QuadraticMemristor(B,I,m0);
plot(I,V,'k','Linewidth',1)
hold on

f=0.01;I=A*sin(2*pi*f*T);
[V,q]=QuadraticMemristor(B,I,m0);
plot(I,V,'b','Linewidth',1)
xlabel('{\it I_n}')
ylabel('{\it V_n}')
grid minor
grid on
set(gca,'linewidth',0.5,'fontsize',12,'fontname','Times');
 legend('{\it f}=0.003','{\it f}=0.005','{\it f}=0.010')