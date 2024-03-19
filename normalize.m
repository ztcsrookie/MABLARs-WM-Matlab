function [ Y ] = normalize( X )
%NORMALIZE 对矩阵规范化

X_Sum=sum(X,2);
X_Sum(X_Sum==0)=1e-32;%小心除数不能为0
Y=X./X_Sum(:,ones(1,size(X,2)));%归一化

end

