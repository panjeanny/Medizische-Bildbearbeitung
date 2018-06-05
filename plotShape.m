function plotShape(meanshape,V,b)
    shape = generateShape(meanshape,V,b);
    newshape = reshape(shape,128,2);
    plot(newshape(:,1),newshape(:,2),'b');
    axis equal;
    hold on
    meanshape = reshape(meanshape,128,2);
    plot(meanshape(:,1),meanshape(:,2),'r')
    axis equal;
end