 s=textread('M3_FalseVSFalse1','%s','delimiter','\n');
 k=1;
for i=1:length(s)
if rem(i,3)==0
loi=cell2mat(s(i));
res(k).val=loi;
k=k+1;
end
end
clear s
for i=1:length(res)
dlmwrite('Result_M3_FalseVSFalse1',res(i).val,'delimiter','','-append')
end
clear res