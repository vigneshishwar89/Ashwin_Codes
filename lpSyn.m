function [speechData] = lpSyn(res, frameSize,frameShift, lpC,lpOrder,flag)
[m n]=size(res);
numFrames= floor((m - frameSize)/frameShift) +1;
lpCoefs=lpC;
speechData=zeros(m,1);
j=1;
for i = 1 : frameShift: m- frameSize
    
    dataFrame=res(i : i+frameSize -1);
    if i == 1
        dataPrev=zeros(lpOrder,1);
    else
        dataPrev=speechData(i-lpOrder:i-1);
    end
    dataTempFrame=synFilter(dataFrame, dataPrev,lpOrder,lpCoefs(j,:),frameSize,flag);
    speechData(i:i+frameShift-1) = dataTempFrame(1:frameShift);
    j=j+1;
    
end
i=i+frameShift;  
%%correct code below, was giving for one of the files
% %last frame
%      if i < m
%         dataFrame=res(i : m);
%         frameSize=m-i+1;
%         %lpC	= lpc(hamming(frameSize).*dataFrame,lpOrder);
%         dataPrev=res(i-lpOrder:i-1);
%         dataTempFrame=resFilter(dataFrame, dataPrev,lpOrder,lpCoefs(j,:),frameSize,flag);
%         speechData(i:m) = dataTempFrame(1:frameSize);
%      end
%         
%     
    
    