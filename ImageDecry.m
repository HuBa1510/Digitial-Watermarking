function Out=ImageDecry(In,Seq1,Seq2)
[m,n]=size(In);
Inn_temp=reshape(In,[1,m*n]);%将输入图像转换为一维向量Inn_tem，尺寸为m*n

Mean1=mean(Seq1);%计算序列1的平均值
Seq11=sgn(Seq1-Mean1);%计算每个像素与平均值的差值
Inn_temp=myBitXor(Inn_temp,Seq11);%异或操作

Mean2=mean(Seq2);
Seq21=sgn(Seq2-Mean2);
Inn_temp=myBitXor(Inn_temp,Seq21);

[~,Idex2] = sort(Seq2);
[~,Idex2] = sort(Idex2);
Inn_temp=Inn_temp(Idex2);

[~,Idex1] = sort(Seq1);
[~,Idex1] = sort(Idex1);
Inn_temp=Inn_temp(Idex1);
Out=reshape(Inn_temp,[m,n]);