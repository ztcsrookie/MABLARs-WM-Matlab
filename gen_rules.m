function [Rule_base] = gen_rules(X,Y,Vs)
% Generate rules

[N,D] = size(X); %N #sample; D #features
P = size(Vs,1); %P #partations of each features
Rule_candidates = zeros(N,D); %The rule candidates. Each row represents a rule. 
max_FSs = zeros(N,1);

for i = 1:N
    cur_MDs = cal_mds(X(i,:),Vs);
    [max_MD,max_idxs] = max(cur_MDs);
    max_FSs(i,1) = prod(max_MD);
    Rule_candidates(i,:) = max_idxs;
end

Rules_set = unique(Rule_candidates, 'rows', 'stable');
Rule_base = zeros(size(Rules_set,1), size(Rules_set,2)+1);
FSs_labels = [max_FSs, Y];

for i = 1:size(Rules_set,1)
    [idx1,~] = ismember(Rule_candidates,Rules_set(i,:),'rows');
    FSs = FSs_labels(idx1,:);
    cur_rule_candidates = Rule_candidates(idx1,:);
    max_fs = max(FSs(:,1));
    row_idx = FSs(:,1) == max_fs;
    cur_rule_label = FSs(row_idx,end);
    cur_rule = [cur_rule_candidates(row_idx,:),cur_rule_label];
    Rule_base(i,:) = cur_rule(1,:);
end

