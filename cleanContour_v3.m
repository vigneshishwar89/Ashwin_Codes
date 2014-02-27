function R=cleanContour(queryFolder,ext)
files=dir(fullfile(queryFolder,ext));
[p q]=size(files);
for t=1:p
    k=1;
    k1=1;
    k2=1;
    ctrFile=files(t).name
    ctr1=load(ctrFile);
    ctr1(ctr1==-Inf)=0;
    zind=find(ctr1);
    ctr=ctr1(zind(1):zind(end));
    len1=length(ctr1);
    len2=length(ctr);
    len3=len1-len2
    flag=0;
    startind=[];
    for i=2:length(ctr)
        if(ctr(i)==0)
            flag=1;
        else
            flag=0;
        end
        if flag==1
            i;

            if(ctr(i)==0 && ctr(i-1)~=0)
                startind(k1)=(i-1);
                %k1=k1+1;
            end
            if(ctr(i)==0 && ctr(i+1)~=0)
                endind(k1)=(i+1);
                k1=k1+1;
            end
        end
    end
    
    if(length(startind) ~= length(endind))
        error('length(startind) ~= length(endind)');
    end
    
    for j=1:length(startind)
        x1(j)=startind(j);
        x2(j)=endind(j);
        y1(j)=ctr(startind(j));
        y2(j)=ctr(endind(j));
        m(j)=(y2(j)-y1(j))/(x2(j)-x1(j));
        x=[startind(j):endind(j)];
        y(j).val=(m(j)*x)+y1(j)-(m(j)*x1(j));
        ctr(x)=y(j).val;
    end
%     for j=1:length(startind)
%         x1(j)=startind(j)-3;
%         x2(j)=endind(j)+3;
%         x=[x1(j):x2(j)];
%         y1(j)=ctr(x1(j))
%         y2(j)=ctr(x2(j))
%         pp=pchip([x1(j) x2(j)],[y1(j) y2(j)]);
%         y(j).val=fnval(pp,x);
%         ctr(x)=y(j).val;
%     end
    
    %fill1=-Inf*ones(len3,1);
    ctr=[ctr];     %fill1;ctr];
    outF=[ctrFile '.mod_spl'];
    dlmwrite(outF,ctr)
    clear startind
    clear endind
    clear k
    clear k1
end

R.files=files;