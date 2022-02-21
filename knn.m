clc; clear all; close all;

table = readtable('leaf.csv');
data = table.Variables;

disp('Type 3 of 14 features')
feature1 = input('Feature 1: ');
feature2 = input('Feature 2: ');
feature3 = input('Feature 3: ');

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
    cnt3 = 1;
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
    cnt4 = 1;
end

disp('Type categories of test')
myCategory1 = input('Category 1: ');
myCategory2 = input('Category 2: ');
myCategory3 = input('Category 3: ');
myCategory4 = input('Category 4: ');
myCategories = [myCategory1, myCategory2, myCategory3, myCategory4];
symbolss = [ "o"; "+"; "*"; "."; "x";  "v"; "^"; "s"; "d"; "^"; "v"; "<"; ">"; "p"; "h"; "+"; "*"; "."; "x"; "v"; "^"; "s"; "d"; "^"; "v"; "<"; ">"; "p"; "h"; "o";];
figure(1)   
hold
dist = .1;
distances = {};
knnDistances = {};
for k = 1:length(myCategories)
    for i = 1:length(categories)
        plot3(training{i, 1}(:, 1), training{i, 1}(:, 2), training{i, 1}(:, 3), symbolss(i), 'color', [rand(1) rand(1) rand(1)])
        distances{i, k}(:, 1) = pdist2([test{myCategories(k), 1}(1, 1), test{myCategories(k), 1}(1, 2), test{myCategories(k), 1}(1, 3)], [training{i, 1}(:, 1), training{i, 1}(:, 2), training{i, 1}(:, 3)], 'euclidean');
    end
end
[x,y,z] = sphere();
rad = dist;
for i = myCategories
    surf(rad*x+test{i, 1}(1, 1), rad*y+test{i, 1}(1, 2), rad*z+test{i, 1}(1, 3), 'FaceAlpha', .08)
end
view(45, 10)

cnt1 = 1;
cnt2 = 1;
for k = 1:length(myCategories)
    for i = 1:length(distances)
        for j = 1:length(distances{i, k}(:, 1))
            isRange = distances{i, k}(j, :) <= dist;
            if isRange
                knnDistances{i, k}(cnt1, :) = distances{i, k}(j, :);
                cnt1 = cnt1 + 1;
            end
        end
        cnt1 = 1;
    end
end

clasifica = [];
rendimientoTraining = [];
for k = 1:length(myCategories)
    for i = 1:length(knnDistances)
        clasifica(i, k) = length(knnDistances{i, k});
        rendimientoTraining(i, k) = ((clasifica(i, k) / length(training{i,1})) * 100);
    end
end
    
maxPercent = [];
results = [];
cnt = 1;
for k = 1:length(myCategories)
    maxPercent(k) = max(rendimientoTraining(:, k));
    for i = 1:length(rendimientoTraining)
        if rendimientoTraining(i, k) == maxPercent(k)
            results(k, 1) = maxPercent(k);
            results(k, 2) = cnt;
        end
        cnt = cnt + 1;
    end
    cnt = 1;
end

trues = [];
for k = 1:length(myCategories)
    if results(k, 2) == myCategories(k)
        trues(k) = 1;
    else
        trues(k) = 0;
    end
end

uniques = unique(trues, 'stable');
acertados = length(find(trues == 1));
percentClasificador = (acertados / length(trues)) * 100

figure(2)
bar(length(trues), percentClasificador)
title('% Rendimiento Clasificador vs categorías test')
ylabel('% Rendimiento Clasificador')
xlabel('Categorías test')

figure(3)
hold on
title('% Rendimiento vs categorías training')
for k = 1:length(myCategories)
    bar(rendimientoTraining(:, k))
end
ylabel('% Rendimiento')
xlabel('Categorías training')



