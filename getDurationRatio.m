files=dir(fullfile('/home/vignesh/Data/Labelling_Phrases/Five_Old_Ragas/Kamboji_Phrases/m3/outFiles_8','*.feat_mod'))

for i=1:length(files)
    a=load(files(i).name);
    t(i).val=a(:,2);
    for j=2:length(t(i).val)
        T1(i).val(j-1)=(abs(t(i).val(j)-t(i).val(j-1)))/(max(t(i).val));
    end
    dlmwrite('Duration_File',T1(i).val,'delimiter',' ','-append')
end
