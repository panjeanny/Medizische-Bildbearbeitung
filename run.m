clear all;
close all;
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

load 'shapes.mat'

% shape the nPunkte x nDimensionen x nShapes to a 
% nPunkte*nDimensionen x nShapes matrix
% prepare the input value
figure;
shape = reshape(aligned,[size(aligned,1)*size(aligned,2),size(aligned,3)]);
[V,D] = ourPCA(shape');
meanshape = mean(shape,2);








    shape_ = reshape(meanshape,128,2);


bar(D*100/sum(D))

Vmain = 13
Dmain= D(1:Vmain) 

for i = 1:Vmain
figure;
    for S = linspace( -3*sqrt(Dmain(i)), 3*sqrt(Dmain(i)),10);
    b = zeros(Vmain,1);
    b(i)= S;
    plotShape(meanshape,V(:,1),b);
    title(['Mode N: ' num2str(i)]);
    hold on
     end    
end





