
queryFolder='/home/vignesh/front-end-dsp/data/GroupWav';
ext='*.wav';
tonicFile='/home/vignesh/Data/Labelling_Phrases/correct_tonic_values.txt';
files=dir(fullfile(queryFolder,ext))
for t=1:length(files)
        pitFile=files(t).name;
        [FL,P]=grep(pitFile(1:end-28),tonicFile);
        tfpt=P.match;
        tfname=char(tfpt);
        flname=pitFile;
        tonic=str2num(tfname(end-3:end));
        tonicName=num2str(tonic);
        outLine=[queryFolder '/' flname ' ' tonicName];
        dlmwrite([queryFolder '/' 'waveist_groupwav_tonic'],outLine,'delimiter','','-append')
    end