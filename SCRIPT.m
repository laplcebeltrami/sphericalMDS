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
% Last update: April 16, 2022
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
xlabel(['$\cos^{-1}({\bf x}_i {\bf x}_j)$'], 'Interpreter','latex')
ylabel('Spherical MDS')


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
xlabel(['$\cos^{-1}({\bf x}_i {\bf x}_j)$'], 'Interpreter','latex')
ylabel('Spherical MDS')


%% METHOD 3: HYPERBOLIC MDS TO Poincare Disk
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

Rmax = 20; % The maximum radius of the Poincare disk
%add path 'hperbolic-MDS' where fmdscale_hyperbolic.m is located;
[Y,~,~,~] = fmdscale_hyperbolic(orig,2,Rmax,0); % Do hyperbolic MDS
figure; polarscatter(Y(:,2),Y(:,1)-Rmax+1,'.k') 
figure_bg('w'); figure_bigger(16)
rlim
rticklabels([19 19.05 19.1 19.15 19.2])

%% To be fixed
%embed_display_hyperbolic.m is not displaying correctly
%figure; embed_display_hyperbolic(Y,Rmax) % kernel density plot
%figure_bg('w'); figure_bigger(16); colorbar

% Shepard diagram
orig = real(acos(rho));
embed =real(acos(Y'*Y)); 
sc = embed_shepard(orig, embed)
% Number 0.4125 is Pearson correlation

%As the embedding dimension decreases, the performance will suffer and
%Pearson correlation will decreases.

%% Incomplete. 
% SPHARM modeling requires building spherical mesh

Y= embed_sphere(rho,2);
Y=Y+ normrnd(0,0.000001,3,5000); 
%removes a problem of nonunique embededd point with small random
%perturbation. If it does not work,slightly increase noise variability.

%The triangulation is based on Delaunay triangulation that build simplices
%automatically. Related to Rips complex.
faces = TriangulateSpherePoints(double(Y'));
embeded.vertices=Y';
embeded.faces=faces;
figure;figure_wire(embeded, 'black', 'white');

%% To Do list
% Need a new visulziation function displaying connected edges of MST of correlation network.
% You only need to color corresponding edges differently. 
% There is no gurantee edges in Delaunay triangulation matches the edges in
% edges of MST of correlation network. This needs to work out

%For circle, we need visualization pipeline like:
%https://www.pnas.org/doi/10.1073/pnas.1008054107
%There are bunch of existing codes doing this. 




