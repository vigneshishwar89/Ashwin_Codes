function [lpCoefs res] = lpRes(data, frameSize,frameShift, lpOrder,flag)
[m n]=size(data);
numFrames= floor((m - frameSize)/frameShift) +1;
lpCoefs=zeros(numFrames+1, lpOrder + 1);
res=zeros(m,1);
j=1;
for i = 1 : frameShift: m- frameSize
    dataFrame=data(i : i+frameSize -1);
    lpC	= lpc(hamming(frameSize).*dataFrame,lpOrder);
    %lpC	= lpc(dataFrame,lpOrder);
    lpCoefs(j,:)=lpC;
    if i == 1
        dataPrev=zeros(lpOrder,1);
    else
        dataPrev=data(i-lpOrder:i-1);
        resFrame=resFilter(dataFrame, dataPrev,lpOrder,lpCoefs(j,:),frameSize,flag);
        res(i:i+frameShift-1) = resFrame(1:frameShift);
        
    end
    j=j+1;
    
end
i=i+frameShift;  

%last frame
     if i < m
        dataFrame=data(i : m);
        frameSize=m-i+1;
        lpC	= lpc(hamming(frameSize).*dataFrame,lpOrder);
        %lpC	= lpc(dataFrame,lpOrder);
        lpCoefs(j,:)=lpC;
        dataPrev=data(i-lpOrder:i-1);
        resFrame=resFilter(dataFrame, dataPrev,lpOrder,lpCoefs(j,:),frameSize,flag);
        res(i:m) = resFrame(1:frameSize);
     end
%         
%     
    
    