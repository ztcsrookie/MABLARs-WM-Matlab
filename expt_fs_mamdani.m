function [ best_result, best_models ] = expt_fs_mamdani( data, labels, output_file )
% Generate a Mamdani fuzzy classification system rule base.
% The Wang-Mendel algorithm [1] is adopted
% Membership function of inputs: Gaussian membership function
% Membership function of output: Single point function. See (6) in [2].
% The parameters of Gaussian membership function is adopted by FCM
% algorithms
% [1] Generating Fuzzy Rules by Learning from Examples.
% [2] A fuzzy classifier based on Mamdani fuzzy logic system and genetic
% algorithm.

fuzzy_partations = 3; %Number of fuzzy partations of each variables
iterations = 3000; %number of iterations of FCM
exponents = 1.1:0.1:2; %Fuzzy partition matrix exponents. A higher exponents, a higher overlap
thresholds = 0.1:0.1:0.8;

[~,D] = size(data);

% X = data;
% X=mapminmax(X',0,1)'; %Normalization X into range [0,1]

Y=labels;
% Y_vec=lab2vec(Y);

folds_num=5;
masks_te=cv_fold(folds_num,Y);
best_acc_te=0;
results = zeros(folds_num,1);
% try
for threshold = thresholds
%     [idx,~] = fscchi2(data, labels);
    [idx,~] = fscmrmr(data, labels);
%     [idx,~] = relieff(data, labels, 10);
    
    fea_nums = ceil(threshold*D);
    X = data(:,idx(1:fea_nums));
%     [idx,weights] = relieff(Normal_X, labels,10);
    for exponent = exponents
        paras.fuzzy_partations = fuzzy_partations;
        paras.iterations = iterations;
        paras.exponent = exponent;
        models = cell(folds_num,1);
        for fold=1:folds_num
            mask_te=masks_te{fold,1};
            mask_tr=~mask_te;
            X_tr=X(mask_tr,:);
            Y_tr=Y(mask_tr,:); % Labels of training samples
            X_te=X(mask_te,:);
            Y_te = Y(mask_te,:); % Labels of test samples
            [ model ] = Mamdani_train( X_tr, Y_tr,paras );
            [ Y_pre ] = Mamdani_test( X_te, model); % Y_vec_te:the prediction of models
            acc_te=sum(Y_pre==Y_te)/length(Y_te);
            results(fold,1)=acc_te;
            models{fold,1} = model;
        end
        % catch err
        %     disp(err);
        %     warning('Something wrong when using function pinv!');
        %     break;
        % end
        acc_te_min = min(results(:,1));
        acc_te_max = max(results(:,1));
        acc_te_mean = mean(results(:,1));
        acc_te_std = std(results(:,1));
        if acc_te_mean>best_acc_te
            best_acc_te=acc_te_mean;
            best_models = models;
            best_result = [acc_te_mean,acc_te_std,acc_te_min,acc_te_max,paras.exponent];
            bestresult.best_acc_te = best_acc_te;
            bestresult.acc_te_std = acc_te_std;
            bestresult.acc_te_min = acc_te_min;
            bestresult.acc_te_max = acc_te_max;
            bestresult.models = best_models;
            bestresult.fea_nums = fea_nums;
            bestresult.paras = paras;
            bestresult.idx = idx;
            save(output_file, 'bestresult');
            bestresult
        end
    end
end
end
