function c = ourCov(x)
[m,n,d]=size(x);
means=repmat(mean(x),2,1);
for i=1:d
    c=(x-means)'*(x-means)/minus(m,1);

end

end

