clc;
clear;
close all;

% load data
load('AllMatsAllOdors.mat');
load('Corrs_1o3o02.mat')
Corr_diff_o_1o3o02 = CorrMat_stim - Corr_mat_prestim;

diff = zeros(13,426424);
diff(1,:) = CorrMat_stim(logical(tril(ones(922,922),1)));
diff(2,:) = Corr_stim_o_1o3o04(logical(tril(ones(922,922),1)));
diff(3,:) = Corr_stim_o_Acet02(logical(tril(ones(922,922),1)));
diff(4,:) = Corr_stim_o_Acet04(logical(tril(ones(922,922),1)));
diff(5,:) = Corr_stim_o_Bzald02(logical(tril(ones(922,922),1)));
diff(6,:) = Corr_stim_o_Bzald04(logical(tril(ones(922,922),1)));
diff(7,:) = Corr_stim_o_EA02(logical(tril(ones(922,922),1)));
diff(8,:) = Corr_stim_o_EA04(logical(tril(ones(922,922),1)));
diff(9,:) = Corr_stim_o_EB02(logical(tril(ones(922,922),1)));
diff(10,:) = Corr_stim_o_EB04(logical(tril(ones(922,922),1)));
diff(11,:) = Corr_stim_o_MH02(logical(tril(ones(922,922),1)));
diff(12,:) = Corr_stim_o_MH04(logical(tril(ones(922,922),1)));
diff(13,:) = Corr_stim_o_PO(logical(tril(ones(922,922),1)));

% create labels
labels = {...
           '1o3o';'1o3o';...
           'Acet';'Acet';...
           'Bzald';'Bzald';...
           'EA';'EA';...
           'EB';'EB';...
           'MH';'MH';...
           'PO';
         };

% do pca
[coeff, score, latent] = pca(diff);
figure('Position',[0,0,1000,500]);
scatter(score(1:2:12,1),score(1:2:12,2));
hold on;
scatter(score(2:2:12,1),score(2:2:12,2));
scatter(score(13,1),score(13,2));
for i=1:13
   text(score(i,1),score(i,2),labels{i},'FontSize',6);
end

xlabel('First Principal Component');
ylabel('Second Principal Component');
legend({'02 Conc.','04 Conc.','PO'},'Location','northwest');
title('PCA on Corrmat Stim.')