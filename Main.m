clc;clear
%https://blog.csdn.net/m0_59833680/article/details/119908381
I=imread('Peppers.bmp');
figure;imshow(I);

J=imread('logo.png');
J=double(imresize(J(:,:,1),[64,64]));%对J选择通道1(假设为RGB)，并缩放为64*64);
J=sgn(J);%转换为0,1值
figure;imshow(imresize(J,8));%图片扩大十倍展示

%混沌序列准备------
%[y,Ly]=Logistic(4,0.55,100000);
[y,q,Ly1,Ly2]=SineSquaredMemristorShuiyin(1.55,1.8,0.4,0.1,100000);
y=y(1000:end);
Seq1=y(1:64*64);%从y中提取64*64=4096个值，序列1
Seq2=y(64*64+1:64*64*2);%从y中提取接下来的4096个值，从4097到64*64*2=8192，序列2
%-----------水印数据加密---------
J_Out=ImageEncry(J,Seq1,Seq2);%水印图像加密
% J_Out=J;

size=512; 
N=64;% 块的数量 是否应该是64
K=8;  % 块的大小，8*8
D=zeros(size);E=0.01;
for p=1:size/K
    for q=1:size/K
        x=(p-1)*K+1; % 当前块的起始行
        y=(q-1)*K+1;% 当前块的起始列
        I_dct=I(x:x+K-1,y:y+K-1);%提取当前块
        I_dct1=dct2(I_dct);% DCT变换
        if J_Out(p,q)==0
            alfa=-1;
        else
            alfa=1;
        end
        I_dct2=I_dct1+alfa*E;% 调整DCT系数
        I_dct=idct2(I_dct2);% IDCT变换
        D(x:x+K-1,y:y+K-1)=I_dct;
    end
 end
 
figure;imshow(round(D),[]);%加入水印之后的图片
 %%%%%%----------------对加入水印的图像进行各种攻击
 %%%低通滤波攻击
% hh=fspecial('gaussian',3,0.2);%定义3*3的高斯滤波器，标准差为0.2 
% hh=fspecial('gaussian',3,0.35);
% hh=fspecial('gaussian',3,0.4); 
% QQ=filter2(hh,D); %对D进行高斯滤波

 %%%旋转攻击
% R=imrotate(D,10,'bilinear','crop');
%  R=imrotate(D,20,'bilinear','crop');
 % R=imrotate(D,45,'bilinear','crop');
 % QQ=R;

 %%%%%剪切攻击
% D(1:256,1:256)=0;   Q2=D;
% D(128:384,128:384)=0;   Q2=D;
% D(256:512,256:512)=0;  Q2=D;
% QQ=D;

 %噪声攻击
 D = mat2gray(D); 
% Z=imnoise(D, 'gaussian',0,0.1); %高斯白噪声-均值为0, 方差为0.1
% Z=imnoise(D, 'salt & pepper', 0.1);%椒盐噪声-噪声密度为0.1
 Z=imnoise(D, 'speckle', 0.1);%斑点噪声-强度为0.1
 QQ=Z;
  
W=zeros(64,64);
figure;imshow(QQ,[]);%受攻击的带水印图片
title('Speckle noise interference');

 % 提取水印
for  p=1:size/K
    for  q=1:size/K
        x=(p-1)*K+1;
        y=(q-1)*K+1;
        I1=I(x:x+K-1,y:y+K-1);
        I2=QQ(x:x+K-1,y:y+K-1);
        I_dct1=dct2(I1);
        I_dct2=dct2(I2);
        if  I_dct2>I_dct1
            W(p,q)=1;
        else
            W(p,q)=0;
        end     
    end
