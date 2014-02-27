function [ERR]=getDET(resultFile,columnNumber,option)
% Options are nonorm and alapnorm. For average of all references provide i=
% 7 and i=12 for uedtw and rlcs respectively. Please enter column numbers
% from 3 onwards.
addpath ~/DETware_v2.1/
i=columnNumber;
a=load(resultFile);
gt=[a(:,1) a(:,2) a(:,i)];
if i<=7
    flag=0;
else
    flag=1;
end
%%%%%%%%%%%% No Normalization %%%%%%%%%%%%%%%%%%%%%%%
if (option == 1)
    t=gt((gt(:,2)==1),3);
    p=gt((gt(:,2)==2),3);
    f=gt((gt(:,2)==3),3);
    tr=[t;p];
    fr=[p;f];
    if flag==0
        %figure
        Eval_Spkr_Det(f,t,'b');
        hold on
        Eval_Spkr_Det(f,tr,'g');
        Eval_Spkr_Det(f,p,'r');
        Eval_Spkr_Det(fr,t,'k');
        [P_miss,P_fa] = Compute_DET (fr, t);
        [p1 d1]=min(abs(P_miss - P_fa));
        ERR=P_miss(d1);
    else
        %figure
        Eval_Spkr_Det(t,f,'b');
        hold on
        Eval_Spkr_Det(tr,f,'g');
        Eval_Spkr_Det(p,f,'r');
        Eval_Spkr_Det(t,fr,'k');
        [P_miss,P_fa] = Compute_DET (t, fr);
        [p1 d1]=min(abs(P_miss - P_fa));
        ERR=P_miss(d1);
    end

    
end
%%%%%%%%%%%%% Alap Mean and Std Deviation Normalization %%%%%%%%%%%%%%%%%
if (option == 2)
    numalaps=length(unique(gt(:,1)));
    for j=1:numalaps
        ind1=find(gt(:,1)==j);
        res(j).val=gt(ind1,:);
        j;
        size(res(j).val);
        m1=mean(res(j).val(:,3));
        sd1=std(res(j).val(:,3));
        res(j).val(:,3)=(1/sd1)*(res(j).val(:,3)-m1);
    end
    res1=vertcat(res.val);
    gt(:,3)=res1(:,3);
    t=gt((gt(:,2)==1),3);
    p=gt((gt(:,2)==2),3);
    f=gt((gt(:,2)==3),3);
    tr=[t;p];
    fr=[p;f];
    if flag==0
        %figure
        Eval_Spkr_Det(f,t,'b');
        hold on
        Eval_Spkr_Det(f,tr,'g');
        Eval_Spkr_Det(f,p,'r');
        Eval_Spkr_Det(fr,t,'k');
        [P_miss,P_fa] = Compute_DET (fr, t);
        [p1 d1]=min(abs(P_miss - P_fa));
        ERR=P_miss(d1);
    else
        %figure
        Eval_Spkr_Det(t,f,'b');
        hold on
        Eval_Spkr_Det(tr,f,'g');
        Eval_Spkr_Det(p,f,'r');
        Eval_Spkr_Det(t,fr,'k');
        [P_miss,P_fa] = Compute_DET (t, fr);
        [p1 d1]=min(abs(P_miss - P_fa));
        ERR=P_miss(d1);
    end

end

        
        
    