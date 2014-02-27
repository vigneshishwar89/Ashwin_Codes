function R=getPrecall(resultFile,column,outF)
i=column;
a=load(resultFile);
%grt=load(gtFile);
gt=[a(:,1) a(:,2) a(:,i)];
numalaps=length(unique(gt(:,1)));
for j=1:numalaps
    ind1=find(gt(:,1)==j);
    length(ind1);
    j;
    %res(j).val=gt(ind1,:);
    hits1=gt(ind1,:);
    trueind=find(hits1(:,2)==1);
    partind=find(hits1(:,2)==2);
    numtrue=length(trueind)%+length(partind);
    hits1=sortrows(hits1,-3);
    k=1;
    x=10;
    if (numtrue~=0 && length(hits1)>x)
        %while x<length(hits1)
            topx=hits1((1:x),:);
            ind2=find(topx(:,2)==1);
            ind3=find(topx(:,2)==2);
            numtr=length(ind2)%+length(ind3);
            
            if x<=numtrue
                relevant=x;
            else
                relevant=numtrue;
            end
            precision(j)=numtr/x;
            recall(j)=numtr/relevant;
            F2M(j)=(5*precision(j)*recall(j))/((4*precision(j))+recall(j));
            k=k+1;
        %    x=x+1;
        %end
    end
end
outL=[precision' recall' F2M'];
dlmwrite(outF,outL,'delimiter',' ')
R.Precision=precision;
R.Recall=recall;
R.Fmeasure=F2M;