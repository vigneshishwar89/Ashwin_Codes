files=dir(fullfile('/home/vignesh/Data/Labelling_Phrases/Five_Old_Ragas/Kamboji_Phrases/m3/outFiles_8','*.feat'));
for i=1:length(files)
a=load(files(i).name);
a1=diff(a(:,1));
[c d]=find(a1);
a2=a(c,:);
if(a1(end)==0)
a2=[a2;[8 a(end)]];
else
a2=[a2;a(end,:)];
end
outF=[files(i).name '_nfs'];
dlmwrite(outF,a2,'delimiter',' ')
end