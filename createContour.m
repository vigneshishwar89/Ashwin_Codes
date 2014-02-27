function contour= createContour(pitch,energy,frameShift)
[m n]=size(pitch);
impulseSig=zeros(m*frameShift,1);
prevFrameRem=0;
for i = 1:m
    startInd=frameShift*(i-1)+1;
    start=prevFrameRem;
    if start < frameShift
        if start ~= 0
        impulseSig(startInd+start)=energy(i);
        end
        if pitch(i) ~= 0
        hop=round(16000/pitch(i));
            for j = start + 1 : hop : frameShift-1
                 impulseSig(startInd+hop)=energy(i);
            end
        prevFrameRem=rem(frameShift -start,hop);
        else
        frSize=frameShift-start-1;
        size(impulseSig(startInd+start+1:startInd+frameShift-1));
        impulseSig(startInd+start+1:startInd+frameShift-1)=(energy(i))*rand(frSize,1);
        prevFrameRem=0;
        end
    else
        prevFrameRem=PrevFrameRem+frameShift;
    end
end
    
        
       contour=impulseSig;