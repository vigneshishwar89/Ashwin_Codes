function r = extractAngFreq(queryFolder1,ext1,lpOrder,filt)
files1=dir(fullfile(queryFolder1,ext1));
[m n]=size(files1);
[b,a]=butter(10,filt);
sr=44100;
for j = 1 : m
    [queryFolder1 '/' files1(j).name]
    data=wavread([queryFolder1 '/' files1(j).name]);
    y=filter(b,a,data);
    [lpC,res]=lpRes(y,1024,441,lpOrder,1);
    r1=lpC;
    [m1 n1]=size(r1)
     
    for i = 1 :m1; if(r1(i,:) ~= 0); [z1(:,i) p1(:,i)]=tf2zp(1,r1(i,:)); end; end
%     for i = 1 :m1; if(r1(i,:) ~= 0); p1s(:,i)=sort(p1(:,i));end;end
%     k=1;for i = 1 : m1; if(r1(i,:) ~= 0); an1(k)=angle(p1s(2,i));k=k+1; end;end
    r1=sort(abs(angle(p1)));
    r1(r1==0)=100;
    r2=sort(r1);
    r3=r2(1,:);
    r=r3*sr/(2*pi);
    outF=[queryFolder1 '/' files1(j).name '.ang_0.02'];
    dlmwrite(outF,r');
    clear p*
    clear z*
    clear an1*
    clear r1
end
r=1;
    