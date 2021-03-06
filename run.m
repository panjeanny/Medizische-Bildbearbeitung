clear all;
close all;
ex1=false;
if (ex1 == true)
load daten

%% 1.Berechnen Kovarianzmarix und ploten
c1 = ourCov(data1');
c2 = ourCov(data2');
c3 = ourCov(data3');
c4 = ourCov(data4');

figure;
subplot(2,2,1)
plot(data1(1,:),data1(2,:),'.');
axis equal

subplot(2,2,2)
plot(data2(1,:),data2(2,:),'.');
axis equal

subplot(2,2,3)
plot(data3(1,:),data3(2,:),'.');
axis equal

subplot(2,2,4)
plot(data4(1,:),data4(2,:),'.');
axis equal

%% 2. PCA

% demonstration of 3d pca visualization:
disp('2d pca demo... ')

[V,D] = ourPCA(data1'); 
plot2DPCA(data1', mean(data1'),[], V, D, 1, 0)

[V,D] = ourPCA(data2');  
plot2DPCA(data2', mean(data2'),[], V, D, 1, 0)

[V,D] = ourPCA(data3');  
plot2DPCA(data3', mean(data3'),[], V, D, 1, 0)

[V,D] = ourPCA(data4');
plot2DPCA(data4', mean(data4'),[], V, D, 1, 0)

%% 3. - part a.

D = data3';
[m,n,k] = size(D);
d_mean = repmat(mean(D),m,1);
[evec3, eval3] = ourPCA(D);
main_vector = evec3(:,1);
main_score = (D-d_mean)*main_vector; % Equals to normalized datapoints times the main_vector (=> projection)

plot_values = main_score*main_vector'+d_mean;
figure;
plot(plot_values(:,1), plot_values(:,2),'.');
title('projected values to main vector');

reconstructed_data = d_mean + main_score*main_vector';
%Calculating the coorinates along the main vector

plot2DPCA(D, mean(D), reconstructed_data, evec3, eval3, 0,1)
title('Exercise 3, Reconstructed data3 using main vector');
%What is the averrage error made?
errormatrix = D - reconstructed_data;
avgerror = zeros(m,1);
for i=1:m
    avgerror(i) = sqrt(errormatrix(i,1)^2+errormatrix(i,2)^2);
end
avgerror = sum(avgerror)/m;

%% 3. - part b
%Perform a similar investigation using the side vector (not the main
%vector!). Which vector would you use to obtain a reconstruction of the
%data with minimal error using as little vectors as possible (1 vector in
%this case)?
D = data3';
[m,n,k] = size(D);
d_mean = repmat(mean(D),m,1);
[evec3,eval3] = ourPCA(D);
side_vector = evec3(:,2);
side_score = (D-d_mean)*side_vector; % Equals to normalized datapoints times the main_vector (=> projection)

plot_values = main_score*side_vector'+d_mean;
figure;
plot(plot_values(:,1), plot_values(:,2),'.');
title('projected values to main vector');

reconstructed_data_side = d_mean + side_score*side_vector';
%Calculating the coorinates along the main vector

plot2DPCA(D, mean(D), reconstructed_data_side, evec3, eval3, 0,1)
title('Exercise 3, Reconstructed data3 using side vector');
%What is the averrage error made?
errormatrix_side = D - reconstructed_data_side;
avgerror_side = zeros(m,1);
for i=1:m
    avgerror_side(i) = sqrt(errormatrix_side(i,1)^2+errormatrix_side(i,2)^2);
end
avgerror_side = sum(avgerror_side)/m


%% 4.PCA 3D
%% a
%Perform PCA and plot the data and Eigenvectors of the data in daten3d.mat.
%Describe the relation between covariance matrix, Eigenvalues, Eigenvectors 
%and the ellipsoidal of standard deviations.
clear all;
load 'daten3d.mat';
[evec,eval] = ourPCA(data');
dataMean = mean(data');

plot3DPCA(data', dataMean, evec, eval, 1);
title('3D Plot of data3d.mat');

%% b
%Project the data in the subspace constructed by the two first Eigen-
%vectors. What is the dimensionality of the data now? Reconstruct the
%points in the original space and plot the result. What type of informa-
%tion has been lost?

% -> corresponds to a projection on a plane
% -> one dimension of data is lost
% -> the remaining dimensionality is 2D

D3 = data';
[m,n,k] = size(D3);
d3_mean = repmat(mean(D3),m,1);
[evec3D, eval3D] = ourPCA(D3);
main_vectors = evec3D(:,1:2);
main_scores = (D3 - d3_mean)*main_vectors;

plot_values = main_scores*main_vectors'+d3_mean;

figure;
scatter3(plot_values(:,1),plot_values(:,2),plot_values(:,3),'.');
%reconstruced3D = d3_mean + main_scores*main_vectors;

plot3DPCA(D3, mean(D3), evec, eval, 0,1);
title('Projection and Reconstruction to first two main vectors(data3d.mat)');


%% 5.Shape
% a & b

load 'shapes.mat'

% shape the nPunkte x nDimensionen x nShapes to a 
% nPunkte*nDimensionen x nShapes matrix
% prepare the input value
shape = reshape(aligned,[size(aligned,1)*size(aligned,2),size(aligned,3)]);

[V,D] = ourPCA(shape'); % eigenvector from high dimensional spce
meanshape = mean(shape,2);

v = V(:,1:14);
d = D(1:14);

figure
for i=1:14
    subplot(2,7,i)
    for l = linspace(-3*sqrt(d(i)),3*sqrt(d(i)),10);
        b = zeros(14,1);
        b(i) = l;
        plotShape(meanshape,v,b, [],[],[],[]);
        title(['Mode N: ' num2str(i)]);
        axis equal
        hold on
    end
end

%% c
csum = cumsum(d)*100 / sum(d) ;
figure;
bar(csum);
title('cumulative variance');

figure
% Total Variance 100:n=13     % For 100% Variance %
vec=v(:,1:13);
b=randn(1,13).*sqrt(d(1:13)');
subplot(2,2,1)
plotShape(meanshape,vec,b', [],[],[],[]);
title('100% Variance');
axis equal
hold on


% Total Variance 95:n=5 %
vec=v(:,1:5);
b=randn(1,5).*sqrt(d(1:5)');% For 95% Variance %
subplot(2,2,2)
plotShape(meanshape,vec,b', [],[],[],[]);
title('95% Variance');
axis equal
hold on

% Total Variance 90:n=3 %
vec=v(:,1:3);
b=randn(1,3).*sqrt(d(1:3)');     % For 90% Variance %
subplot(2,2,3)
plotShape(meanshape,vec,b', [],[],[],[]);
title('90% Variance');
hold on
axis equal

% Total Variance 80:n=3 %
vec=v(:,1:3);
b=randn(1,3).*sqrt(d(1:3)');     % For 80% Variance %
subplot(2,2,4)
plotShape(meanshape,vec,b', [],[],[],[]);
title('80% Variance');
hold on
axis equal
end
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
%for 
%figure;
%b = zeros(50,1);
%b(1) = 1;
%plotShape(meanshape,v,b);

% figure
% for i=1:10
%     subplot(2,5,i)
%     for l = linspace(-3*sqrt(d(i)),3*sqrt(d(i)),10);
%         b = zeros(50,1);
%         b(i) = l;
%         plotShape(meanshape,v,b, [],[],[],[]);
%         title(['Mode N: ' num2str(i)]);
%         axis equal
%         hold on
%     end
% end

b=ones(50,1);
figure
% subplot(2,2,1)
% plotShape(meanshape,v,b, [],[],[],[]);
% title('Reference');
% axis equal;

scaling = [[2,0];[0,2]];
subplot(2,2,1)
plotShape(meanshape,v,b, scaling,[],[],[]);
title('Scaled larger');
axis equal;
%plotShape(meanshape,v,b, scaling, rotation, xtranslation, ytranslation);

rotation = [[0,-1];[1,0]];
subplot(2,2,2)
plotShape(meanshape,v,b, [],rotation,[],[]);
title('Rotated, 90�');
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

image = images{1,1};
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

err = oobError(rf);
figure;
plot(err);

%% c
figure;
plot(rf.OOBPermutedVarDeltaError)
% Major Peaks at:
% Feature 45, => x coordinate
% Feature 1  => Gray Value
% Feature 3  => gradient y direction
% Feature 9,13,18  => Part of Haarlike Features
% Feature 25, 26,27, 31, 35, 39 => Part of Haarlike Magnitude

%% Exercise 2 - Part 4 Shape Particle Filters

[rf, V, D] = train(images(1:30),masks(1:30), shape(:,1:30));

YFit=predictSegmentation(rf, images{31});
[m n] = size(images{31});
%%
yfit_reshape = zeros(size(YFit,1),size(YFit,2));
yfit_reshape = str2double(reshape(YFit,m ,n));

% [x y]= meshgrid(1:size(image,2), 1:size(image,1));
% feat = [yfit_reshape(
figure;
icors=[];
jcors=[];
for i=1:size(yfit_reshape,1)
    for j=1:size(yfit_reshape,2)
        if yfit_reshape(i,j) == 1
            icors=[icors, i];
            jcors=[jcors, j];
        end
    end
end
scatter(jcors,icors); %? Output should be bone shaped. Does not make sense here

plotShape(meanshape,V,b, [],[],[],[]); %how is b determined??
