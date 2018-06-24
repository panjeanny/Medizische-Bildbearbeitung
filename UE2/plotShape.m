function plotShape(meanshape,V,p)
    shape = generateShapeNew(meanshape,V,p);
    plot(shape(1:64),shape(65:128),'b');
    axis equal;
    hold on
    plot(meanshape(1:64),meanshape(65:128),'r');
    axis equal;
end