clear;
clc;
% load('MB_Results/MB_pima_diabetes_R3_newmf.mat');
load('RGCD_Results/iris.mat');
rule_numbers = zeros(5,1);
for i = 1:5
    i
    cur_rule_base = bestresult.models{i,1}.rule_base;
    rule_numbers(i,1) = size(cur_rule_base,1);
end
avg_rule_numbers = mean(rule_numbers)
std = std(rule_numbers)