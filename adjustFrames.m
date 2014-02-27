function R=adjustFrames(queryFolder,ext1,ext2)
files1_mod=dir(fullfile(queryFolder,ext1))
queryFolder2=[queryFolder '/outFiles/'];
files2_syn=dir(fullfile(queryFolder2,ext2))
[p q]=size(files1_mod);
for i=1:p
    a=load(files1_mod(i).name);
    a1=load([queryFolder2 files2_syn(i).name]);
    lena=length(a);
    lena1=length(a1);
    lenc=lena -lena1;
    temp=-Inf*ones(lenc,1);
    a2=[temp;a1];
    string1=[queryFolder2 files2_syn(i).name '_mod'];
    dlmwrite(string1,a2,'delimiter',' ')
end
R.origC=a2;