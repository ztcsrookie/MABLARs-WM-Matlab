clear;
clc;
% 指定文件夹路径
rule_generation_name = 'MB';
dataset_path = [rule_generation_name '_Results'];

% 获取文件夹下所有CSV文件的文件名
file_type = '*.mat';
data_set_files = dir(fullfile(dataset_path, file_type));
data_file_names = {data_set_files.name};

% 删除文件名中的CSV后缀
for i = 1:length(data_file_names)
    [~, data_file_names{i}, ~] = fileparts(data_file_names{i});
end

data_file_names = {'Sim_Y1', 'Sim_Y2', 'Sim_Y3'};

num_data_set = size(data_file_names,2);
rules_cell = cell(num_data_set,3);

data_set_index = 1;
for data_file_name = data_file_names
    data_set_name = data_file_name{1};
    load([dataset_path '/' data_set_name '.mat' ]);
    nums_rules = zeros(5,1);
    for i = 1:5
        cur_rule_base = bestresult.models{i,1}.rules;
        nums_rules(i,1) = size(cur_rule_base,1);
    end
    rules_cell{data_set_index, 1} = data_set_name;
    rules_cell{data_set_index, 2} = mean(nums_rules);
    rules_cell{data_set_index, 3} = std(nums_rules);
    data_set_index = data_set_index+1;
end

result_table = cell2table(rules_cell, 'VariableNames', {'Data_set_name', 'Mean', 'Std'});
% writetable(result_table, [rule_generation_name '_rules_results.csv']);