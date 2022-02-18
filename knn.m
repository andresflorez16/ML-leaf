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
    trainingPositions{cnt, 1} = positions;
    cnt = cnt + 1;
end

training = {};
dataFiltered = {};
categoriesT = categories.';
cnt2 = 1;
cnt3 = 1;
for i = categoriesT
    dataFiltered{cnt2, 1} = data(data(: ,1) == i, 3:end);
    for j = trainingPositions{cnt2, 1}
        training{cnt2, 1}(cnt3, :) = [dataFiltered{cnt2, 1}(j, feature1), dataFiltered{cnt2, 1}(j, feature2), dataFiltered{cnt2, 1}(j, feature3)];
        cnt3 = cnt3 + 1;
    end
    cnt2 = cnt2 + 1;
end

rest = [];
restPositions = [];
testPositions = {};
for i = 1:length(repeatsCategories)
    rest = ~ismember(1:repeatsCategories(i), trainingPositions{i});
    restPositions = find(rest);
    testPositions{i, 1} = restPositions;
end
test = {};
cnt4 = 1;
for i = 1:length(categories)
    for j = testPositions{i, 1}
        test{i, 1}(cnt4, :) = [dataFiltered{i, 1}(j, feature1), dataFiltered{i, 1}(j, feature2), dataFiltered{i, 1}(j, feature3)];
        cnt4 = cnt4 + 1;
    end
end

figure(1)
hold
for i = 1:length(categories)
    plot3(training{i, 1}(:, 1), training{i, 1}(:, 2), training{i, 1}(:, 3), '.r')
end
plot3(test{1, 1}(1, 1), test{1, 1}(1, 2), test{1, 1}(1, 3), 'ob')
grid on
% [trainingFiltered, testFiltered] = extractTrainingNTest(data, features);