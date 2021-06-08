%load the training data
M = readtable('avila/avila-tr.txt');
x = table2array(M(:,1:10));
tags = string(table2array(M(:,11)));
n = 10430; %number of input sets

%training and testing
fprintf('Adagrad : \n');
[hidden_layer_weights, output_layer_weights] = adagrad(x,tags,30);
accuracy = test_accuracy(hidden_layer_weights, output_layer_weights)

fprintf('Adam : \n');
[hidden_layer_weights, output_layer_weights] = adam(x,tags,30);
accuracy = test_accuracy(hidden_layer_weights, output_layer_weights)