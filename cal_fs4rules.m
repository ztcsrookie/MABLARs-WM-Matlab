function [prod_FSs] = cal_fs4rules(x,rule_base, Vs)
%CAL_FS4RULES: Calculate the firing strength(FS) of the given input for each rule
%input: x: A sample. rule_base: rule_base, each element is within {1,2,3};
%output: maxFSs_labels: each row is the FSs of each rule. 
rules = rule_base(:,1:end-1);
[rules_num,D] = size(rules);
FSs = zeros(rules_num,D);
for i = 1:rules_num
    cur_rule = rules(i,:);
    for j = 1:D
        v1 = Vs(1,j);
        v2 = Vs(2,j);
        v3 = Vs(3,j);
        cur_p = cur_rule(:,j);
        cur_xj = x(:,j);
        if cur_p==1
            if cur_xj<=v1
                FSs(i,j) = 1;
            elseif (v1 < cur_xj) && (cur_xj<v2)
                FSs(i,j) = (cur_xj - v2) ./ (v1 - v2);
            elseif v2 < cur_xj
                FSs(i,j) = 0;
            end
        elseif cur_p==2
            if cur_xj <= v1
                FSs(i,j) = 0;
            elseif (v1<cur_xj) && (cur_xj<=v2)
                FSs(i,j) = (cur_xj - v1) ./ (v2 - v1);
            elseif (v2<cur_xj) && (cur_xj<v3)
                FSs(i,j) = (cur_xj-v3) ./ (v2 - v3);
            elseif v3<=cur_xj
                FSs(i,j) = 0;
            end
        elseif cur_p==3
            if cur_xj <= v2
                FSs(i,j) = 0;
            elseif (v2<cur_xj) && (cur_xj<v3)
                FSs(i,j) = (cur_xj-v2) ./ (v3-v2);
            elseif v3<cur_xj
                FSs(i,j) = 1;
            end
        end
    end
end
prod_FSs = prod(FSs,2);
end