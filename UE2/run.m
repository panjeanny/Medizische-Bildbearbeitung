%%%%%%%%%%%%%%%%%%%%%%%%
%% Exercise 2 %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%
%% Part 1, Shape Modell
clear all;
close all;

load 'handdata';

shape = reshape(aligned,[size(aligned,1)*size(aligned,2),size(aligned,3)]);
[V,D] = ourPCA(shape'); % eigenvector from high dimensional spce
meanshape = mean(shape,2);

v = V(:,1:50);
d = D(1:50);

b=ones(50,1);
figure

scaling = [[2,0];[0,2]];
subplot(2,2,1)
plotShape(meanshape,v,b, scaling,[],[],[]);
title('Scaled larger');
axis equal;
%plotShape(meanshape,v,b, scaling, rotation, xtranslation, ytranslation);

rotation = [[0,-1];[1,0]];
subplot(2,2,2)
plotShape(meanshape,v,b, [],rotation,[],[]);
title('Rotated, 90 degree');
axis equal;

subplot(2,2,3)
xtranslation = 100;
plotShape(meanshape,v,b, [],[],xtranslation,[]);
title('XTranslated');
axis equal;

subplot(2,2,4)
ytranslation = 100;
plotShape(meanshape,v,b, [],[],[],ytranslation);
title('YTranslated');
axis equal;

%% Part 2: Feature Extraction %%
% Structure of feature Matrix:
% [Gray Gx Gy Mag haarlike'(20 cols) haarlike_mag'(20 clos) Xcor Ycor];
% Gx, Gy ... Gradients in x and y
% Mag ... Magnitude of Gradient

addpath('providedFunctions');

image = images{1};
[m, n] = size(image);
features = computeFeatures(image);
%imagesc(features(:,45), features(:,46), features(:,1));
figure;
subplot(2,4,1)
imagesc(reshape(features(:,1),m ,n));  
title('Grayvalues');
subplot(2,4,2)
imagesc(reshape(features(:,2),m ,n));  
title('Gradient in X-Direction');
subplot(2,4,3)
imagesc(reshape(features(:,3),m ,n));  
title('Gradient in Y-Direction');
subplot(2,4,4)
imagesc(reshape(features(:,4),m ,n));  
title('Gradient Magnitude');
subplot(2,4,5)
imagesc(reshape(features(:,5),m ,n));  
title('Haarlike (1. column)'); %% Here it is just turquoise
subplot(2,4,6)
imagesc(reshape(features(:,25),m ,n));  
title('Haarlike Magnitude (1. column)');
subplot(2,4,7)
imagesc(reshape(features(:,45),m ,n));  
title('X Coordinate');
subplot(2,4,8)
imagesc(reshape(features(:,46),m ,n));  
title('Y Coordinate');

%% Part 3: Classification & Feature SElection Goal is to classify edges of objects to be segmented.
% The Random Forest classifier implemented in TreeBagger has to be used
%% a
rf = trainRF(images,masks);

%% b
% 
% err = oobError(rf);
% figure;
% plot(err);

%% b
figure;
plot(rf.oobError);

%% c
figure;
bar(rf.OOBPermutedVarDeltaError)
% Major Peaks at:
% Feature 45, => x coordinate
% Feature 1  => Gray Value
% Feature 3  => gradient y direction
% Feature 9,13,18  => Part of Haarlike Features
% Feature 25, 26,27, 31, 35, 39 => Part of Haarlike Magnitude

%% Exercise 2 - Part 4 Shape Particle Filters
%% a
[rf, V, D] = train(images(1:30),masks(1:30), shape(:,1:30));
[YFit,score] = predictSegmentation(rf, images{31});
[m n] = size(images{31});
yfit_reshape = reshape(YFit,m ,n);

%GT=reshape(masks{31},m*n,1);

figure
imagesc(yfit_reshape);

%% 4b - implementing the const function & 4c - differential evolution

for i = 31:33%50
    [YFit,score] = predictSegmentation(rf, images{i});
    
    % Initalize fitting parameters p
    [m n] = size(images{i});
    p_init = -3*sqrt(D);
    p_init = [p_init;-((2*pi)/360)*20;0.9;size(score,1)*0.4;size(score,1)*0.4];
    p_max = 3*sqrt(D);
    p_max = [p_max;(2*pi)/360*20;1.2;size(score,1)*0.6;size(score,1)*0.6];
    scores=reshape(score(:,1),m,n); 

    costen=makeCostFunction(scores,V,meanshape);
    m=optimize(costen,p_init,p_max);
    shape=generateShapeNew(meanshape,V,m);
    shape_reshape = reshape(shape,64,2);
    
    if i>31
       diff = last_shape-shape_reshape;
       figure
        plot(diff(:,1),diff(:,2));
        title(['Image Differences ',num2str(i-1), ' and ', num2str(i)])
    end
    
    last_shape = shape_reshape;
    
    figure
    plot(shape_reshape(:,1),shape_reshape(:,2));
    title(['Image ',num2str(i)])
    
end


%% 4d - performance evaluation
