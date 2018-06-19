function [rf] = trainRF(images,masks)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
training_features = [];
training_label =[];

for i=1:size(images,2)
    
    features = computeFeatures(images{1,i});
    
    %Extracting border from mask (in column form)
    foreground = masks{1,i}(:)>0;
    background = masks{1,i}(:)==0;
    
    %features of foreground and background
    border_features{i}=features(foreground,:);
    background_features{i}=features(background,:);
    
    %creating features and corresponding labels
    
    [px, feats] = size(border_features{i});
    
    shuffle=randsample(1:px,px);
    selected_background{i}=background_features{i}(shuffle,:);
    
    %in labels: 1 .. foreground, 0 ... background
    
    training_features=[training_features border_features{i}' selected_background{i}'];
    training_label = [training_label ones(1,px) zeros(1,px)];
end

rf=TreeBagger(32,single(training_features)',training_label','OOBVarImp','on')

end

