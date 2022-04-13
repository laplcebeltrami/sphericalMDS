function sc = embed_shepard(orig, embed)
%function sc = embed_shepard(orig, embed)
%
% The function displays Shepard diagram of showing original 
% distance vs. embeded distance. The method is based on the following paper:
% Chung, M.K., Chen, Z. 2022, Embedding of Functional Human Brain Networks 
% on a Sphere, https://arxiv.org/abs/2204.03653
%
% INPUT:
% orig : original distance matrix
% embed: embeded distance matrix
%
% OUTPUT:
% sc:  The Spearman rank correlation computed as the Pearson correlation
%      of ranked data.The Perason correlation used in the paper is not efficient.
%      The Better measure is Spearman rank correlation. 
%
% (C) 2022 Moo K. Chung
% University of Wisconsin-Madison
%
% Last update: April 12, 2022


x=orig(:);
y=embed(:);
sc = corr(sort(x),sort(y)); %Spearman rank correlation

figure; plot(x, y,'.','MarkerEdgeColor',[0.7 0.7 0.7]);
hold on; plot(x(1:500), y(1:500),'.r'); 
figure_bg('w');
figure_bigger(16);







