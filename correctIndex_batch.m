function R=correctIndex_batch(queryFolder,ext1,ext2,ext3)
origFiles=dir(fullfile(queryFolder,ext1));
%queryFolder2=[queryFolder '/' 'outFiles_8'];
%addpath queryFolder2
ctrFiles=dir(fullfile(queryFolder,ext2));
featFiles=dir(fullfile(queryFolder,ext3));

for i=1:length(origFiles)
    origFile=origFiles(i).name;
    orig=load(origFile);
    centFile=ctrFiles(i).name;
    centC=load(centFile);
    featFile=featFiles(i).name;
    feat=load(featFile);
    orig(orig==-Inf)=0;
    centC(centC==-Inf)=0;
    zindO=find(orig);
    zindM=find(centC);
    compLen1=length(centC)-zindM(end);
    compLen2=zindO(1)-1;
    compLen=compLen2-compLen1;
    feat(:,2)=feat(:,2) + compLen;
    outF=[queryFolder '/' centFile(1:(end-19)) '.feat_mod'];
    dlmwrite(outF,feat,'delimiter',' ')
end

R.feat=feat;
    