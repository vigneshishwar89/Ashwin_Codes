function R=get3DFeat(queryFolder,ext,primitives)
files=dir(fullfile(queryFolder,ext));
[p q]=size(files);
for i=1:p
    freqFile=files(i).name;
    R1=theUltimateCode_mod_2(freqFile,primitives);
    seq1=R1.sequence;
    yinf1=R1.yinf;
    a=R1.yinf(2:end-1);
    for i=1:length(a)
        b(i,:)=[R1.sequence(i) a(i) R1.sequence(i+1)];
    end
    start=[0 R1.yinf(1) R1.sequence(1)];
    endfeat=[R1.sequence(end) R1.yinf(end) 0];
    b=[start;b;endfeat];
    outF=[freqFile '.3DF'];
    dlmwrite(outF,b,'delimiter',' ')
end
R.feat=b;