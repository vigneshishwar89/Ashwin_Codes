function contour= createContour(pitch,energy,frameShift,t1,t2,flag)
[m n]=size(pitch);
impulseSig=zeros(m*frameShift,1);
prevFrameRem=0;
frame=1;
sr=44100;
%t1=0.004;t2=0.002;
x1=[0:1/sr:t1+t2];
g(1:t1*sr)=0.5*(1-cos((2*pi*x1(1:t1*sr))/(2*t1)));
g(t1*sr+1:(t1+t2)*sr)=cos((2*pi*(x1(t1*sr+1 :(t1+t2)*sr) - t1))/(4*t2));
%figure; plot(g)
while  (frame < m*frameShift)
    ind =floor(frame/frameShift) +1;
    if pitch(ind) == 0
        frSize= frameShift*(ind+1)-frame;
        impulseSig(frame+1:frameShift*(ind+1))=(energy(ind))*rand(frSize,1);
        frame=frameShift*(ind+1);
     else
        hop=round(sr/pitch(ind));
        frame=frame+hop;
        if flag == 1
            impulseSig(frame+1:frame+ floor((t1+t2)*sr))=energy(ind)*(g);
        else
            impulseSig(frame+1:frame+ floor((t1+t2)*sr))=energy(ind);
        end
    end
end
% 
%     
% 
% 
% for i = 1:m
%     startInd=frameShift*(i-1)+1;
%     start=prevFrameRem;
%     if start < frameShift
%         if start ~= 0
%         impulseSig(startInd+start)=energy(i);
%         end
%         if pitch(i) ~= 0
%         hop=
%             for j = start + 1 : hop : frameShift-1
%                  impulseSig(startInd+hop)=energy(i);
%             end
%         prevFrameRem=rem(frameShift -start,hop);
%         else
%         frSize=frameShift-start-1;
%         size(impulseSig(startInd+start+1:startInd+frameShift-1));
%         impulseSig(startInd+start+1:startInd+frameShift-1)=(energy(i))*rand(frSize,1);
%         prevFrameRem=0;
%         end
%     else
%         prevFrameRem=PrevFrameRem+frameShift;
%     end
% end
%     
        
       contour=impulseSig;
