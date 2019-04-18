clc;
clear;
close all;

% load data
load('AllMatsAllOdors.mat');
load('Corrs_1o3o02.mat')
Corr_diff_o_1o3o02 = CorrMat_stim - Corr_mat_prestim;

diff = zeros(13,426424);
diff(1,:) = Corr_diff_o_1o3o02(logical(tril(ones(922,922),1)));
diff(2,:) = Corr_diff_o_1o3o04(logical(tril(ones(922,922),1)));
diff(3,:) = Corr_diff_o_Acet02(logical(tril(ones(922,922),1)));
diff(4,:) = Corr_diff_o_Acet04(logical(tril(ones(922,922),1)));
diff(5,:) = Corr_diff_o_Bzald02(logical(tril(ones(922,922),1)));
diff(6,:) = Corr_diff_o_Bzald04(logical(tril(ones(922,922),1)));
diff(7,:) = Corr_diff_o_EA02(logical(tril(ones(922,922),1)));
diff(8,:) = Corr_diff_o_EA04(logical(tril(ones(922,922),1)));
diff(9,:) = Corr_diff_o_EB02(logical(tril(ones(922,922),1)));
diff(10,:) = Corr_diff_o_EB04(logical(tril(ones(922,922),1)));
diff(11,:) = Corr_diff_o_MH02(logical(tril(ones(922,922),1)));
diff(12,:) = Corr_diff_o_MH04(logical(tril(ones(922,922),1)));
diff(13,:) = Corr_diff_o_PO(logical(tril(ones(922,922),1)));

% pca
[~, score, ~] = pca(diff);

% create labels
labels = {...
           '1o3o';'1o3o';...
           'Acet';'Acet';...
           'Bzald';'Bzald';...
           'EA';'EA';...
           'EB';'EB';...
           'MH';'MH';...
         };
     
% plot score for each observation
figure;
for i=1:2:12
scatter(score(i:i+1,1),score(i:i+1,2))
hold on;
end
%legend(labels(1:2:12));

figure;
for i=1:2:12
scatter(score(i:i+1,2),score(i:i+1,3))
hold on;
end
%legend(labels(1:2:12));

figure;
for i=1:2:12
scatter(score(i:i+1,1),score(i:i+1,3))
hold on;
end
%legend(labels(1:2:12));