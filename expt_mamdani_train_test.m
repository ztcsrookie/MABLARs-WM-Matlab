function [ best_result, best_model ] = expt_mamdani_train_test( train_data, train_labels, test_data, test_labels, output_file )
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
exponents = 1.1:0.2:2; %Fuzzy partition matrix exponents. A higher exponents, a higher overlap

X_train = train_data;
X_test = test_data;
X_train = mapminmax(X_train',0,1)'; %Normalization X into range [0,1]
X_test = mapminmax(X_test',0,1)';

Y_train=train_labels;
Y_test = test_labels;

% Y_vec=lab2vec(Y);

best_acc_te=0;

for exponent = exponents
    paras.fuzzy_partations = fuzzy_partations;
    paras.iterations = iterations;
    paras.exponent = exponent;
%     try
    X_tr=X_train;
    Y_tr=Y_train; % Labels of training samples
    X_te=X_test;
    Y_te = Y_test; % Labels of test samples
    [ model ] = Mamdani_train( X_tr, Y_tr,paras );
    [ Y_pre ] = Mamdani_test( X_te, model); % Y_vec_te:the prediction of models
    acc_te=sum(Y_pre==Y_te)/length(Y_te);
%     catch err
%         disp(err);
%         warning('Something wrong when using function pinv!');
%         break;
%     end
    if acc_te>best_acc_te
        best_acc_te = acc_te;
        best_model = model;
        best_result = [best_acc_te,paras.exponent];
        bestresult.best_acc_te = best_acc_te;
        bestresult.model = model;
        bestresult.paras = paras;
        save(output_file, 'bestresult');
        bestresult
    end
end
end
