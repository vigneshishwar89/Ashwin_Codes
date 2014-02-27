%a=load('rawscore_list1');
for i=1:26
    ind1=find(a(:,1)==i);
    res(i).val=a(ind1,:);
    i;
    size(res(i).val);
    m1=mean(res(i).val(:,3));
    sd1=std(res(i).val(:,3));
    res(i).val(:,3)=(1/sd1)*(res(i).val(:,3)-m1);
end
finres=vertcat(res.val);