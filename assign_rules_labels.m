function [rules_labels] = assign_rules_labels(X,Y,rules,sigmas)

num_rules = size(rules,1);
% [N,D] = size(X);
rules_labels = zeros(num_rules,1);

for i = 1:num_rules
%     FSs = zeros(N,1);
    cur_v = rules(i,:);
    cur_b = sigmas(i,:);
    A = -(X-cur_v).^2; % numerator
    B = 2*cur_b+1e-32; % denominator
    FSs = prod(exp(A./B),2); %firing strengths of all samples for the i-th rule
    index = find(FSs == max(FSs));
    rules_labels(i,1) = Y(index(1,1),1);
end