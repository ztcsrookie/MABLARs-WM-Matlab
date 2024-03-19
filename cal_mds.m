function [MDs] = cal_mds(x,Vs)
%cal_mds: Given a input, calculate its membership dgree(MD) of each fuzzy set.
%Vs has already been sorted
%outputs: The metrix of MDs. row: partitions, col: features. 
%MD_{ij}: The MD of the jth feature for the ith partition.
[P,D] = size(Vs); %P: #partitions, D: #features
MDs = zeros(P,D);
for i = 1:P
    for j = 1:D
        v1 = Vs(1,j);
        v2 = Vs(2,j);
        v3 = Vs(3,j);
        acc_x = x(:,j);
        if i==1
            if acc_x<=v1
                MDs(i, j) = 1;
            elseif (v1 < acc_x) && (acc_x<v2)
                MDs(i,j) = (acc_x - v2) ./ (v1 - v2);
            elseif v2 < acc_x
                MDs(i,j) = 0;
            end
        elseif i==2
            if acc_x <= v1
                MDs(i,j) = 0;
            elseif (v1<acc_x) && (acc_x<=v2)
                MDs(i,j) = (acc_x - v1) ./ (v2 - v1);
            elseif (v2<acc_x) && (acc_x<v3)
                MDs(i,j) = (acc_x-v3) ./ (v2 - v3);
            elseif v3<=acc_x
                MDs(i,j) = 0;
            end
        elseif i==3
            if acc_x <= v2
                MDs(i,j) = 0;
            elseif (v2<acc_x) && (acc_x<v3)
                MDs(i,j) = (acc_x-v2) ./ (v3-v2);
            elseif v3<acc_x
                MDs(i,j) = 1;
            end
        end
    end
end

