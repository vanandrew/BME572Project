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
diff(:,13) = (o_PO_stim - o_PO_prestim);
diff = diff'; % transpose to get oders as observations and rois as features

% create labels
labels = {...
           '1o3o02';'1o3o04';...
           'Acet02';'Acet04';...
           'Bzald02';'Bzald04';...
           'EA02';'EA04';...
           'EB02';'EB04';...
           'MH02';'MH04';...
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

% fit linear model with least squares solution

% labels 1 = high conc., -1 = low conc.
lbl = [1;-1;1;-1;1;-1;1;-1;1;-1;1;-1;-1];
w = pinv(score(:,1:2))*lbl;
x1 = -600:1:1000;
x2 = -w(1)*x1/w(2);
plot(x1,x2);
xlim([-600,1000])
ylim([-300,400]);
xlabel('First Principal Component');
ylabel('Second Principal Component');
legend({'02 Conc.','04 Conc.','PO'})
title('PCA on Avg. Power Difference (Stim - PreStim) with LMS linear classifier')

% manifold directions
figure('Position',[0,0,1000,500]);
scatter(score(1:2:12,1),score(1:2:12,2));
hold on;
scatter(score(2:2:12,1),score(2:2:12,2));
scatter(score(13,1),score(13,2));
for i=1:13
   text(score(i,1),score(i,2),labels{i},'FontSize',6);
end

% plot manifold
plt_manifold = @(x,w) quiver(score(13,1),score(13,2),x-score(13,1),w*(x-score(13,1)));

% draw manifold each oders
w1 = (score(1,2)-score(13,2))/(score(1,1)-score(13,1)); % 1o3o
w2 = (score(2,2)-score(13,2))/(score(2,1)-score(13,1));
plt_manifold(50,mean([w1,w2]));
w1 = (score(3,2)-score(13,2))/(score(3,1)-score(13,1)); % Acet
w2 = (score(4,2)-score(13,2))/(score(4,1)-score(13,1));
plt_manifold(50,mean([w1,w2]));
w1 = (score(5,2)-score(13,2))/(score(5,1)-score(13,1)); % Bzald
w2 = (score(6,2)-score(13,2))/(score(6,1)-score(13,1));
plt_manifold(50,mean([w1,w2]));
w1 = (score(7,2)-score(13,2))/(score(7,1)-score(13,1)); % EA
w2 = (score(8,2)-score(13,2))/(score(8,1)-score(13,1));
plt_manifold(700,mean([w1,w2]));
w1 = (score(9,2)-score(13,2))/(score(9,1)-score(13,1)); % EB
w2 = (score(10,2)-score(13,2))/(score(10,1)-score(13,1));
plt_manifold(1000,mean([w1,w2]));
w1 = (score(11,2)-score(13,2))/(score(11,1)-score(13,1)); % MH
w2 = (score(12,2)-score(13,2))/(score(12,1)-score(13,1));
plt_manifold(1000,mean([w1,w2]));

% set plot settings
xlim([-600,1000])
ylim([-300,400]);
xlabel('First Principal Component');
ylabel('Second Principal Component');
legend({'02 Conc.','04 Conc.','PO','1o3o','Acet','Bzald','EA','EB','MH'})
title('PCA on Avg. Power Difference (Stim - PreStim)')
