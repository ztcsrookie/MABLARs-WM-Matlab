function [ Y ] = normalize( X )
%NORMALIZE �Ծ���淶��

X_Sum=sum(X,2);
X_Sum(X_Sum==0)=1e-32;%С�ĳ�������Ϊ0
Y=X./X_Sum(:,ones(1,size(X,2)));%��һ��

end

