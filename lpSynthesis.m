function speechData = lpSynthesis(lpC,res,frameSize,frameShift,lpOrder)
[m n]=size(res)
speechData=zeros(size(res));    
numFrames=floor((m-frameSize)/frameShift)+1
j=1;
for i = 1 : frameShift : m -frameSize
    i
    if i == 1
        tempFrame=zeros(lpOrder,1);
    else
        tempFrame=res(i-lpOrder:i-1);
    end
    dataFrame=[tempFrame' res(i:i+frameSize- 1)'];
    speechDataFrame=res(i:i+frameSize- 1);
    lpCoefs=lpC(j,:);
    for k =1:frameShift-1
        for l=1:lpOrder
            speecDataFrame(k)=speechDataFrame(k)+dataFrame(k+lpOrder-l)*lpCoefs(l+1);
        end
    end
    %tempSpeechFrame=filter(lpC(j,:),1,dataFrame);
    %speechData(i:i+frameShift -1 )= tempSpeechFrame(lpOrder:frameShift + lpOrder -1);
    speechData(i:i+frameShift -1 )= speechDataFrame(1:frameShift);
    j=j+1;
end