clear;
clc;
% 指定文件夹路径
rule_generation_name = 'MBEF';
dataset_path = [rule_generation_name '_Results'];

% 获取文件夹下所有CSV文件的文件名
data_set_files = dir(fullfile(dataset_path, '*.mat'));
data_file_names = {data_set_files.name};

% 删除文件名中的CSV后缀
for i = 1:length(data_file_names)
    [~, data_file_names{i}, ~] = fileparts(data_file_names{i});
end


num_data_set = size(data_file_names,2);
result_cell = cell(num_data_set,3);

data_set_index = 1;
for data_file_name = data_file_names
    data_set_name = data_file_name{1};
    load([dataset_path '/' data_set_name '.mat' ]);
    result_cell{data_set_index, 1} = data_set_name;
    result_cell{data_set_index, 2} = bestresult.best_acc_te;
    result_cell{data_set_index, 3} = bestresult.acc_te_std;
    data_set_index = data_set_index+1;
end

result_table = cell2table(result_cell, 'VariableNames', {'Data_set_name', 'Mean', 'Std'});
writetable(result_table, [rule_generation_name '_results.csv']);

