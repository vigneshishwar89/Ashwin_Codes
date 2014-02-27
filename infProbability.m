function R=infProbability(queryFolder,ext,histFile)
files=dir(fullfile(queryFolder,ext));
[p q]=size(files);
for i=1:p
    featFile=files(i).name
    feat=load(featFile);
    yinfs=feat(:,2);
    yinf_hist=load(histFile);
    yinf_hist1=yinf_hist(:,1);
    for j=1:length(yinfs)
        [r c]=find(yinf_hist1==round(yinfs(j)));
        p(j)=log(yinf_hist(r,2)/sum(yinf_hist(:,2)));
    end
    pFile=[yinfs p'];
    infProb(i)=sum(p);
    %alphaOutInf=[files(i).name infProb(i)]
    outFile=[queryFolder '/probFiles/' featFile 'sbVSbh' '.prob'];
    dlmwrite(outFile,pFile,'delimiter',' ');
    clear p
end
outFile1=[queryFolder '/probFiles/' 'totProb_sbVSbh'];
dlmwrite(outFile1,infProb','delimiter',' ');
R.probab=infProb;