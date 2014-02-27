function R = synFilter(dataFrame, dataPrev,lpOrder,lpCoefs,frameSize,flag)
speechFrame=zeros(frameSize,1);
tempData=zeros(1,frameSize + lpOrder) ;
tempData=dataPrev';
dataPrevTemp=zeros(lpOrder,1);
for (i=1:frameSize)
t=0;
err=0;
	for(j=1:lpOrder)
    %err=(lpCoefs(2:lpOrder+1))*dataPrev;
         err=err+(lpCoefs(j+1)*dataPrev(-j+1+lpOrder));
    end
    speechFrame(i)=dataFrame(i) - err;
    dataPrevTemp(lpOrder)=speechFrame(i);
    dataPrevTemp(1:lpOrder-1)=dataPrev(2:lpOrder);
    dataPrev=dataPrevTemp;
    clear dataPrevTemp;
end
R=speechFrame;
