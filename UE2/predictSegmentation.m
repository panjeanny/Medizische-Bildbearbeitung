function [Yfit,score] = predictSegmentation(rf,testimage)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

featurematrix = computeFeatures(testimage);

[Yfit,score] = rf.predict(featurematrix);
Yfit = str2double(Yfit);

%rf.predict
end