end
figure;
W_out=ImageDecry(W,Seq1,Seq2);
imshow(imresize(round(W_out),10));%恢复得到的水印图片；
title('Watermark extracted from the image');
%--------------------------Hopfield神经网络部分-----------------------------
%----------------------------将水印图像切割为四部分-------------------
%-------------------------------训练4个Hopfield网络------------------
J=sign(J-0.000001);% sign 函数将正值转换为 1，负值转换为 -1，零保持不变
J1=J(1:32,1:32);J2=J(1:32,33:64);
J3=J(33:64,1:32);J4=J(33:64,33:64);
J1=sign(J1-0.000001);J2=sign(J2-0.000001);
J3=sign(J3-0.000001);J4=sign(J4-0.000001);% 这样可以将任何非常接近零的值也转换为 -1 或 1。
J1=J1(:)';W1=MyHopfield(J1'); %转换为行向量
figure;contourf(W1)%权重矩阵的轮廓图
J2=J2(:)';W2=MyHopfield(J2');
figure;contourf(W2)
J3=J3(:)';W3=MyHopfield(J3');
figure;contourf(W3)
J4=J4(:)';W4=MyHopfield(J4');
figure;contourf(W4)
%----------------将恢复的水印图像切割为四个部分---------------
Ww=sign(W_out-0.000001);%将图片数据转换为-1,1的值

Ww1=Ww(1:32,1:32);Ww2=Ww(1:32,33:64);
Ww3=Ww(33:64,1:32);Ww4=Ww(33:64,33:64);
for i=1:32
    for j=1:32
        if Ww1(i,j)<=0
            Ww1(i,j)=0;
        else
            Ww1(i,j)=1;
        end
    end
end

for i=1:32
    for j=1:32
        if Ww2(i,j)<=0
            Ww2(i,j)=0;
        else
            Ww2(i,j)=1;
        end
    end
end

for i=1:32
    for j=1:32
        if Ww3(i,j)<=0
            Ww3(i,j)=0;
        else
            Ww3(i,j)=1;
        end
    end
end

for i=1:32
    for j=1:32
        if Ww4(i,j)<=0
            Ww4(i,j)=0;
        else
            Ww4(i,j)=1;
        end
    end
end

W_in_1=Ww1(:)';
Out=SimMyHopfield(W1,W_in_1');
Outt1=reshape(Out,[32,32]);

W_in_2=Ww2(:)';
Out=SimMyHopfield(W2,W_in_2');
Outt2=reshape(Out,[32,32]);

W_in_3=Ww3(:)';
Out=SimMyHopfield(W3,W_in_3');
Outt3=reshape(Out,[32,32]);

W_in_4=Ww4(:)';
Out=SimMyHopfield(W4,W_in_4');
Outt4=reshape(Out,[32,32]);

Final=[Outt1 Outt2;Outt3 Outt4];
figure;imshow(imresize(Final,10))%Hopfield神经网络恢复得到的水印图片
title('Watermark extracted by Hopfield network')

%  figure;imshow(QQ,[]);title('Spin attack');
%  figure;imshow(imresize(W_out,8),[]);title('Watermark extracted from the image');
%  figure;imshow(imresize(Final,8),[]);title('Watermark extracted by Hopfield network')

% imwrite(J,'Shuiyin.bmp');
% imwrite(W_out,'Shuiyin_W.png');
% imwrite(Final,'Final.png');
%%%%%%-----------------前后水印相似比较-------------------
% for i=1:64
%     for j=1:64
%         if Final(i,j)<=0
%             Final(i,j)=0;
%         else
%             Final(i,j)=1;
%         end
%     end
% end
% for i=1:64
%     for j=1:64
%         if J(i,j)<=0
%             J(i,j)=0;
%         else
%             J(i,j)=1;
%         end
%     end
% end
% J=double(J);%原始水印
% W=double(W_out);%受攻击后恢复的水印
% F=double(Final);%Hopfield神经网络恢复的水印
% sumJ1=0;sumJ2=0;sumW=0;sumF=0;
% for  j=1:64
%     for  i=1:64
%         sumJ1=sumJ1+J(j,i)*W(j,i);
%         sumJ2=sumJ2+J(j,i)*F(j,i);
%         sumW=sumW+W(j,i)*W(j,i);
%         sumF=sumF+F(j,i)*F(j,i);
%     end
% end
% CH1=(abs(sumW-sumJ1))/sumJ1;% 计算相似度，越接近于0越相似
% CH2=(abs(sumF-sumJ2))/sumJ2;