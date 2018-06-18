function [rf, V,D] = train(images,masks,shape)
%This function trains a classifier on all training images and creates a PCA
%shape model

% es sind nur die ersten 30 bilder traningsdaten

rf = trainRF(images,masks);

%Creating the PCA Shape model
[V,D] = ourPCA(shape');


end

