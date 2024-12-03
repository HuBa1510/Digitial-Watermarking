close all
a=0:0.25:4;%分数阶傅里叶变换阶数

%生成一个窗函数
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
