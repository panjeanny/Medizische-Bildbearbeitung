function [V,D] = ourPCA(x)

c=ourCov(x);
[V,D]=eig(c);
[D , sortindex]= sort(diag(D),'descend');
V = V(:,sortindex) / norm(V);
end

