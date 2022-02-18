clc; clear all; close all;

table = readtable('leaf.csv');
data = table.Variables;

disp('Type 3 of 14 features')
feature1 = input('Feature 1: ');
feature2 = input('Feature 2: ');
feature3 = input('Feature 3: ');

dataFormatted = data(:, 3:end);
dataSize = size(dataFormatted(:, 1));
categories = unique(data(:, 1));
repeatsCategories = zeros;
for i=1:length(categories)
    repeatsCategories(i, 1) = length(find(data(:, 1) == categories(i)));
end

categoriesFormatted = zeros;
cnt = 1;
for i=1:length(categories)
    for j = 1:repeatsCategories(i, :)
        categoriesFormatted(cnt, 1) = i;
        cnt = cnt + 1;
    end
end

dataFiltered = [dataFormatted(:, feature1), dataFormatted(:, feature2), dataFormatted(:, feature3), categoriesFormatted(:, 1)];
sizeCategories = size(categories);
category = randperm(sizeCategories(1), 1);
cat1 = [];
cat2 = [];
cnt2 = 1;
cnt3 = 1;
for i = 1:dataSize(1)
    if dataFiltered(i, 4) == category
        cat1(cnt2, :) = [dataFiltered(i, 1), dataFiltered(i, 2), dataFiltered(i, 3)];
        cnt2 = cnt2 + 1;
    elseif dataFiltered(1, 4) ~= category
        cat2(cnt3, :) = [dataFiltered(i, 1), dataFiltered(i, 2), dataFiltered(i, 3)];
        cnt3 = cnt3 + 1;
    end
end

figure(1)
hold on
grid on
plot3(cat1(:, 1), cat1(:, 2), cat1(:, 3), 'o');
plot3(cat2(:, 1), cat2(:, 2), cat2(:, 3), '.');
legend('Category 1', 'Category 2');