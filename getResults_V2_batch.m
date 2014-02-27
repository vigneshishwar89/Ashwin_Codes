function getResults_V2_batch(queryFolder,waveFolder,ext,outpath,resultDirName)

resultFiles=dir(fullfile(queryFolder,ext));
mkdir([outpath '/' resultDirName]);

for t=1:length(resultFiles)
    
    resultFile1=resultFiles(t).name;
    waveName=resultFile1(1:(end-16));
    resultName=resultFile1(1:(end-20));
    waveForm=[waveFolder '/' waveName];
    s=textread(resultFile1,'%s','delimiter','\n');
    [Y,FS,Nbits]=wavread(waveForm);
    
    %Get indices of line splitting 2 results in the file
    empInd=find(strcmp('',s));
    k=1;
    k1=1;
    
    for i=1:length(empInd)
    
        s1=s((k+1):(empInd(i)-1));
        res(i).val=str2num(char(s1));
        tstart=(FS/100).*(res(i).val(1,2));
        tend=(FS/100).*(res(i).val(end,2));
    
        if strcmp('True',s(k))==1
            outF=[resultName '_' num2str(i) '.trueP.wav'];
        else
            outF=[resultName '_' num2str(i) '.falseP.wav'];
        end
    
        outFile=[outpath '/' resultDirName '/' outF];
        wavwrite(Y(tstart:tend),44100,outFile)
        k=1+empInd(i);
        
    end
    
end

    
    
