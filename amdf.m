function P= amdf(res,frameSize,frameShift,f0,cep,minFreq,maxFreq)
frames=buffer(res,frameSize,frameSize-frameShift);
[m n]=size(frames)
tpMax=floor(16000/155);
tpMin=ceil(16000/265);
[n q]=size(f0);
[r s]=size(cep);
for i = 1:n
   if f0(i)~=0
       x1=frames(:,i);
       x2=x1;
       for j = 1 : frameSize
           amdfFrame(j)=sum(abs(x1-circshift(x2,j-1)))/frameSize;
       end
       dataFrame(i,:)=amdfFrame;
       [val ind]=min(amdfFrame(tpMin:tpMax));
       pitch(i)=tpMin+ind-1;
       if i < s
        [valc indc]=max(cep(tpMin:tpMax,i));
        pitchc(i)=tpMin+indc-1;
       end
   else
       
       if i < s
        pitchc(i)=0;
       end
   end
end
pitch=16000./pitch;
pitchc=16000./pitchc;
pitch(isinf(pitch))=0;
pitchc(isinf(pitch))=0;
P.pitch_amdf=pitch;
P.pitch_cep=pitchc;
P.amdf=dataFrame;
