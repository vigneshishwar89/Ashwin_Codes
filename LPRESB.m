function [lpCoefs res] = lpRes(data, frameSize,frameShift, lpOrder)
[m n]=size(data);
numFrames= (m - frameSize)/frameShift +1;
lpCoefs=zeros(numFrames, lpOrder + 1);
res=zeros(m,1);
j=1;
for i = 1 :frameShift:numFrames -1
    dataFrame=data(i : i+frameSize -1);
    lpC	= lpc(hamming(frameSize).*dataFrame,lpOrder);
    lpCoefs(j,:)=lpC;
    if i == 1
        dataPrev=zeros(lpOrder,1);
    else
        dataPrev=data(i-lpOrder:i-1);
        resFrame=resFilter(dataFrame, dataPrev,lpOrder,lpCoefs(j,:))
        res(i:i+frameShift-1) = resFrame(1:frameShift);
        
    end
    j=j+1;
    l=i
end
    k=i

%last frame
        
    
    
    