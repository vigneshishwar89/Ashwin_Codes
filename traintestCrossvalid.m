function traintestCrossvalid(queryFolder,ext,AlapFolderPath,phrName,GTFileList)
tonicFile=['/home/vignesh/Data/Labelling_Phrases/correct_tonic_values.txt'];
files=dir(fullfile(queryFolder,ext))
waveFolder=AlapFolderPath;
[p q]=size(files);

for cv=1:4

    rn=randperm(p);
    trnf=rn(1:21);
    tstf=rn(22:p);
    trnFiles=files(trnf);
    tstFiles=files(tstf);

    for i=1:length(trnFiles)
        
        resultFile=trnFiles(i).name;
        waveName=resultFile(1:(end-16));
        waveForm=[waveFolder '/' waveName];
        resultDirName=['Train_cv_' num2str(cv) '_' phrName];
        getResults_V3(resultFile,waveForm, queryFolder,resultDirName)
        
        [FL,P]=grep(waveName,GTFileList);
        outF = ['GT_TrainList_cv_' num2str(cv)]; 
        dlmwrite(outF,char(P.match),'delimiter','','-append')
    end
    clear FL
    clear P
    for i=1:length(tstFiles)
        
        resultFile=tstFiles(i).name;
        waveName=resultFile(1:(end-16));
        waveForm=[waveFolder '/' waveName];
        resultDirName=['Test_cv_' num2str(cv) '_' phrName];
        getResults_V3(resultFile,waveForm, queryFolder,resultDirName)
        
        [FL,P]=grep(waveName,GTFileList);
        outF = ['GT_TestList_cv_' num2str(cv)]; 
        dlmwrite(outF,char(P.match),'delimiter','','-append')
        
    end
    
end


