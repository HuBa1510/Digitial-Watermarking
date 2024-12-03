clc;clear
[y,Ly]=Logistic(4,0.55,100000);
J=imread('logo.png');
J=double(imresize(J(:,:,1),[64,64]));%×ª»»Îª64*64
J=sgn(J);
figure;imshow(J)

y=y(1000:end);
Seq1=y(1:64*64);
Seq2=y(64*64+1:64*64*2);

Out=ImageEncry(J,Seq1,Seq2);
figure;imshow(Out)

Out1=ImageDecry(Out,Seq1,Seq2);
figure;imshow(Out1)





