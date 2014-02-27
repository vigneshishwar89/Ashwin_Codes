function R = SynthesizePrimitives(queryFolder, ext,primitives)
files=dir(fullfile(queryFolder,ext));
[w x]=size(files);
for i = 1 : w
    file=[queryFolder '/' files(i).name];
    string1=[queryFolder '/outFiles_8/' files(i).name '.pitchSyn'];
    string2=[queryFolder '/outFiles_8/' files(i).name '.primitiveSyn'];
    string3=[string1 '.freq'];
    string4=[string2 '.freq'];
    string5=[string3 '.orig.freq'];
    string6=[queryFolder '/outFiles_8/' files(i).name '.seq'];
    contourFile= [file '.spl.mel.441f0.cent.mod']
    contourFile1=[file '.spl.mel.441f0.cent']
    R1=theUltimateCode_mod_2(contourFile,contourFile1, primitives);
    %contour=load(contourFile);
    contour=R1.origContour;
    [m n]=size(contour);
    fhalf=contour(1:floor(m/2));
    shalf=contour(floor(m/2)+1 : m);
    startInd=find(isinf(fhalf),1,'last')+1;
    endInd=find(isinf(shalf),1,'first')-1;
    if isempty(startInd)
        startInd = 1; 
    end

    if isempty(endInd)
        endInd = m; 
    else
        endInd=floor(m/2) + endInd;
    end
    startInd;
    endInd;
    [o p]=size(R1.xinf);
    conty=[];
    contx=[];
    for j = 1 : o-1
        yarray=[R1.yinf(j) R1.yinf(j+1)];
        cont1= scaleContour_v4(R1.Syn(j).Y, R1.Syn(j).X, min(yarray), max(yarray) ,R1.xinf(j) ,R1.xinf(j+1)-1);
        conty = [conty cont1(:,2)'];
        contx = [contx cont1(:,1)'];
    end
    R1.contx=contx;
    R1.conty=conty;
    sequence1=R1.sequence;
    yinfPts=R1.yinf;
    xinfPts=R1.xinf;
    xinfPts=xinfPts+R1.compLen;
    feature=[sequence1' xinfPts(1:(end-1)) yinfPts(1:(end-1))];
    string7=[queryFolder '/outFiles_8/' files(i).name '.feat_mod'];
    dlmwrite(string7,feature,'delimiter',' ')
    dlmwrite(string6,sequence1,'delimiter',' ')
    f0Act=R1.contour;
    fSyn=conty;
    f0Act=138*(power(2,(R1.contour/1200)));
    f0Syn=138*(power(2,(R1.conty/1200)));
    dlmwrite(string3,f0Act,'delimiter',' ')
    dlmwrite(string4,f0Syn,'delimiter',' ')
    dlmwrite(string5,contour,'delimiter',' ')
%       wavFile=wavread(file);
%       wavSplit=buffer(wavFile,441,0);
%       wavFile1=wavSplit(:,startInd:endInd);
%       wavFile=wavFile1(:);
%       s1=size(R1.contour)
%       s2=size(f0Syn)
%       sp=size(wavFile1)
%   %      string1=[file '.pitchSyn'];
%   %      string2=[file '.primitiveSyn'];
%       r1 = run_comm(wavFile,f0Act,12,0.001,0.001,string1);
%       r2 = run_comm(wavFile,f0Syn',12,0.001,0.001,string2);
end
R=R1;
R.endInd=endInd;
