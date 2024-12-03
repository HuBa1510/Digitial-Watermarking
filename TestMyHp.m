% clc;clear
% T=[1 -1 1;-1 1 -1]';
% W=MyHopfield(T);
% Tt=[0.8,-1.1,1.3]';
% Out=SimMyHopfield(W,Tt);
%--------------------------实际图形测试---------------------------------------------
clc;clear
J=imread('logo.png');
J=double(imresize(J(:,:,1),[64,64]));%转换为64*64
for i=1:64
    for j=1:64
        if J(i,j)==0
            J(i,j)=-1;
        else
            J(i,j)=1;
        end
    end 
end
figure;imshow(imresize(J,10));
J_in=J(:)';
W=MyHopfield(J_in');
figure;contourf(W)

J_noise=J;%扰动的矩阵
for i=1:64
    for j=1:64
        rrand=rand();
        if rrand<=0.05
           J_noise(i,j)=-J_noise(i,j);
        end
    end
end
figure
imshow(imresize(J_noise,10))
J_in_noise=J_noise(:)';
Out=SimMyHopfield(W,J_in_noise');
Outt=reshape(Out,[64,64]);
figure
imshow(imresize(Outt,10))

J_noise=J;%切块共计

%------------------------------------------------------------
% clc;clear
% J=imread('logo.png');
% J=double(imresize(J(:,:,1),[64,64]));%转换为64*64
% J=sign(J);
% J_noise=J;%扰动的矩阵
% for i=1:64
%     for j=1:64
%         rrand=rand();
%         if rrand<=0.01
%            J_noise(i,j)=-J_noise(i,j);
%         end
%     end
% end
% Input_notgood=J_noise;
% [Weight,Out]=HopfieldFigure(J,Input_notgood);