function [Yfit, scores] = predictSegmentation(rf,testimage)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

featurematrix = computeFeatures(testimage);

[Yfit, scores]=rf.predict(featurematrix);
%rf.predict
end

