function R=storeInfpts(queryFolder,ext)
files=dir(fullfile(queryFolder,ext));
[p q]=size(files);
for i=1:p
    freqFile=files(i).name;
    freq=load(freqFile);
    freq1=freq(~isinf(freq));
    [xinf yinf]=infCode(freq1,7);
    outF1=[freqFile '.xinf1'];
    outF2=[freqFile '.yinf1'];
    dlmwrite(outF1,xinf,'delimiter',' ')
    dlmwrite(outF2,yinf,'delimiter',' ')
end
R.xinf=xinf;