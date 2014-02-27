function R=convSignals(samples)
t=[1:1/2000:5];
y=sin(2*pi*100*t);
y1=sin(2*pi*150*t);
x=y(1:samples);
h=y1(1:samples);
h1=fliplr(h);
ind=length(h);
n=samples;
convS=zeros((2*samples-1),1);
%y6=zeros(2*samples,1);
for i=1:(2*samples-1)
    for j=1:samples
        if ((i-j)>0 && (i-j)< samples)
            convS(i)= convS(i)+x(j)*h(i-j);
        end
    end
end
convSum=sum(convS);
convSig=convS;
R.convSignal=convSig;
R.convSum=convSum;