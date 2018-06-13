function [featureMatrix] = computeFeatures(image)
%computeFeatures has the dimensions nr-features times nr-pixels
% The features are greyvalue of an image, Gradient in x directin, gradient
% in y direction, magnitude of the gradient, haar-like features of the gray
% value image using computehaarlike.m, haar-like features of the gradient
% magnitudes (x and y) and x and y coordinates of the pixle

%featureMatrix(size(image,1),size(image,2))=struct;
Gray = image(:);
%Gradient
[gx, gy] = gradient((single(image)));
Gx = gx(:);
Gy = gy(:);

%Magnitude of Gradient
mag = sqrt(gx.*gx+gy.*gy);
Mag = mag(:);

%Compute Haarlike
haarlike = computeHaarLike(image);

haarlike_mag = computeHaarLike(mag);

%pixles
[xcor ycor] = meshgrid(1:size(image,2), 1:size(image,1));
Xcor = xcor(:);
Ycor = ycor(:);

featureMatrix=[Gray Gx Gy Mag haarlike' haarlike_mag' Xcor Ycor];

% for i=1:size(image,1)
%     for j=1:size(image,2)
%         featureMatrix(i,j).x=j; %Actual pixel position
%         featureMatrix(i,j).y=i; 
%         featureMatrix(i,j).gx=gx(j); %Gradienten in x und y
%         featureMatrix(i,j).gy=gy(i);
%         
%         
%         
%         
%     end
% end
end
