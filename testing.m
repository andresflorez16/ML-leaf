clc; clear all; close all;

z = [1, 2, 3];
x = [4, 5, 6];

data = {z, x}

figure(1)
hold
for i = 1:length(data(1:end))
    data{1, i}
    plot3(data{1,i}(1), data{1,i}(2), data{1,i}(3), '.r')
end
grid on