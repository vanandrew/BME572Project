clc;
clear;
close all;

% load data
load ('GlobalOdorStimMat.mat');

% difference power
diff = zeros(922,12);
diff(:,1) = (o_1o3o02_stim - o_1o3o02_prestim);
diff(:,2) = (o_1o3o04_stim - o_1o3o04_prestim);
diff(:,3) = (o_Acet02_stim - o_Acet02_prestim);
diff(:,4) = (o_Acet04_stim - o_Acet04_prestim);
diff(:,5) = (o_Bzald02_stim - o_Bzald02_prestim);
diff(:,6) = (o_Bzald04_stim - o_Bzald04_prestim);
diff(:,7) = (o_EA02_stim - o_EA02_prestim);
diff(:,8) = (o_EA04_stim - o_EA04_prestim);
diff(:,9) = (o_EB02_stim - o_EB02_prestim);
diff(:,10) = (o_EB04_stim - o_EB04_prestim);
diff(:,11) = (o_MH02_stim - o_MH02_prestim);
diff(:,12) = (o_MH04_stim - o_MH04_prestim);
diff = diff'; % transpose to get oders as observations and rois as features

% create labels
labels = {...
           '1o3o';'1o3o';...
           'Acet';'Acet';...
           'Bzald';'Bzald';...
           'EA';'EA';...
           'EB';'EB';...
           'MH';'MH';...
         };

% do pca
[coeff, score, latent] = pca(diff);

% plot score for each observation
figure;
for i=1:2:12
scatter3(score(i:i+1,1),score(i:i+1,2),score(i:i+1,3))
hold on;
end
legend(labels(1:2:12));