function [newshape] = generateShape(shape,V,b, scaling, rotation, xtranslation, ytranslation)
% generate new shapes
% V ... eigenvectors, b ... percentage of eigenbones
newshape = shape + V * b;
if isempty(scaling) == 0
    newshape = reshape(shape,size(shape,1)/2,2);
    newshape = newshape *  scaling;
    newshape = reshape(newshape, size(newshape,1)*2,1);
end
if isempty(rotation) == 0
    newshape = reshape(shape,size(shape,1)/2,2);
    newshape = newshape * rotation;  
    newshape = reshape(newshape, size(newshape,1)*2,1);
end
xarea = size(newshape,1)/2;
yarea = size(newshape,1);
if isempty(xtranslation)==0
    xtran_expaneded = repmat(xtranslation, xarea,1);
    newshape(1:xarea)=newshape(1:xarea)+xtran_expaneded;
end
if isempty(ytranslation)==0
    ytran_expaneded = repmat(ytranslation, (yarea-xarea),1);
    newshape((xarea+1):yarea)=newshape((xarea+1):yarea)+ytran_expaneded;
end
end


