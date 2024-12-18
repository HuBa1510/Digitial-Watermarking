%---Phase diagram---------
clc;clear
N=10000;
A1=1.8;C=1.55;
initial=[0.5,0.01];

[y,q,Ly]=SineSquaredMemristor(C,A1,initial,N);
figure
plot(q(1000:end),y(1000:end),'.k')
xlabel('{{\it q}}')
ylabel('{\it y_n}')
grid minor
grid on
set(gca,'linewidth',0.5,'fontsize',12,'fontname','Times');
%---Iterative graph---------
% clc;clear
% A1=1.8;C=1.55;
% initial=[0.5,0.01];
% N=5000;
% [y,q,Ly]=SineSquaredMemristor(C,A1,initial,N);
% figure
% plot(y(1000:end-1),y(1001:end),'.b')
% xlabel('{{\it y}_{{\it n}-1}}')
% ylabel('{\it y_n}')
% grid minor
% grid on
% set(gca,'linewidth',0.5,'fontsize',12,'fontname','Times');
%----1D-phase diagram&LEs----------------------
clc;clear
N=5000; 
Num=1000;
C=1.55; 
A_range=linspace(0.5,1.8,Num);
initial=[0.5,0.01];
Lyy=zeros(Num,2);
figure
for i=1:Num
    A=A_range(i);
    [y,q,Ly]=SineSquaredMemristor(C,A,initial,N);
    plot(A,y(end-50:end),'.r','MarkerSize',3)
    Lyy(i,:)=Ly;
    hold on
end
set(gca,'XTick',0.5:0.2:1.8)
xlim([0.5,1.8])
ylim([-2,2])
xlabel('{{\it A}}')
ylabel('{\it y_n}')
grid minor
grid on
set(gca,'linewidth',0.5,'fontsize',12,'fontname','Times');

figure
plot(A_range,Lyy(:,1),'r','linewidth',1)
hold on
plot(A_range,Lyy(:,2),'b','linewidth',1)
h1=0.5;h2=1.8;
g1=0;g2=0;
line([h1, h2], [g1, g2])
plot([h1, h2], [g1, g2],'k','linewidth',0.5)
set(gca,'XTick',0.5:0.2:1.8)
xlim([0.5,1.8])
xlabel('{{\it A}}')
ylabel('{\it y_n}')
grid minor
grid on
set(gca,'linewidth',0.5,'fontsize',12,'fontname','Times');
%2D-Phase diagram---------------------------------------------------------
clc;clear
N=5000;
Num=200;
A_range=linspace(0.8,2,Num); 
C_range=linspace(1.4,2.2,Num);
initial=[0.5,0.01];
Lyy=zeros(Num,3);
Statee=zeros(Num);
for i=1:Num
    A=A_range(i);
    for j=1:Num
        C=C_range(j);
        [y,q,Ly]=SineSquaredMemristor(C,A,initial,N);
        Out=State(y(1000:end),Ly);
        Statee(i,j)=Out;
    end
    %disp(i);
end
Stateee=Statee;

figure
for i=1:Num
    for j=1:Num
       if  Statee(i,j)==20
           plot(A_range(i),C_range(j),'.r')%Red---Hyperchaos
           hold on
       elseif Statee(i,j)==19
            plot(A_range(i),C_range(j),'.b')%Blue---Chaos
            hold on
       elseif Statee(i,j)==18
            plot(A_range(i),C_range(j),'.g')%Green---Quasi periodicity
            hold on
       elseif Statee(i,j)==2 ||Statee(i,j)==3
           plot(A_range(i),C_range(j),'.y')%Yellow---Period-2
           hold on
       elseif Statee(i,j)==4 ||Statee(i,j)==5
           plot(A_range(i),C_range(j),'.m')%Purple---Period-4
           hold on   
        elseif Statee(i,j)==6 ||Statee(i,j)==7
           plot(A_range(i),C_range(j),'.c')%Cyan---Period-6
           hold on
         elseif Statee(i,j)==8 ||Statee(i,j)==9
           plot(A_range(i),C_range(j),'.','color',[0.5,0.5,0.5])%Period-8
           hold on
       else
           plot(A_range(i),C_range(j),'.k')%Black-Other
           hold on
        end
    end
end
xlim([0.8,2])
ylim([1.4,2.2])
set(gca,'XTick',0.8:0.2:2)
set(gca,'YTick',1.4:0.2:2.2)
colorbar;
xlabel('{{\it A}}')
ylabel('{{\it B}}')
set(gca,'linewidth',0.5,'fontsize',12,'fontname','Times');

colorbar;
colormap(gca, [
    0 0 0;            % LE1=0，Black
    0.5 0.5 0.5;   % LE1=1，Gray
    0 1 1;            % LE1=2，Cyan
    0.4 0.1 0.8;   % LE1=3，Pueple
    1 1 0;            % LE1=4，Yellow    
    0 1 0;            % LE1=5，Green
    0 0 1;            % LE1=6，Blue
    1 0 0;            % LE1=7，Red
]);
colorbar ('TickLabels',{'OT','P08','P06','P04','P02','QP','CH','HC'})