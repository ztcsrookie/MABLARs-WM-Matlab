function [dataset_names] = get_dataset_names(fold_path,file_type)

data_set_files = dir(fullfile(fold_path, file_type));
dataset_names = {data_set_files.name};

for i = 1:length(dataset_names)
    [~, dataset_names{i}, ~] = fileparts(dataset_names{i});
end
