function R=getFlatTime(queryFolder,ext)
files=dir(fullfile(queryFolder,ext));
[m n]=size(files);
%mkdir shpFolder
for t=1:m
    file1=files(t).name
    contourFile=[file1 '.spl.mel.441f0.cent.mod'];
    freq=load(contourFile);
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
    for i=1:length(xinf)-1
        freqShape(i).val=freq2(xinf(i):xinf(i+1)-1);
        freqShapeX(i).val=[xinf(i):xinf(i+1)-1];
        if (abs(max(freqShape(i).val)-min(freqShape(i).val))<120)
           lenFlat(i)=length(freqShapeX(i).val);
            %outF=[file1 '_shp' num2str(i)];
%             string1=[queryFolder '/shpFolder/' file1 '_' num2str(i) '.fLen'];
%             dlmwrite(string1,lenFlat','delimiter',' ');
        end
    end
    ind=find(lenFlat==0)
    if ind~=0
        len1=sum(lenFlat(1:ind(1)));
        t1s(t)=len1/100;
    else
        t1s(t)=sum(lenFlat)/100;
    end
end
%clear ind
R.flatTime=t1s;