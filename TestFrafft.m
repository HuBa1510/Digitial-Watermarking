close all
a=0:0.25:4;%�����׸���Ҷ�任����

%����һ��������
fx=zeros(500,1);
fx(150:250)=1;
figure
for ai=a
    F=myfrft(fx,ai);
    plot(abs(F))
%     title('a='+num2str(ai))
    hold on
    grid on
    ylim([0,5])
end
