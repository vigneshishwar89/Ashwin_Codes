function R=cascadeSig(f0,f1,tou)
t=[1:1/10000:2];
alpha1=(0.05*pi)-(0.1*f0*(1/10000));
alpha2=(0.05*pi)-(0.1*f1*(1/10000));
sig1=exp(-alpha1*t).*cos(2*f0*pi*t);
sig2=exp(-alpha2*t).*cos(2*f1*pi*t);
cascadeSig=conv(sig1,sig2);
figure
plot(cascadeSig)
imp=zeros(10000,1);
k=1;k1=1;
for i=1:10000
if (mod(i,tou)==1 && i<=5001)
imp(i)=1+(tou/10000)*(k-1);
k=k+1;
elseif (mod(i,tou)==1 && i>5001)
imp(i)=1.5-(tou/10000)*(k1+1);
k1=k1+1;
end
end
excitedSig=conv(cascadeSig,imp);
figure
plot(excitedSig)
soundsc(imp,4000)