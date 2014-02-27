function eng= computeEnergy(data,frameSize,frameShift);
[m n]=size(data);
numFrames=floor((m/frameShift))+1;
for i = 1: numFrames-1
    
    dataFrame=data(frameShift*(i-1)+1:frameShift*(i));
    eng(i)=sqrt(mean(dataFrame.*dataFrame));
end
% dataFrame=data(frameShift*(i-1)+1:m);
% eng(numFrames)=sqrt(mean(dataFrame.*dataFrame));

    