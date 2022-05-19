%SCRIPT for performing Spherical multidiemnsional 
%scaling for correlation networks. 
%Currently the method only works for correlation networks. 
%
% The method is based on the following paper:
% Chung, M.K., Chen, Z. 2022, Embedding of Functional Human Brain Networks 
% on a Sphere, https://arxiv.org/abs/2204.03653
%
% (C) 2022 Moo K. Chung and Zijian Chen
% University of Wisconsin-Madison
%
% Created    : April  1, 2022
% Last update: May 19, 2022 fixed Pearson correlation computation for
% hyperbolic embedding
%
%% Loading 5000 node rsfMRI brain network data
%The above paper explains how it is obtained. 
%The real brain network data will likely to have 10000 nodes per
%hemisphere. 

load fMRInetwork-5000nodes-beta.mat 
rho=betalin*betalin';  %This is coefficiens of degree 120 cosine series 
                      %expansion on rsfMRI. See above paper for detail

figure; imagesc(rho); colormap('jet'); colorbar
caxis([-1 1]) %This is fixed such that to show the symmetric range in correlation
%Unless there is motivation/need, always display correlation symmetrically.
figure_bg('w'); figure_bigger(16)

%% METHOD 1: spherical MDS to sphere S^2
Y= embed_sphere(rho,2);
figure; scatter3(Y(1,:),Y(2,:),Y(3,:),'.k')
axis square
figure_bg('w'); figure_bigger(16)

%% Shepard diagram

orig = real(acos(rho));
embed =real(acos(Y'*Y)); 
sc = embed_shepard(orig, embed)
%Number 0.5148 is Pearson correlation

axis square; %if you want latex formula displayed. 
xlabel('Pearson correlations')
ylabel('Spherical MDS')
print_pdf('spherical-MDS2')

%% METHOD 2: spherical MDS to sphere S^1 circle

Y= embed_sphere(rho,1);
figure; scatter(Y(1,:),Y(2,:),'.k')
axis square
figure_bg('w'); figure_bigger(16)

% Shepard diagram
orig = real(acos(rho));
embed =real(acos(Y'*Y)); 
sc = embed_shepard(orig, embed)
% Number 0.4125 is Pearson correlation

axis square; %if you want latex formula displayed. 
xlabel('Pearson correlations')
ylabel('Spherical MDS')
print_pdf('spherical-MDS1')

%% METHOD 3: HYPERBOLIC-MDS TO Poincare Disk
% The method is based on
% Y. Zhou and T.O. Sharpee. Hyperbolic geometry of gene expression. 
% Iscience, 24(3):102225, 2021
% This part requires calling functions in subfolder /hyperbolic-MDS
% written by Zhou and Sharpee.

orig = real(acos(rho));
N = size(orig,1);
for i =1:N
    orig(i,i)=0;      
end
orig(orig<0)=0.01;
%figure; imagesc(orig)

Rmax = 20; % The maximum radius of the Poincare disk
%add path 'hperbolic-MDS' where fmdscale_hyperbolic.m is located;
[Y,~,~,~] = fmdscale_hyperbolic(orig,2,Rmax,0); % Do hyperbolic MDS

%minimum radius is 18.71, maximum radius is 19.30
figure; polarscatter(Y(:,2),Y(:,1)-Rmax+1.5,'.k') 
figure_bg('w'); figure_bigger(16)
rlim %shows the range of polar coordinates
rticklabels([18.5 18.7 18.9 19.1 19.3]) 

% Shepard diagram
% geodesics in the Poincare disk

embed = hyperbolic_distance(Y);
sc = embed_shepard(orig, embed)
axis square; %if you want latex formula displayed. 
xlabel('Pearson correlations')
ylabel('Hyperbolic MDS')
print_pdf('hyperbolic-MDS')
% Number 0.0501 is the Pearson correlation

%As the embedding dimension decreases, the performance will suffer and
%the Pearson correlation will decreases.

