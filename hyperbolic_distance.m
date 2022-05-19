function dist = hyperbolic_distance(nodes)
%function dist = hyperbolic_distance(nodes)
%
% The funcftion computes the geodesics in the hyperbolic space (Poincare disk)
% The distance computation is based on the hyperbolic law of cosines given in
% equation (S2) in Zhou and Sharpee (2021). The function is used in computing the
% performance (in terms of Pearson correlation in Chung and Chen (2022) [2].
% The code is downloaded from https://github.com/laplcebeltrami/sphericalMDS
%
%
% Refence 
% [1] Y. Zhou and T.O. Sharpee. Hyperbolic geometry of gene expression. 
%     Iscience, 24(3):102225, 2021. 
% [2] Chung, M.K. and Chen, Z. 2022 Embedding of functional human brain 
%     networks on a sphere. arXiv:2204.03653
%     https://arxiv.org/pdf/2204.03653.pdf
%
% INPUT
% nodes: n by 2 matrix of node coordinates in the polar coordinates (r,theta)
%
% OUTPUT
% dist: geodesic distance in the Poincare disk
%
%
% (C) Zijian Chen and Moo K. Chung
% University of Wisconsin-Madison
% 
%  Update history
%  April 12, 2022 created


dist = acosh(cosh(nodes(:,1))*cosh(nodes(:,1))'-...
       sinh(nodes(:,1))*sinh(nodes(:,1))'.*cos(nodes(:,2)-nodes(:,2)'));
dist = real(dist);

