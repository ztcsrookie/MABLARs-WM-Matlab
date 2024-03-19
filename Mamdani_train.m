function [ model ] = Mamdani_train( X, Y, paras )
%Generate rules of Mamdani fuzzy classification systems
% P: Number of fuzzy partations
% N: Number of samples
% D: Number of features

P = paras.fuzzy_partations; 
fcm_options = [paras.exponent, paras.iterations, NaN, false];
[~,D] = size(X);
% num_rules = P.^D;

% rules = zeros(num_rules,D); %centers of rules
% sigmas = zeros(num_rules,D); %sigma of rules
% rules_labels = zeros(num_rules,1); %label of rules
Vs = zeros(P,D);
Bs = zeros(P,D);

for i = 1:D
    cur_x = X(:,i);
    [V, U] = fcm(cur_x, P, fcm_options);
%     con = isnan(V);
%     if con
%         [U,V] = kmeans(cur_x, P);
%     end
    Vs(:,i) = V;
end

Vs = sort(Vs);
[rule_base] = gen_rules(X, Y, Vs);


model.Vs = Vs;
model.rules = rule_base(:,1:end-1);
model.rules_labels = rule_base(:,end);
model.rule_base = rule_base;
