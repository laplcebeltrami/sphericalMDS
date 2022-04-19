function embed_display_hyperbolic(Y,Rmax)
% This function displays the kernel density plot of the scatter points Y
% in the Poincare disk with radius Rmax
%
% INPUT: 
%   Y : the scatter points in the polar coordinates [r,theta] 
%       in the Poincare disk
%     
%
% (C) 2022 Zijian Chen, Moo K. Chung
% University of Wisconsin-Madison
%
%  April 13, 2022 Created by Chen
%  April 19, 2022 Edit by Chung



% enforce the angles are in [0,2*pi]
for i = 1:size(Y,1)
    if Y(i,2)<0
        Y(i,2)=-mod(-Y(i,2),2*pi)+2*pi;
    elseif Y(i,2)>2*pi
        Y(i,2)=mod(Y(i,2),2*pi);
    end
end


rmin=min(Y(:,1));rmax=max(Y(:,1));
tmin=min(Y(:,2));tmax=max(Y(:,2));


rrange = linspace(rmin,rmax,500);
trange = linspace(tmin,tmax,500);

[N,~,~,binr,bint] = histcounts2(Y(:,1),Y(:,2), ...
    [-inf,rrange(2:end-1),inf],[-inf,trange(2:end-1),inf]);

%Gaussian kernel is used
N2 = imfilter(N,fspecial('gaussian',25,6));

col = N2(sub2ind(size(N2),binr,bint));
polarscatter(Y(:,2),Y(:,1)-Rmax+1,20,col,'filled');


