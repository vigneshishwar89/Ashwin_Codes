function [dist]=distLogist(dataQuery,dataRef)
%files=dir(fullfile(queryFolder,ext))
%[p q]=size(files)
%for i = 1 : p 
%dataQuery=load(query);
%dataRef=load(ref)
[k1,to1,r1] = getLogisticParameters(dataQuery);
% if (abs(k1) > 1000 )
%     k1 = 300.7882 ;  
%     to1 = 150.1624 ;   
%     r1= 0.0607;
% end
[k2,to2,r2] = getLogisticParameters(dataRef);
% if (abs(k1) > 1000 )
%     k2 = 300.7882 ;  
%     to2 = 150.1624 ;   
%     r2= 0.0607;
% end
k1=k1/100;
to1=to1/50;
k2=k2/100;
to2=to2/50;
dist1=(k2-k1)^2;
dist2=(to2-to1)^2;
dist3=(r2-r1)^2;
dist3=dist3*10;
dist=sqrt(dist1+dist2+dist3);
if (sign(r1) ~= sign(r2))
    dist = inf;
end
%figure
% plot(dataQuery(:,1),dataQuery(:,2))
% hold on
% plot(dataRef(:,1),dataRef(:,2),'r')