clc; clear all; close all;

table = readtable('leaf.csv');
data = table.Variables;

disp('Type 3 of 14 features')
feature1 = input('Feature 1: ');
feature2 = input('Feature 2: ');
feature3 = input('Feature 3: ');
features = [feature1, feature2, feature3];

[trainingFiltered, testFiltered] = extractTrainingNTest(data, features);