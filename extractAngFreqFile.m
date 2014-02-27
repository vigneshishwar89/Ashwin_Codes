function r = extractAngFreqFile(dataFile,lpOrder,filt)
[b,a]=butter(10,filt); 
data=wavread(dataFile);
y=filter(b,a,data);
[lpC,res]=lpRes(y,441,441,lpOrder,1);
r1=lpC;
[m1 n1]=size(r1)
for i = 1 :m1; if(r1(i,:) ~= 0); [z1(:,i) p1(:,i)]=tf2zp(1,r1(i,:)); end; end
%for i = 1 :m1; if(r1(i,:) ~= 0); p1s(:,i)=sort(p1(:,i));end;end
%k=1;for i = 1 : m1; if(r1(i,:) ~= 0); an1(k)=angle(p1s(2,i));k=k+1; end;end
r1=sort(abs(angle(p1)));
r1(r1==0)=100;
r2=sort(r1);
r3=r2(1,:);
r=r3;
%outF=[queryFolder1 '/' files1(j).name '.ang'];
%dlmwrite(outF,an1');
clear p*
clear z*
clear an1*
clear r1
