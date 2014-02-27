function R=theUltimateCode(contourFile,primitives)
freq=load(contourFile);
R.stem=[];
R.ActX=[];
R.ActY=[];
R.SynX=[];
R.SynY=[];
freq=freq(~isinf(freq));
[xinf yinf]=infCode(freq,7);
length(freq)
k=1;
flag=zeros((length(inf)-1),1);
for i=1:14
    data(i).num=primitives(i).val;
end
for i=1:14
    [out(i,1),out(i,2),out(i,3)] = getLogisticParameters(data(i).num);
end
for i=1:length(xinf)-1
    freqShape(i).val=freq(xinf(i):xinf(i+1)-1);
    freqShapeX(i).val=[xinf(i):xinf(i+1)-1];
    [sipc]=scaleContour_v3(freqShape(i).val,50,100);
    freqScaledX(i).val=sipc(:,1);
    freqScaledY(i).val=sipc(:,2);
    R1=align_logist_v2(sipc,primitives(1:13));
    seq1(i)=R1.seq;
    if (abs(max(freqShape(i).val)-min(freqShape(i).val))<120)
        seq1(i)=14;
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
R.contour=freq;
