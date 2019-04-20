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

% create labels
labels = {...
           '1o3o02';'1o3o04';...
           'Acet02';'Acet04';...
           'Bzald02';'Bzald04';...
           'EA02';'EA04';...
           'EB02';'EB04';...
           'MH02';'MH04';...
           'PO'; 'PO'
         };

% get mean time series of each oder
mean_oder_series = squeeze(mean(oder_tensor,1))';

% plot some rois
figure;
plot(squeeze(oder_tensor(44,:,13)));
hold on;
plot(squeeze(oder_tensor(23,:,6)));
plot(squeeze(oder_tensor(35,:,7)));
plot(squeeze(oder_tensor(75,:,1)));
xlabel('# Samples'); ylabel('Calcium Response');
title('Selected ROIs')

% plot mean time series for each oder
figure;
plot(mean_oder_series([1:2:12,13],:)');
ylim([160,240]);
xlabel('# Sample'); ylabel('Mean Calcium Response');
title('Mean Time Series of High Concentration Oders')
legend(labels([1:2:12,13]));

% plot mean time series for each oder
figure;
plot(mean_oder_series([2:2:12, 13],:)');
ylim([160,240]);
xlabel('# Sample'); ylabel('Mean Calcium Reponse');
title('Mean Time Series of Low Concentration Oders')
legend(labels([2:2:12,13]));