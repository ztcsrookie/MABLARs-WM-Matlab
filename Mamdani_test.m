function [Y_pre] = Mamdani_test(X_te, model)
Vs = model.Vs;
rules_labels = model.rules_labels;
rule_base = model.rule_base;

[N,~] = size(X_te);
Y_pre = zeros(N,1);
for i = 1:N
    cur_X_te = X_te(i,:);
    cur_FSs_x = cal_fs4rules(cur_X_te, rule_base, Vs);
    FSs = [cur_FSs_x, rules_labels];
    max_sum_FS = 0;
    for j = 1:max(rules_labels)
       cur_sum_FS = sum(FSs(rules_labels == j,1));
       if cur_sum_FS >= max_sum_FS
           max_sum_FS = cur_sum_FS;
           Y_pre(i,1) = j;
       end
    end
end
