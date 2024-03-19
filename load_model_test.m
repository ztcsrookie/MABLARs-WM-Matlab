clear;
clc;

model_name = 'Sim_6k_Y1';
model_path = ['New/New_Results/WM_Results/' model_name '_05_10_same.mat'];
load(model_path);
model = bestresult.model;

dataset_name = 'Sim_6k_Y1_test_same';
data_path = ['New/Datasets_MB_infor/MAT_Datasets/' dataset_name '.mat'];
load(data_path)

MB_dataset_name = 'Sim_6k_Y1';
MB_infor = readtable(['New/Datasets_MB_infor/MB_infor/' MB_dataset_name '_train.csv']);
Feature_index = MB_infor.Parents'+1; % MB: MB, Parents: MBCD, Children: MBEF
Feature_index = Feature_index(~isnan(Feature_index));

% X_test = data(:,Feature_index);
X_test = data(:,1:end-1);

X_test(:,6) = randn(6000, 1);
% X_test(:,3) = randn(6000, 1);

Y_te = data(:,end);

X_te = mapminmax(X_test',0,1)';

[ Y_pre ] = Mamdani_test( X_te, model); % Y_vec_te:the prediction of models
acc_te = sum(Y_pre==Y_te)/length(Y_te)
