clc;clear
T = [-1 -1 1; 1 -1 1]';

J=imread('logo.png');
J=double(imresize(J(:,:,1),[64,64]));
figure
imshow(imresize(J,10))
%------数据转换----
for i=1:64
    for j=1:64
        if J(i,j)==0
            J(i,j)=-1;
        else
            J(i,j)=1;
        end
    end 
end
net = newhop(J);
W = net.LW{1,1};

J_noise=J;%扰动的矩阵
for i=1:64
    for j=1:64
        rrand=rand();
        if rrand<=0.01
           J_noise(i,j)=-J_noise(i,j);
        end
    end
end
figure
imshow(imresize(J_noise,10))
%--------------------------------------------------------------------------
noise1={(J_noise)'};%把图变为cell结构，并转置（横放图片排列）               
[Y,Af,E,perf]= sim(net,{64,1},{},noise1);%每64像素为一张图
J_Net=Y{1}';

for i=1:64
    for j=1:64
        if J_Net(i,j)>0
            J_Net(i,j)=1;
        else
            J_Net(i,j)=-1;
        end
    end
end
figure;imshow(imresize(J_Net,10))%放大10倍