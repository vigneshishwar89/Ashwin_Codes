function [R]= align_logist(Data1, primitives)
%files=dir(fullfile(queryFolder,ext));
%[m n]=size(files);
[o p]=size(primitives);
cont=[];
%for i = 1 : m
%    i;
%    [queryFolder '/' files(i).name];
    vec=Data1;
    cont = [cont [0 0 0 0 0] vec(:,2)'];
%     mid=floor(length(vec(i).val)/2);
%     vec(i).val=vec(i).val-vec(i).val(mid);
%     vec(i).val=vec(i).val(isfinite(vec(i).val));
%     [k1,to1,r1] = getLogisticParameters(vec);
%      if (abs(k1) > 1000)
%          distMat(1,1:13) = 100;
%          distMat(1,14)=0;
%      else
        for j = 1 : p
            [distMat(1,j)]=distLogist(vec,primitives(j).val);
        end
%     end
%end

[a seq]=min(distMat');
% a1=unique(distMat');
% [seq d]=find(distMat'==a1(3));
%concat=[];

% for i = 1 : m
%     concat = [concat [0 0 0 0 0] shapes(seq(i)).val(:,2)'];
%     
% end
R.seq=seq;
R.cont=cont;
R.distmat=distMat;
%R.concat=concat;
