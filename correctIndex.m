function R=correctIndex(origContour,featFile,centContour)

orig=load(origContour);
centC=load(centContour);
feat=load(featFile);
orig(orig==-Inf)=0;
centC(centC==-Inf)=0;
zindO=find(orig);
zindM=find(centC);
compLen1=length(centC)-zindM(end);
compLen2=zindO(1)-1;
compLen=compLen2-compLen1;
feat(:,2)=feat(:,2) + compLen;
dlmwrite('test',feat,'delimiter',' ')
R.feat=feat;

end