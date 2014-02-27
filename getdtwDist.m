function R=getdtwDist(homeFolder,refFile,band)
queryFolder1=[homeFolder '/' 'True_Positives'];
queryFolder2=[homeFolder '/' 'False_Positives'];
trueFiles=dir(fullfile(queryFolder1,'*.centFB'));
falseFiles=dir(fullfile(queryFolder2,'*.centFB'));
Ref=load([homeFolder '/' refFile]);
parfor i=1:length(trueFiles)
    trueFile1=load([queryFolder1 '/' trueFiles(i).name]);
    [DistTrue(i), d, g, path] = dtw_2(trueFile1,Ref, band); %dtw(trueFile1,Ref);
end
parfor i=1:length(falseFiles)
    falseFile1=load([queryFolder2 '/' falseFiles(i).name]);
    [DistFalse(i), d, g, path] = dtw_2(falseFile1,Ref, band);  %[DistFalse(i)]=dtw(falseFile1,Ref);
end
dlmwrite('Dists',DistTrue,'delimiter',' ')
dlmwrite('Dists',DistFalse,'delimiter',' ','-append')
R.trueDistance=DistTrue;
R.falseDistance=DistFalse;