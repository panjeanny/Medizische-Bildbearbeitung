function [rf] = trainRF(images,masks)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
training_features = [];
training_label =[];

for i=1:size(images,2)
    
    features = computeFeatures(images{i});
    
    %Extracting border from mask (in column form)
    foreground = masks{1,i}(:)>0;
    background = masks{1,i}(:)==0;
    
    %features of foreground and background
    border_features{i}=features(foreground,:);
    background_features{i}=features(background,:);
    
    %creating features and corresponding labels
    
    px = size(border_features{i},1);
    
    shuffle=randsample(1:size(background_features{i},1),px);
    selected_background{i}=background_features{i}(shuffle,:);
    
%     %in labels: 1 .. foreground, 0 ... background
%     
%     training_features{i}=[training_features border_features{i}' selected_background{i}'];
%     training_label{i} = [training_label ones(1,px) zeros(1,px)];
end

<<<<<<< HEAD
border_features = cell2mat(border_features(:));                 %umwandeln array -> matrix 
selected_background = cell2mat(selected_background(:));       

label=cat(1,ones(size(border_features,1),1),zeros(size(selected_background,1),1));     %Labeling der Vorder/Hintergrundfeatures mit 1/0 zur Unterscheidung im TreeBagger%
features=cat(1,border_features,selected_background);    

rf=TreeBagger(32,single(features),label,'OOBVarImp','on')
=======
rf=TreeBagger(32,(training_features)',training_label','OOBVarImp','on')
>>>>>>> 99134406188163b8258fb94ece60e0b22b0b5331

end

