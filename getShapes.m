function R=getShapes(queryFolder,ext)
files=dir(fullfile(queryFolder,ext));
[m n]=size(files);
%mkdir shpFolder
for t=1:m
    file1=files(t).name;
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
        if (abs(max(freqShape(i).val)-min(freqShape(i).val))>120)
            [sipc]=scaleContour_v3(freqShape(i).val,50,100);
            freqScaledX(i).val=sipc(:,1);
            freqScaledY(i).val=sipc(:,2);
            %outF=[file1 '_shp' num2str(i)];
            string1=[queryFolder '/shpFolder_corr/' file1 '_' num2str(i) '.shp'];
            dlmwrite(string1,sipc,'delimiter',' ');
        end
    end
end