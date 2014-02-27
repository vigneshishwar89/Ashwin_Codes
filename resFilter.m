function R = resFilter(dataFrame, dataPrev,lpOrder,lpCoefs,frameSize,flag)
resFrame=zeros(frameSize,1);
tempData=zeros(1,frameSize + lpOrder) ;
tempData=[dataPrev' dataFrame'];
for(i=1:frameSize)
t=0;
err=0;
	for(j=1:lpOrder)
          err=err+(lpCoefs(j+1)*tempData(-j+i+lpOrder));
    end
          resFrame(i)=dataFrame(i)-(-err);
          speechFrame(i)=dataFrame(i)-(err);
end
if (flag==1)
    R=resFrame;
else
    R=speechFrame;
    flag
end