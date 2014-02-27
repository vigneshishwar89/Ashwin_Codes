function [R] = cepst(data, frameSize,frameShift,lpOrder)
[m n]=size(data);
inFrameSize=frameSize;
numFrames= floor((m - frameSize)/frameShift) +1
%cepstrum=zeros(2*frameSize,numFrames);
j=1;
for i = 1 : frameShift: m- frameSize
    dataFrame=hamming(frameSize).*data(i : i+frameSize -1);
    outData(j,:)=dataFrame;
    spec=fft(dataFrame,frameSize);
    logSpec=log(abs(spec));
    cep=ifft(logSpec,2*frameSize);
    cep=ifft(log(abs(fft(dataFrame))));
    cepstrum(:,j)=cep;
    j=j+1;
end
i=i+frameShift;  

%last frame
     if i < m
        frameSize=m-i+1;
        dataFrame=data(i : m);
        spec=fft(dataFrame,2*inFrameSize);
        logSpec=log(abs(spec));
        cep=ifft(logSpec,2*inFrameSize);
        cep=ifft(log(abs(fft(dataFrame,2*frameSize))));
        cepstrum(:,j)=cepstrum(:,j-1);
     end
%         
%
for i = 1: j;
    cep=cepstrum(2:frameSize,i);
    lpC(i,1)=1;
    lpC(i,2)=-cep(1);
    for m=3:lpOrder+1;
        sum=0;
        for k = 2:m-1
            sum=sum + (m-1-k)*(cep(m-k)*lpC(2));
        end
        lpC(i,m)=-cep(m)/(m-1) +sum/(m-1);
    end
end

R.cepstrum=cepstrum;
R.lpC=lpC;
R.outData=outData;
