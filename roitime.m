clc;
clear;
close all;

% load data
load('oder_matrices.mat');

% get variables
var_list = who;
is_oder_mat = @(x) contains(x,'o_');
oder_tensor = [];
for i=1:numel(var_list)
   if is_oder_mat(var_list{i})
       oder_tensor = cat(3,oder_tensor,eval(var_list{i}));
   end
end

% get mean time series of each oder
mean_oder_series = squeeze(mean(oder_tensor,1))';

% do pca
[~, score] = pca(mean_oder_series);
figure;
scatter3(score(1:2:12,1),score(1:2:12,2),score(1:2:12,3));
hold on;
scatter3(score(2:2:12,1),score(2:2:12,2),score(2:2:12,3));
scatter3(score(13,1),score(13,2),score(13,3));
idx = kmeans(score,2);