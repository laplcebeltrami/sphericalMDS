%SCRIPT for computing and displaying heat kernel 
% on sphere from given scatter points
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

%% Spherical MDS to sphere S^2
Y= embed_sphere(rho,2);
figure; scatter3(Y(1,:),Y(2,:),Y(3,:),'.k')
axis square; axis equal
figure_bg('w'); figure_bigger(16)

%% Build triangle mesh
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
figure_bg('w')
%hold on; plot3(embeded.vertices(:,1), embeded.vertices(:,2), embeded.vertices(:,3),'.k')
view([45 45])
axis square; axis equal
figure_bg('w'); figure_bigger(16)

%% Spherical harmonics are the eigenfunction of spherical Laplacian
%obtain spherical angles corresponding to spherical coordinates
[theta,varphi]=EULERangles(embeded);
Y = real(Y_l(10,theta,varphi)); %10-th degree harmonics
figure; figure_trimesh(embeded,Y(5,:), 'rywb') %5-th order
hold on; plot3(embeded.vertices(:,1), embeded.vertices(:,2), embeded.vertices(:,3),'.k')
figure_bg('w'); view([45 45])
axis square; axis equal
figure_bg('w'); figure_bigger(16)
camlight;

%% heat kernel with bandwith 0.1 is given as 5000 x 5000 matrix
% this is probability density across columns and rows. Such a matrix is doubly stochastic
heatkernel = sphere_heatkernel(sphere, 100, 0.1); 
%heatkernel with degree 100 (more than 10000 basis) 
figure; figure_trimesh(embeded,heatkernel(:,20), 'rywb') % showing heat kernel at 20-th node as peak
hold on; plot3(embeded.vertices(:,1), embeded.vertices(:,2), embeded.vertices(:,3),'.k')
figure_bg('w'); view([45 45])
axis square; axis equal
figure_bg('w'); figure_bigger(16); 


%% heat kernel smoothing by taking scatter points as Dirac delta function
%this is equivalent to simply summing heat kernel matrix columnwise
heatkernel = sphere_heatkernel(sphere, 100, 0.01); 
smoothing=sum(heatkernel,2)/5000;
figure; figure_trimesh(embeded,smoothing, 'rywb') %l-th order 5-th degree
hold on; plot3(embeded.vertices(:,1), embeded.vertices(:,2), embeded.vertices(:,3),'.k')
view([45 45])
axis square; axis equal
figure_bg('w'); figure_bigger(16);





