function Out=ImageEncry(In,Seq1,Seq2)
[m,n]=size(In);
Inn=reshape(In,[1,m*n]);

[~,Idex1] = sort(Seq1);
Inn1=Inn(Idex1);
[~,Idex2] = sort(Seq2);
Inn=Inn1(Idex2);

Mean1=mean(Seq1);
Seq11=sgn(Seq1-Mean1);
Inn=myBitXor(Inn,Seq11);
Mean2=mean(Seq2);
Seq21=sgn(Seq2-Mean2);
Inn=myBitXor(Inn,Seq21);

Out=reshape(Inn,[m,n]);
