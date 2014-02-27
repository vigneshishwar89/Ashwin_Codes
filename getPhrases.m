function getPhrases(queryFolder,ext,outPath)
wavFiles=dir(fullfile(queryFolder,ext));
[m n]=size(wavFiles);
for i=1:m
    centFile=[wavFiles(i).name '.spl.mel.441f0.cent']
    cents=load(centFile);
    labFile=[wavFiles(i).name '.lab'];
    s=textread(labFile,'%s','delimiter','\n');
    [wavF,Fs]=wavread(wavFiles(i).name);
    %s=char(s);
    [p q]=size(s);
    for j=1:2:p
        s1=char(s(j));
        s2=char(s(j+1));
        ind1=find(s1==' ');
        st=(100)*str2num(s1(1:(ind1-1)));
        dur=(100)*str2num(s1((ind1+1):end));
        et=st+dur;
        phrase=cents(floor(st):floor(et));
        [xinf yinf]=infCode(phrase,7);
        ind=find(phrase(xinf)==-Inf)
        xinf(ind)=[];
        yinf=yinf(yinf~=-Inf);
        size(xinf)
        size(yinf)
          if xinf(end)~=length(phrase)
              xinf1=[xinf;length(phrase)];
              yinf1=[yinf;phrase(xinf(end)-1)];
          end
        pp=pchip(xinf,yinf);
        finCent=fnval(pp,[1:xinf(end)]); finCent=finCent';
        outF1=[outPath '/' wavFiles(i).name '_' num2str(j) '.' s2(1:end) '.cent.spline'];
        outF2=[outPath '/' wavFiles(i).name '_' num2str(j) '.' s2(1:end) '.cent'];
        dlmwrite(outF1,finCent);
        dlmwrite(outF2,phrase);
    end
end