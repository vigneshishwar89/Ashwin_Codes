function getDDLinReg(queryFolder,ext,outFolder)
files=dir(fullfile(queryFolder,ext))
[p q]=size(files);
for i=1:p
    dataFile=files(i).name
    data=load(dataFile);
    [delta1]=getDelta(data);
    [dblDelta]=getDelta(delta1');
    outData=[data delta1' dblDelta'];
    outF=[queryFolder '/' outFolder '/' dataFile '.delFeat'];
    dlmwrite(outF,outData,'delimiter',' ')
end
