function [Yfit] = predictSegmentation(rf,testimage)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

featurematrix = computeFeatures(testimage);

Yfit = str2double(rf.predict(featurematrix));
%rf.predict
end

