function getResults_V2(resultFile,waveForm, outpath,resultDirName)

resultFileName=resultFile(1:(end-20));
s=textread(resultFile,'%s','delimiter','\n');
[Y,FS,Nbits]=wavread(waveForm);
mkdir([outpath '/' resultDirName]);

%Get indices of line splitting 2 results in the file
empInd=find(strcmp('',s));
k=1;

for i=1:length(empInd)
    
    s1=s((k+1):(empInd(i)-1));
    res(i).val=str2num(char(s1));
    tstart=(FS/100).*(res(i).val(1,2));
    tend=(FS/100).*(res(i).val(end,2));
    
    if strcmp('True',s(k))==1
        outF=[resultFileName '_' num2str(i) '.trueP.wav'];
    else
        outF=[resultFileName '_' num2str(i) '.falseP.wav'];
    end
    
    outFile=[outpath '/' resultDirName '/' outF];
    wavwrite(Y(tstart:tend),44100,outFile)
    k=1+empInd(i);
    
end

    
    
