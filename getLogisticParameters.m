function  [K,t0,r] = getLogisticParameters(Data)
T=Data(:,1);
M=Data(:,2);
r=linspace(0.01,0.6,40);
t0=linspace(min(floor(T)),max(ceil(T)),40);
[r,t0]=meshgrid(r,t0);
e=zeros(size(r));
[m,n]=size(r);
% for i=1:m
%     for j=1:n
%     e(i,j)=myerror([r(i,j);t0(i,j)],T,M);
%     end
% end
% mesh(r,t0,e)
mini=fminsearch(@myerror,[0.1;50],[],T,M);
r=mini(1);
t0=mini(2);
H=1./(1+exp(-r*(T-t0)));
K=(H'*M)/(H'*H);
t=linspace(min(floor(T)),max(ceil(T)));
y=K./(1+exp(-r*(t-t0)));
% plot(T,M,'o',t,y)