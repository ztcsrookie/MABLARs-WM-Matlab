function [sort_rule_base] = gen_rule_base(rules, rules_labels, Vs)

[num_rules,D] = size(rules);
P = size(Vs,1);
rules_base = zeros(num_rules,D+1);
rules_base(:,end) = rules_labels;
for i = 1:D
    cur_V = sort(Vs(:,i));
    for j = 1:P
        rules_base(rules(:,i) == cur_V(j),i) = j;
    end
end
sort_rule_base = sortrows(rules_base,D+1);
