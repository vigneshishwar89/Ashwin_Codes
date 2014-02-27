function R = bigram(arr)
[m n]=size(arr);

for i =1:8
    num=zeros(m,n);
    num(arr==i)=1;
    uni(i)=sum(num);
end
bigcount=zeros(8,8);
for i = 1: m-1
        bigcount(arr(i),arr(i+1))=bigcount(arr(i),arr(i+1))+1;
end
for i = 1 : 8
    bigram(i,:)=bigcount(i,:)/uni(i);
end
R.b=(10^3)*bigram;
R.u=uni;
R.bi=bigcount;