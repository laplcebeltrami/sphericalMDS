function Y = embed_sphere(rho,k)
% The function performs spherical embedding introduced in
%
% The method is based on the following paper:
% Chung, M.K., Chen, Z. 2022, Embedding of Functional Human Brain Networks 
% on a Sphere, https://arxiv.org/abs/2204.03653
%
% INPUT:
% rho : correlation matrix. The diagonal has to be 1. 
%       Currently method only works for correlation matrix
% k   : (k+1) dimensional sphere, S^{k} S^2 is 3D sphere. S^1 is circle
%
% OUTPUT
% Y   : embeding coordinates on S^(k-1)
%
%
% (C) 2022 Moo K. Chung
% University of Wisconsin-Madison
%
% Last update: April 12, 2022

p= size(rho,1); %size of correlation matrix.
[Ut eta U] = svd(rho); %Since digonal is identiy matrix, SVD behaves well. 
Deta = diag(eta);
%Diagnostic plot
%lambda = diag(eta);
%figure; plot([1:150],lambda(1:150),':k', 'LineWidth', 2)
%figure_bg('w')
%figure_bigger(16)

%Computing squared diagonal matrix up to k+1 number of eigenvectors. 
sqrteta = zeros(p,p);
for i=1:k+1
    sqrteta(i,i) = sqrt(Deta(i));
end

Y = sqrteta*U';
v = Y(1:k+1,:);

%Diagnostic plot showing it the vector is not normalized
%for k=2, we display 3D scatter points
%figure; scatter3(v(1,:),v(2,:),v(3,:),'.')
%for k=1, we display 2D scatter points

vnorm = kron(ones(k+1,1), vecnorm(v,2));
Y = v./vnorm;

%Diagnostic plot showing it the vector is normalized
%for k=2, we display 3D scatter points on S^2
%figure; scatter3(Y(1,:),Y(2,:),Y(3,:),'.')
%for k=1, we display 2D scatter points on S^1






