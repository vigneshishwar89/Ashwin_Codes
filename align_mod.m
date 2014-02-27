function R=align_mod(contourFile,primitives)
freq=load(contourFile);
R.stem=[];
R.ActX=[];
R.ActY=[];
R.SynX=[];
R.SynY=[];
freq1=freq(~isinf(freq));
[xinf1 yinf1]=infCode(freq1,7);
pp=pchip(xinf1,yinf1);
freq2=fnval(pp,[1:xinf1(end)]);
freq2=freq2';
[xinf yinf]=infCode(freq2,7);
len1=length(freq);
len2=length(freq2);
len3=len1-len2;
temp=-Inf*ones(len3,1);
freq3=[temp;freq2];
k=1;
flag=zeros((length(inf)-1),1);
for i=1:8
    data(i).num=primitives(i).val;
end
for i=1:8
    [out(i,1),out(i,2),out(i,3)] = getLogisticParameters(data(i).num);
end
for i=1:2
    freqShape(i).val=freq2(xinf(i):xinf(i+1)-1);
    freqShapeX(i).val=[xinf(i):xinf(i+1)-1];
    [sipc]=scaleContour_v3(freqShape(i).val,50,100);
    freqScaledX(i).val=sipc(:,1);
    freqScaledY(i).val=sipc(:,2);
    R1=align_logist_v2(sipc,primitives(1:7))
    seq1(i)=R1.seq;
    distmat(i).val=R1.distmat;
end
R.sequence=seq1;
R.distmat=distmat;