%function lpcc = LinerPCC(flname)
flname=getenv('FILE1');
order=20;
data=wavread(flname);
[lpC,res]=lpRes(data,400,200,12,1);
[m n]=size(lpC);
lpcoef=lpC(:,2:n);
for i = 1:m
    c(i,1:n-1)=-lpcoef(i,:);
    c(i,n:order)=0;
    for j = 2:n-1
        c(i,j)=c(i,j)+(1/j)*((-j+[1:j-1])*(lpcoef(i,1:j-1).*c(i,j-[1:j-1]))');
    end
    for j=n:order
        c(i,j)=c(i,j)+(1/j)*((-j+[1:n-1])*(lpcoef(i,1:n-1).*c(i,j-[1:n-1]))');
    end
end
lpcc=c;
outFile=[flname '.lpcc'];
dlmwrite(outFile,lpcc,'delimiter',' ');
