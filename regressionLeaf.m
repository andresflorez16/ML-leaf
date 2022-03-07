clc; clear all; close all;

table = readtable('leaf.csv');
data = table.Variables;
dataset = data(data(:, 1) < 11, :);

X = dataset(:, [6, 8]);
y = dataset(: , 1) == 1;

[m, n] = size(X);
X = [ones(m, 1) X];
options = optimset('GradObj', 'on', 'MaxIter', 400);
for i = 1:10
    y = dataset(: , 1) == i;

    initial_theta = zeros(n + 1, 1);

    [cost, grad] = costFunction(initial_theta, X, y);

    [theta, cost] = ...
        fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);
    fprintf('cost %f\n', cost); % title(sprintf('Train Accuracy: %f\n', mean(double(p == y)) * 100))
    fprintf('category %f\n', i);
    
    plotDecisionBoundary(theta, X, y, i);
  
    p = predict(theta, X);
    title(sprintf('Train Accuracy: %d\n', mean(double(p == y)) * 100))
    fprintf('Train Accuracy: %f\n', mean(double(p == y)) * 100);
end
