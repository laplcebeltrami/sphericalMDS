function figure_bg(c)
%
% function figure_bg(c)
% 
% It colors the background of a figure in color.
%
% (C) 2008. Moo K. Chung, S.G. Kim 
%
% mkchung@wisc.edu
%
% Department of Biostatistics and Medical Informatics
% University of Wisconsin-Madison
%
% Update: March 20, 2012


background=c;
whitebg(gcf,background);
set(gcf,'Color',background,'InvertHardcopy','off');