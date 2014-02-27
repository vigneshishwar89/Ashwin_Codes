function R = zerocrossing(flname,frameSize)
%flname=getenv('FILE1')
    wav=flname;
    [m n]=size(wav)
     zc=zeros(m,n);
    for i = 2:m
        if (sign(wav(i)) + sign(wav(i-1)) == 0)
             zc(i) = 1;
        end
    end
    for j = 1 : floor(m/frameSize)
        zeroc(j)=sum(zc((j-1)*80 + 1:j*80));
    end
   zeroc(j+1)=zeroc(j);
    R=zeroc;
%    flout=[flname '.zc'];
 %   dlmwrite(flout,zeroc')
