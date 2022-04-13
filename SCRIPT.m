%SCRIPT for performing Spherical multidiemnsional 
%scaling for correlation networks. 
%Currently the method only works for correlation networks. 
%
% The method is based on the following paper:
% Chung, M.K., Chen, Z. 2022, Embedding of Functional Human Brain Networks 
% on a Sphere, https://arxiv.org/abs/2204.03653
%
% (C) 2022 Moo K. Chung
% University of Wisconsin-Madison
%
% Last update: April 1, 2022
%
%% Loading 5000 node rsfMRI brain network data
%The above paper explains how it is obtained. 
%The real brain network data will likely to have 10000 nodes per
%hemisphere. 

load fMRInetwork-5000nodes.mat 
figure; imagesc(rho); colormap('jet'); colorbar
caxis([-1 1]) %This is fixed such that to show the symmetric range in correlation
%Unless there is motivation/need, always display correlation symmetrically.
figure_bg('w')
figure_bigger(16)

%% METHOD 1: spherical MDS to sphere S^2
Y= embed_sphere(rho,2);
figure; scatter3(Y(1,:),Y(2,:),Y(3,:),'.k')
axis square
figure_bg('w')
figure_bigger(16)

%% Shepard diagram

orig = real(acos(rho));
embed =real(acos(Y'*Y)); 
sc = embed_shepard(orig, embed)
%Spearman rank correlation gives really good performance 0.9769

axis square; %if you want latex formula displayed. 
xlabel(['$\cos^{-1}({\bf x}_i {\bf x}_j)$'], 'Interpreter','latex')
ylabel('Spherical MDS')


%% METHOD 2: spherical MDS to sphere S^1 circle

Y= embed_sphere(rho,1);
figure; scatter(Y(1,:),Y(2,:),'.k')
axis square
figure_bg('w')
figure_bigger(16)

% Shepard diagram

orig = real(acos(rho));
embed =real(acos(Y'*Y)); 
sc = embed_shepard(orig, embed)
%Spearman rank correlation gives really good performance 0.9577

axis square; %if you want latex formula displayed. 
xlabel(['$\cos^{-1}({\bf x}_i {\bf x}_j)$'], 'Interpreter','latex')
ylabel('Spherical MDS')

%As the embedding dimension decreases, the performance will suffer. 


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
% You only need to colore corresponding edges differently. 
% There is no gurantee edges in Delaunay triangulation matches the edges in
% edges of MST of correlation network. This needs to work out.







