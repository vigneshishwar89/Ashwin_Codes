function distMat = computeDistMat_mod(totShpFile , startRow , stopRow)
s=textread(totShpFile,'%s','delimiter','\n');
k1=1;
s=char(s);
for i=1:2:length(s)
a1=str2num(s(i,:));
a2=str2num(s((i+1),:));
a3=[a1' a2'];
vec(k1).val=a3;
k1=k1+1;
clear a1
clear a2
clear a3
end
m=length(vec);
numRows=stopRow-startRow+1;    
distMat=zeros(numRows,m);
 parfor i = 1 : numRows
     i
     k=i+startRow-1;
     x=vec(k).val;
     for j = k+1 : m
        j;
         y=vec(j).val;
        %[distMat(i,j),a,b,c,d1,e]=dtw(x,y,0);
        [distMat(i,j)]=distLogist(x,y);
	end
 end
dlmwrite('DSatpura_2001_6000',distMat,'delimiter',' ')
