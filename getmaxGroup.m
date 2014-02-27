function R = getmaxGroup(hmmFile)
s=textread(hmmFile,'%s','delimiter','\n');
k=1;
%k1=1;
for i=1:length(s) -1
    s1=char(s(i));
    s2=s1(1:end-47);
    s3=char(s(i+1));
    s4=s3(1:end-47);
    grp(k).file(i).val=s(i);
    if strcmp(s2,s4)==1
        %k1=k1+1;
    else
        k=k+1;
        %k1=1;
    end
    
end
R.grps=grp;