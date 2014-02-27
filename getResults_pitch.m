function getResults_pitch(resultFile,pitchFile,centFile ,outpath,resultDirName)

resultFileName=resultFile(1:(end-20));
s=textread(resultFile,'%s','delimiter','\n');
%[Y,FS,Nbits]=wavread(waveForm);
origfreq=load(pitchFile);
centfreq=load(centFile);
centfreq1=centfreq;
centfreq(centfreq==-Inf)=0;
zind=find(centfreq);
complen=length(centfreq)-zind(end);

mkdir([outpath '/' resultDirName]);

%Get indices of line splitting 2 results in the file, True group Startings
%and False group Startings.

empInd=find(strcmp('',s));
empInd=sort(empInd);
trueInd=find(strcmp('True',s));
trueInd=sort(trueInd)
falseInd=find(strcmp('False',s))
falseInd=sort(falseInd);
len=length(trueInd)+length(falseInd);
k=1;

while(len>2)
    
    len=length(trueInd)+length(falseInd);
    
    if isempty(trueInd)
        grp1start=min(falseInd);
        falseInd=falseInd(falseInd~=min(falseInd));
    elseif isempty(falseInd)
        grp1start=min(trueInd);
        trueInd=trueInd(trueInd~=min(trueInd));
    elseif min(trueInd)<min(falseInd)
        grp1start=min(trueInd);
        trueInd=trueInd(trueInd~=min(trueInd));
    elseif min(falseInd)>min(trueInd)
        grp1start=min(falseInd);
        falseInd=falseInd(falseInd~=min(falseInd));
    end
    
    if (isempty(falseInd))
        grp1end=min(trueInd);
%     elseif(isempty(trueInd))
%         grp1end=min(falseInd);
    elseif min(trueInd)<min(falseInd)
        grp1end=min(trueInd);
        %trueInd=trueInd(trueInd~=min(trueInd));
    else
        grp1end=min(falseInd);
        %falseInd=falseInd(falseInd~=min(falseInd));
    end
    
    grpMem=empInd(empInd>grp1start & empInd<grp1end);
    grpMem=[grp1start;grpMem];
    tstart=grpMem(1:end-1)+1;
    tend=grpMem(2:end)-1;
    
    for i=1:length(tstart)
        s1=str2num(s{tstart(i)});
        s2=str2num(s{tend(i)});
%         St=(FS/100).*(s1(2));
%         Et=(FS/100).*(s2(2));
        St=s1(2)+complen;
        Et=s2(2)+complen;
        St1=s1(2);
        Et1=s2(2);
        if (strcmp('True',s(grp1start))==1)
            outF=[resultFileName '_grp' num2str(k) '.trueP' num2str(i) '.orig.cent'];
        else
            outF=[resultFileName '_grp' num2str(k) '.falseP' num2str(i) '.orig.cent'];
        end
        
        if (strcmp('True',s(grp1start))==1)
            outF1=[resultFileName '_grp' num2str(k) '.trueP' num2str(i) '.freq.cent'];
        else
            outF1=[resultFileName '_grp' num2str(k) '.falseP' num2str(i) '.freq.cent'];
        end
    
        outFile=[outpath '/' resultDirName '/' outF];
        outFile2=[outpath '/' resultDirName '/' outF1];
        resFreq=origfreq(St:Et);
        resFreqcent=centfreq1(St1:Et1);
        dlmwrite(outFile,resFreq,'delimiter',' ')
        dlmwrite(outFile2,resFreqcent,'delimiter',' ')
        %wavwrite(Y(St:Et),44100,outFile)
    end
    
    k=k+1;

end
