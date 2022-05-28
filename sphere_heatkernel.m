function heatkernel = sphere_heatkernel(sphere, l, sigma, ind_max)
% heatkernel = sphere_heatkernel(sphere, l, sigma, ind_max)
%
% l        : degree of spherical harmonics
% sigma    : kernel bandwith
% sphere   : spherical mesh where heat kernel is constructued
% ind_max  : node index where heat kernel will be maximum. 
%
% Heat kernel will be constructed at ind_max node as center
% theta_0  : polar angle between 0 and pi
% varphi_0: azimuthal angle between 0 and 2*pi
%
%  Y_l computes the harmonics of degree l. There are 2*l+1 harmonics of degree l.
%  real(Y_l) gives negative harmonics -l=<m<0 
%  imag(Y_l) gives positive harmonics 0<m<=l
%
%
%
% (C) 2022 Moo K. Chung,
%       Department of Biostatistics and Medical Informatics
%       University of Wisconsin-Maison
%  
% email://mkchung@wisc.edu
% http://www.stat.wisc.edu/softwares/weighted-SPHARM/weighted-SPHARM.html
%
% If you use this code, please reference the following paper. 
% You need to read the paper to understand the notations and the algorithm.
%
% Chung, M.K., Dalton, K.M., Shen, L., L., Evans, A.C., Davidson, R.J. 2007. 
% Weighted Fourier series representation and its application to quantifying 
% the amount of gray matter. IEEE Transactions on Medical Imaging, 26:566-581.
%
% Update history: 
%          2006 Feb 16 Modified from Li Shen's code, 
%          2006 Sept 19 Documentation
%          2019 Oct 07 Modified by Shih-Gu Huang
%          2022 May 27 heat kernel constrcuted

%computes the spherical angles of sphere
[theta,varphi]=EULERangles(sphere);

%0-th degree. 
Y0=Y_l(0,theta,varphi)';
hk= Y0*Y0'; %heat kernel at 0-th degree is constant


for i=1:l %i-th degree
    Y=Y_l(i,theta',varphi')';
    Y=[real(Y) imag(Y(:,2:(i+1)))];
    Y=real(Y);
    eigenvalue = i*(i+1); %multiplicity: for the same eigenvalue, you have (2*i + 1) multiple eigenfunctions
    hk_i = exp(-sigma*eigenvalue)*Y*Y'; %i-th terms represented as a matrix at the i-th iteration. hk_i(i,j) is the heatkernel between nodes i and j
    hk= hk+ hk_i; % heat kernel up to i-th degree.
end


%figure; imagesc(hk) heat kernel as matrix

heatkernel=hk(:,ind_max)/sum(hk(:,ind_max));
%normalze heat kernel such that they sum to 1 (heat kernel is probability
%density)


