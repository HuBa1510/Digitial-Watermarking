clc;clear
I=imread('Peppers.bmp');%Original target image
figure;imshow(I);
J=imread('logo.png');%Watermark image

%The watermark image is preprocessed----------
J=double(imresize(J(:,:,1),[64,64]));%Select channel 1(let's say RGB) for J and scale it to 64*64;
J=sgn(J);%Convert to 0 or 1
figure;imshow(imresize(J,8));%The picture is displayed 8 times larger

%Chaotic sequence preparation------
[y,q,Ly1,Ly2]=SineSquaredMemristorShuiyin(1.55,1.8,0.4,0.1,100000);
y=y(1000:end);
Seq1=y(1:64*64);%Extract 64*64=4096 values from y, sequence 1
Seq2=y(64*64+1:64*64*2);%Extract the next 4096 values from y, from 4097 to 64*64*2=8192, sequence 2

%---------Watermark data encryption--------
J_Out=ImageEncry(J,Seq1,Seq2);%Watermarking image encryption
% J_Out=J;

size=512; 
N=64; 
K=8;  
D=zeros(size);E=0.01;
for p=1:size/K
    for q=1:size/K
        x=(p-1)*K+1; 
        y=(q-1)*K+1;
        I_dct=I(x:x+K-1,y:y+K-1);
        I_dct1=dct2(I_dct);
        if J_Out(p,q)==0
            alfa=-1;
        else
            alfa=1;
        end
        I_dct2=I_dct1+alfa*E;% adjust the DCT coefficient
        I_dct=idct2(I_dct2);
        D(x:x+K-1,y:y+K-1)=I_dct;
    end
 end
 
figure;imshow(round(D),[]);%Image after adding watermark 

%%%Perform various attacks on watermarked images-----------------------------------------------

%%%Low-pass filtering attacks-------------------
% hh=fspecial('gaussian',3,0.2);%Define a 3*3 Gaussian filter with a standard deviation of 0.2
% hh=fspecial('gaussian',3,0.35);standard deviation of 0.35
% hh=fspecial('gaussian',3,0.4); standard deviation of 0.4
% QQ=filter2(hh,D); %Gaussian filtering is performed on D

 %%%spin attack-------------------
% R=imrotate(D,10,'bilinear','crop');%Rotation 10��
%  R=imrotate(D,20,'bilinear','crop');%Rotation 20��
 % R=imrotate(D,45,'bilinear','crop');%Rotation 45��
 % QQ=R;

 %%%%%Shear attack------------
% D(1:256,1:256)=0;   Q2=D; % top left corner
% D(128:384,128:384)=0;   Q2=D; % center
% D(256:512,256:512)=0;  Q2=D; % lower right corner
% QQ=D;

 %Noise attack-------------
% D = mat2gray(D); % graying
% Z=imnoise(D, 'gaussian',0,0.1); %Gaussian White noise - mean 0, variance 0.1
% Z=imnoise(D, 'salt & pepper', 0.1);%Salt and pepper noise - Noise density is 0.1
% Z=imnoise(D, 'speckle', 0.1);%Speckle noise - Intensity is 0.1
% QQ=Z;
  
W=zeros(64,64);
figure;imshow(QQ,[]);%Watermarked image under attack
title('Speckle noise interference');

 % Extract watermark
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
imshow(imresize(round(W_out),10));%Recovered the watermark image��
title('Watermark extracted from the image');
%--------------------------Part of Hopfield neural network----------------------------------
%----------------------------The watermark image is cut into four parts-------------------
%-------------------------------Train 4 Hopfield networks------------------------------------
J=sign(J-0.000001);% The sign function converts positive values to 1, negative values to -1, and zero remains unchanged
J1=J(1:32,1:32);J2=J(1:32,33:64);
J3=J(33:64,1:32);J4=J(33:64,33:64);
J1=sign(J1-0.000001);J2=sign(J2-0.000001);
J3=sign(J3-0.000001);J4=sign(J4-0.000001);
J1=J1(:)';W1=MyHopfield(J1'); %Convert to a row vector
figure;contourf(W1)%Outline of the weight matrix
J2=J2(:)';W2=MyHopfield(J2');
figure;contourf(W2)
J3=J3(:)';W3=MyHopfield(J3');
figure;contourf(W3)
J4=J4(:)';W4=MyHopfield(J4');
figure;contourf(W4)

%----------------The recovered watermark image is cut into four parts---------------
Ww=sign(W_out-0.000001);%Converts the picture data to a value of -1,1

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
figure;imshow(imresize(Final,10))%Watermark image recovered by Hopfield neural network
title('Watermark extracted by Hopfield network')

%The results are displayed in the same Figure---------------------
%  figure;imshow(QQ,[]);title('Spin attack');
%  figure;imshow(imresize(W_out,8),[]);title('Watermark extracted from the image');
%  figure;imshow(imresize(Final,8),[]);title('Watermark extracted by Hopfield network')

%%%Similarity------------------------------------
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
% J=double(J);%Original watermark
% W=double(W_out);%Watermark recovered after an attack
% F=double(Final);%Watermark recovered by Hopfield neural network
% sumJ1=0;sumJ2=0;sumW=0;sumF=0;
% for  j=1:64
%     for  i=1:64
%         sumJ1=sumJ1+J(j,i)*W(j,i);
%         sumJ2=sumJ2+J(j,i)*F(j,i);
%         sumW=sumW+W(j,i)*W(j,i);
%         sumF=sumF+F(j,i)*F(j,i);
%     end
% end

% Calculate the similarity, the closer it is to 0, the more similar it is
% CH1=(abs(sumW-sumJ1))/sumJ1;
% CH2=(abs(sumF-sumJ2))/sumJ2;