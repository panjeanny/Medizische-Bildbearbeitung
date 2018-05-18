function c = ourCov(x)
[m,n,d]=size(x);
for i=1:d
    c=(x-mean(x))'*(x-mean(x))/(m-1);

end

end

