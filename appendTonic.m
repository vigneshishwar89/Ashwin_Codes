function appendTonic(queryFolder1,ext,resultFolderName)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%In This Code, One must pass the path of the folder which contains the
%result folder. The result folder will contain the respective aalap folders
%with the wavefiles in them. The code will grep their names in the tonic
%file correct Tonic  File whose full path is 
%/home/vignesh/Data/Labelling_Phrases/correct_tonic_values.txt. This file
%contains the tonic in the format [ AlapName Tonicval].
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dirs=dir([queryFolder1 '/' resultFolderName]);
tonicFile=['/home/vignesh/Data/Labelling_Phrases/correct_tonic_values.txt'];
for i=3:length(dirs)
    queryFolder=dirs(i).name;
    files=dir(fullfile(queryFolder,ext));
    [p q]=size(files);
    for t=1:p
        pitFile=files(t).name;
        %hzFile=load(pitFile);
        %hzFile=hzFile(:,2);
        [FL,P]=grep(pitFile(1:end-21),tonicFile);
        tfpt=P.match;
        tfname=char(tfpt);
        flname=pitFile;
        tonic=str2num(tfname(end-3:end));
        tonicName=num2str(tonic);
        outLine=[queryFolder1 '/' queryFolder '/' flname ' ' tonicName];
        dlmwrite([queryFolder1 '/' resultFolderName '/' queryFolder '/' 'WaveList_Tonic1'],outLine,'delimiter','','-append')
    end
end
   % R.files=files;