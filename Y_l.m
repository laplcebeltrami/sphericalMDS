function Y = Y_l(l,theta,varphi)
% 
%
% Y =Y_l(l,theta,varphi)
%
% l        : degree of spherical harmonics
% theta  : polar angle between 0 and pi
% varphi: azimuthal angle between 0 and 2*pi
%  Y_l computes the harmonics of degree l. There are 2*l+1 harmonics of degree l.
%  real(Y_l) gives negative harmonics -l=<m<0 
%  imag(Y_l) gives positive harmonics 0<m<=l
%
%
%
% (C) 2006- Moo K. Chung, Shih-Gu Huang
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
%          2019 Oct 07 Modifiedc by Shih-Gu Huang
%


exp_i_m=[];

Pn=[];

for k = 0:l
    exp_i_m(k+1,:)= exp(i*k*varphi);
end

exp_i_m(1,:)=exp_i_m(1,:)/sqrt(2);

Pn=legendre(l,cos(theta),'norm'); % Pn is normalized to avoid Inf, and thus clm needs to be modified
Y=sqrt(1/pi)*Pn.*exp_i_m;


%OLD CODE
% sz=length(theta);
% 
% m=0:l; 
% CLM=[];
% exp_i_m=[];
% sign_m=[];
% SIGNM=[];
% Pn=[];
% 
% for k = 0:(2*l)
%     fact(k+1) = factorial(k);
% end
% clm = sqrt(((2*l+1)/(2*pi))*(fact(l-abs(m)+1)./fact(l+abs(m)+1)));
% CLM=kron(ones(1,sz),clm');
% 
% for k = 0:l
%     exp_i_m(k+1,:)= exp(i*k*varphi);
%     sign_m(k+1) = (-1)^k;
% end
% exp_i_m(1,:)=exp_i_m(1,:)/sqrt(2);
% 
% SIGNM=kron(ones(1,sz),sign_m');
% Pn=legendre(l,cos(theta));
% Y_l=CLM.*SIGNM.*Pn.*exp_i_m;	

