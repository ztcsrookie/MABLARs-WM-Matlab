clear;
clc;

tic;

all_data_files = {'Authorship','Breast','Dry_bean','Ecoli','Glass','Haberman','HTRU2','Iris', ...
    'mammographic', 'Page_blocks', 'Penditgits','Pima_diabetes', ...
    'Sonar', 'Vehicle','Vowel', 'Waveform_5000','Wine'};


% small_data_files = {'Glass', 'Vehicle', 'Sonar', 'Haberman', 'Pima_diabetes',
%     'Authorship', 'mammographic', 'Iris', 'Ecoli', 'Wine','Breast', 'Vowel'};

% large_data_files = {'HTRU2', 'Penditgits', 'Waveform_5000', 'Page_blocks', 'Dry_bean'};


for data_file = all_data_files
    data_set_name = data_file{1};
    data_set_name
    %%load MB_infor
    MB_infor = readtable(['Datasets_MB_infor/MB_infor/' data_set_name '.csv']);
    Feature_index = MB_infor.Parents'+1;
    Feature_index = Feature_index(~isnan(Feature_index));
    if isempty(Feature_index)
        warning_str = ['NO CD in: ' data_set_name];
        display(warning_str);
        continue;
    else
        %%load the data set
        load(['Datasets_MB_infor/MAT_Datasets/' data_set_name '.mat']);
        result_file = ['Results/MBCD_WM_Results/' data_set_name '.mat'];
        try
            [best_result,best_model]=expt_mamdani(data(:,Feature_index), data(:,end), result_file);
        catch
            warning_str = ['Something wrong in: ' data_set_name];
            display(warning_str);
        end
    end
end
toc;

