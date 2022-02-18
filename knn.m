clc; clear all; close all;

table = readtable('leaf.csv');
data = table.Variables;

disp('Type 3 of 14 features')
feature1 = input('Feature 1: ');
feature2 = input('Feature 2: ');
feature3 = input('Feature 3: ');
features = [feature1, feature2, feature3];

max = length(data(:, 1));
categories = unique(data(:, 1));
repeatsCategories = [];

for i=1:length(categories)
    repeatsCategories(i) = length(find(data(:, 1) == categories(i)));
end

trainingPositions = {};
percent = [];
cnt = 1;
for i = repeatsCategories
    percent(cnt) = round(i * 0.7);
    positions = randperm(i, percent(cnt));
    trainingPositions{cnt} = positions;
    cnt = cnt + 1;
end

training = {};
for i = 1:length(categories)
    for j = 1:length(trainingPositions{i})
        training{i, j} = data(trainingPositions{i}(j), 3:end);
    end
end

numberObjs = [];
cnt2 = 1;
for i = 1:length(categories)
    for j = 1:length(training(i,:))
        isEmptyObj = isempty(training{i, j});
        if ~isEmptyObj
            numberObjs(1, i) = cnt2;
            cnt2 = cnt2 + 1;
        end
    end
    cnt2 = 1;
end

trainingFiltered = {};
for i = 1:length(categories)
    for j = 1:numberObjs(i)
        trainingFiltered{i, 1}(j, :) = [training{i, j}(features(1)), training{i, j}(features(2)), training{i, j}(features(3))];
    end
end

rest = [];
restPositions = [];
testPositions = {};
for i = 1:length(repeatsCategories)
    rest = ~ismember(1:repeatsCategories(i), trainingPositions{i});
    restPositions = find(rest);
    testPositions{i} = restPositions;
end

test = {};
for i = 1:length(categories)
    for j = 1:length(testPositions{i})
        test{i, j} = data(testPositions{i}(j), 3:end);
    end
end

numberObjs = [];
cnt2 = 1;
for i = 1:length(categories)
    for j = 1:length(test(i,:))
        isEmptyObj = isempty(test{i, j});
        if ~isEmptyObj
            numberObjs(1, i) = cnt2;
            cnt2 = cnt2 + 1;
        end
    end
    cnt2 = 1;
end

testFiltered = {};
for i = 1:length(categories)
    for j = 1:numberObjs(i)
        testFiltered{i, 1}(j, :) = [test{i, j}(features(1)), test{i, j}(features(2)), test{i, j}(features(3))];
    end
end

figure(1)
hold
for i = 1:length(categories)
    plot3(trainingFiltered{i, 1}(:, 3), trainingFiltered{i, 1}(:, 1), trainingFiltered{i, 1}(:, 2), 'o')
end
grid on
% [trainingFiltered, testFiltered] = extractTrainingNTest(data, features);