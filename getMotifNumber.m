function R=getMotifNumber(queryFolder,ext)
files=dir(fullfile(queryFolder,ext))
for i=1:length(files)
    k=1;
    file1=files(i).name;
    s=textread(file1,'%s','delimiter','\n');
    for j=2:2:length(s)
        if (strcmp(s(j),'m3')==1)
            z(k)=1;
            k=k+1;
        else
            z(k)=0;
            k=k+1;
        end
    end
    numM3(i)=sum(z);
    outL=[file1 ' ' num2str(numM3(i))];
    dlmwrite('KBM3_MotifNumber',outL,'delimiter','','-append')
    clear z
end
R.number=numM3;