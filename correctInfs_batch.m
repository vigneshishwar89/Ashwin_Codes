function correctInfs_batch(queryFolder,ext1)
%origFiles=dir(fullfile(queryFolder,ext1))
ctrFiles=dir(fullfile(queryFolder,ext1))

for i=1:length(ctrFiles)
    %origFile=origFiles(i).name;
    %orig=load(origFile);
    centFile=ctrFiles(i).name
    centC=load(centFile);
    centC(centC==-Inf)=0;
    ind1=find(centC);
    centC1=centC(ind1(1):ind1(end));
    [xinf yinf]=infCode(centC1,7);
    length(xinf)
    length(yinf)
    pp=pchip(xinf,yinf);
    fincent=fnval(pp,[1:xinf(end)]);
    fincent=fincent';
    dummy=ones(length(yinf),1);
    featout=[dummy xinf yinf];
    lenBeg=length(centC(1:(ind1(1)-1)));
    lenEnd=length(centC)-(ind1(end));
    infBeg=-Inf*(ones(lenBeg,1));
    infEnd=-Inf*(ones(lenEnd,1));
    fincent=[infBeg;fincent;infEnd];
    outF=[queryFolder '/' centFile(1:(end-19)) '.cent.spline1'];
    outF1=[queryFolder '/' centFile(1:(end-19)) '.cent.feat_mod1'];
    dlmwrite(outF,fincent,'delimiter',' ')
    dlmwrite(outF1,featout,'delimiter',' ')
end
    