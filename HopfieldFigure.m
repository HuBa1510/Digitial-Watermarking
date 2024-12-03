function [Weight,Out]=HopfieldFigure(Input_orginal,Input_notgood)
%Input_orginal,原始图像，供训练使用
%Input_notgood,有缺陷图像，供测试使用
figure;imshow(imresize(Input_orginal,10));
figure;imshow(imresize(Input_notgood,10));
[m,n]=size(Input_orginal);
Input_orginal=sign(Input_orginal);
J_in=Input_orginal(:)';
Weight=MyHopfield(J_in');

J_in_noise=Input_notgood(:)';
Out=SimMyHopfield(Weight,J_in_noise');
Out=reshape(Out,[m,n]);
figure;imshow(imresize(Out,10),[]);


