function c = ourCov(x)
[m,n,d] = size(x);
means = repmat(mean(x),m,1);

c = (x-means)'*(x-means)/minus(m,1);
end

