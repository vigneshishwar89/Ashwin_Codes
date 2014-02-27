function [xinf yinf m]=infCode(freq,pts)
%     m = [];
    k=1;
    k2=1;
    j=4;
    N=pts;
    freq2=freq;
    freq1=[freq2(1);freq2(1);freq2(1);freq2;freq2(end);freq2(end);freq2(end)];
    ind=[1:length(freq1)]';
    while(j<=length(freq1) && (j+3)<=length(freq1))
        if ((j+N)<=length(freq1))
            N=pts;
        else
            N=length(freq1)-j;
        end
        X=ind((j-3):(j+3));
        Y=freq1((j-3):(j+3));
        sum_X=sum(X);
        sum_Y=sum(Y);
        XY=X.*Y;
        XX=X.*X;
        YY=Y.*Y;
        sum_XY=sum(XY);
        sum_XX=sum(XX);
        sum_YY=sum(YY);
        norm=(N*sum_XX)-(sum_X*sum_X);
        c(k) = ((sum_XX*sum_Y) - (sum_X*sum_XY))/norm;
        m(k) = ((N*sum_XY) - (sum_X*sum_Y))/norm;
        k=k+1;
        j=j+1;
    end
    inflex=zeros(1,length(m));
    for i = 2 : length(m)
        if ((sign(m(i-1)) ~= sign(m(i)))) %& abs(m(i))>0.3)
            inflex(i)=freq(i);
        end   
    end
    m1=m(inflex~=0);

    x1=[1:length(freq)]';
    y1=freq2;
    xinf=[1;x1(inflex~=0);length(freq)];
    length(freq);
    yinf=[freq(1);y1(inflex~=0);freq(length(freq))];
%     for i=2:size(xinf)
%         xdiff(i)=xinf(i)-xinf(i-1);
%         ydiff(i)=yinf(i)-yinf(i-1);
%         tot(i,:)=[i xdiff(i) ydiff(i)];
%     end
%     for i=2:size(xinf)-1
%         %if (((xinf(i)-xinf(i-1))>=15) || ((xinf(i)-xinf(i-1))<15 && abs((yinf(i)-yinf(i-1))>100)))  
%         %if((xdiff(i)>3 && abs(ydiff(i))>=100) || (xdiff(i)<=3 && abs(ydiff(i))>=100))
%         if (abs(ydiff(i))>=100 || abs(ydiff(i+1))>=100)
%            xinf1(k2)=xinf(i);
%            yinf1(k2)=yinf(i);
%            %xinf(i)=xinf(i-1)
%            k2=k2+1;
%         end
%     end
%     if (xinf1(end)~=length(freq2))
%         xinf1=[1 xinf1 length(freq2)]';
%     elseif (xinf1(end)==length(freq2))
%         xinf1=[1 xinf1]';
%     end
%     if (yinf1(end)~=freq2(end))    
%         yinf1=[freq2(1) yinf1 freq2(end)]';
%     elseif (yinf1(end)==freq2(end))
%         yinf1=[freq2(1) yinf1]';
%     end

     %figure
     %plot(freq2,'.k')
     %hold on
     %stem(xinf1,yinf1,'or')
     %stem(xinf,yinf,'ok')
     %plot(m,'r')
    clear freq
    clear freq1
    clear freq2
   % clear m
    clear c
    clear xinf2
    clear yinf2
    clear k2
