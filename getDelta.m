function [Delta] = getDelta(freq)
    k=1;
    k2=1;
    j=4;
    N=7;
    freq2=freq;
    freq1=[freq2(1);freq2(1);freq2(1);freq2;freq2(end);freq2(end);freq2(end)];
    ind=[1:length(freq1)]';
    while(j<=length(freq1) && (j+3)<=length(freq1))
        if ((j+N)<=length(freq1))
            N=7;
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
    Delta=m;