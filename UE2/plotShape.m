function plotShape(meanshape,V,b, scaling, rotation, xtranslation, ytranslation)
    shape = generateShape(meanshape,V,b, scaling, rotation, xtranslation, ytranslation);
    newshape = reshape(shape,size(shape,1)/2,2);
    plot(newshape(:,1),newshape(:,2),'b');
    axis equal;
    hold on
    meanshape = reshape(meanshape,size(shape,1)/2,2);
    plot(meanshape(:,1),meanshape(:,2),'r');
    axis equal;
end