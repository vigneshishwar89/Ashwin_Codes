function R=theUltimateCode_mod_2(contourFile,contourFile1,primitives)
freq=load(contourFile);
R.stem=[];
R.ActX=[];
R.ActY=[];
R.SynX=[];
R.SynY=[];
ftemp=load(contourFile1);
ftemp(ftemp==-Inf)=0;
zind1=find(ftemp);
lenComp1=length(ftemp)-zind1(end);
f1=freq;
f1(f1==-Inf)=0;
zind2=find(f1);
lenComp2=zind2(1);
lenComp=lenComp2-lenComp1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
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
for i=1:length(xinf)-1
    freqShape(i).val=freq2(xinf(i):xinf(i+1)-1);
    freqShapeX(i).val=[xinf(i):xinf(i+1)-1];
    [sipc]=scaleContour_v3(freqShape(i).val,50,100);
    freqScaledX(i).val=sipc(:,1);
    freqScaledY(i).val=sipc(:,2);
    R1=align_logist_v2(sipc,primitives(1:7));
    seq1(i)=R1.seq;
    if (abs(max(freqShape(i).val)-min(freqShape(i).val))<120)
        seq1(i)=8;
        lenFlat(i)=length(freqShapeX(i).val);
    end
    Syn(i).X=sipc(:,1);
    Syn(i).Y=out(seq1(i),1)./(1+exp(-out(seq1(i),3)*(Syn(i).X-out(seq1(i),2))));
    R.stem=[R.stem 0 0 0 0 0 0 zeros(1,length(sipc(:,1))-1) 1];
    R.ActY= [R.ActY 0 0 0 0 0 0 sipc(:,2)'];
 
    R.SynY= [R.SynY 0 0 0 0 0 0 Syn(i).Y'];
end
R.stem=(max(R.ActY)+5)*R.stem

R.sequence=seq1;
R.Syn=Syn;
R.ShapesY=freqShape;
R.ShapesX=freqShapeX
R.xinf = xinf;
R.yinf= yinf;
R.origContour=freq3
R.contour=freq2
%R.FlatLen=lenFlat
R.compLen=lenComp;
