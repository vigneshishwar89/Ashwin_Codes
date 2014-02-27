function getResults_V3(queryFolder,waveFolder,ext,resultDirname)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sample run
%getResults_V3_Batch('/home/vignesh/Data/RLCS_motif_match/Results_RLCS_Group/Kamboji','/home/vignesh/Data/RLCS_motif_match/Alap_WaveFiles','*_result','KambojiResults')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

resultDirs=dir(queryFolder);
for t1=3:length(resultDirs)
    resultDirectory=resultDirs(t1).name
    resultFiles=dir(fullfile((resultDirectory),ext));
    %mkdir([outpath '/' resultDirName]);

    for t=1:length(resultFiles)
        resultFile1=[queryFolder '/' resultDirectory '/' resultFiles(t).name]
        mkdir([resultDirectory '/' resultDirname '/' resultFiles(t).name]);
        waveName=resultFiles(t).name(1:(end-16));
        resultName=resultFiles(t).name(1:(end-20));
        waveForm=[waveFolder '/' waveName];
        s=textread(resultFile1,'%s','delimiter','\n');
        [Y,FS,Nbits]=wavread(waveForm);

        %Get indices of line splitting 2 results in the file, True group Startings
        %and False group Startings.

        empInd=find(strcmp('',s));
        empInd=sort(empInd);
        trueInd=find(strcmp('True',s));
        trueInd=sort(trueInd);
        falseInd=find(strcmp('False',s));
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
            else
                grp1start=min(falseInd);
                falseInd=falseInd(falseInd~=min(falseInd));
            end

            if (isempty(falseInd))
                grp1end=trueInd;
%             elseif(isempty(trueInd))
%                 grp1end=falseInd;
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
                St=(FS/100).*(s1(2));
                Et=(FS/100).*(s2(2));
                if (strcmp('True',s(grp1start))==1)
                    outF=[resultName '_grp' num2str(k) '.trueP' num2str(i) '.wav'];
                else
                    outF=[resultName '_grp' num2str(k) '.falseP' num2str(i) '.wav'];
                end

                outFile=[resultDirectory '/' resultDirname '/' resultFiles(t).name '/' outF];
                wavwrite(Y(St:Et),44100,outFile)
            end

            k=k+1;

        end
        clear empInd
        clear trueInd
        clear falseInd
        clear k
        clear grpMem
        clear len
    end
end

    
  