function convert2htk(parentFolder1,ext)
addpath ~/Data/Desktop_laptop/Data_back/scripts/
parentFolder2=dir(parentFolder1);
for t1=1:length(parentFolder2)
    ref1Dir=[parentFolder1 '/' parentFolder2(t1).name];
    resdir1=[ref1Dir '/' 'KambojiResults'];
    resultDirs=dir(resdir1);
    for t=1:length(resultDirs)
        dir1=resultDirs(t).name;
        featDir=[resdir1 '/' dir1 '/' 'centFBFeature2_ZM'];
        writehtk_orig(featDir,ext);
    end
end
