function [newshape] = generateShape(shape,V,b, scaling, rotation, xtranslation, ytranslation)
% generate new shapes
% V ... eigenvectors, b ... percentage of eigenbones
newshape = shape + V * b;
if scaling
    newshape = scaling * newshape;
end
if rotation
    newshape = rotation * newshape;  
end

end