clear all 
load daten

%% 1.Berechnen Kovarianzmarix und ploten
figure;
subplot(2,2,1)
c=ourCov(data1);
plot(c(:,1),c(:,2),'.');
axis equal

subplot(2,2,2)
c=ourCov(data2);
plot(c(:,1),c(:,2),'.');
axis equal

subplot(2,2,3)
c=ourCov(data3);
plot(c(:,1),c(:,2),'.');
axis equal

subplot(2,2,4)
c=ourCov(data4);
plot(c(:,1),c(:,2),'.');
axis equal

%% 2. PCA

% demonstration of 3d pca visualization:
disp('2d pca demo... ')

[V,D]=ourPCA(data1); 
figure
plot2DPCA(data1, mean(data1),[], V, D, 1, 1)

[V,D]=ourPCA(data2);  
figure
plot2DPCA(data2, mean(data2),[], V, D, 1, 1)

[V,D]=ourPCA(data3);  
figure
plot2DPCA(data3, mean(data3),[], V, D, 1, 1)

[V,D]=ourPCA(data4);
figure
plot2DPCA(data4, mean(data4),[], V, D, 1, 1)



