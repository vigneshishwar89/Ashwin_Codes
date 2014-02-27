function R=getflatSegments(queryFolder,ext)
    files=dir(fullfile(queryFolder,ext));
    [p q]=size(files);
    for t=1:p
        file1=files(t).name;
        freq=load(file1);
        freq1=freq(freq~=0);
        [xinf1 yinf1]=infCode(freq1,7); %gets Inflection points using infCode.m
        pp=pchip(xinf1,yinf1); % next 3 lines are cleaning up of contour using the cubic interpolation
        freq2=fnval(pp,[1:xinf1(end)]);
        freq2=freq2';
        [xinf yinf]=infCode(freq2,7); %gets inflection points using infCode.m from the cleaned contour
        len1=length(freq);
        len2=length(freq2);
        len3=len1-len2;
        temp=0*ones(len3,1);
        freq3=[temp;freq2]; %makes the number of samples equal to that of waveform incase you want to symthesize use this freqFile
        k=1;
        for i=1:length(xinf)-1 % The entire segment extracts pitch corresponding to Flats (if max pitch value -min pitch value is <10hz then ive taken it as flat)
            freqShape(i).val=freq1(xinf(i):xinf(i+1)-1);
            freqShapeX(i).val=[xinf(i):xinf(i+1)-1];
            if (abs(max(freqShape(i).val)-min(freqShape(i).val))<10)
                lenFlat(i)=length(freqShapeX(i).val);
                freqFlatX(k).val=freqShapeX(i).val;
                freqFlatY(k).val=freqShape(i).val;
                size(freqFlatX);
                size(freqFlatY);
                outF=[file1 '_FlatSegX'];
                outF1=[file1 '_FlatSegY'];
                %string1=[queryFolder '/' outF];
                dlmwrite(outF,freqFlatX(k).val','delimiter',' ','-append'); %aggregated X of all flat segments
                dlmwrite(outF1,freqFlatY(k).val,'delimiter',' ','-append'); %aggregated Y of all flat segments
                k=k+1;
            end
        end
    end
    R.flatSegment=freqFlatY; %gives individual flat segments 
    R.flatSegmentX=freqFlatX; %gives individual flat indices