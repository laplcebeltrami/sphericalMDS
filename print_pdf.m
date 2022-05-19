function print_pdf(filename)
%function print_pdf(filename)
%
%The function print out the current figure into PDF file for publication. 

%(C) Moo K. chung
% University of Wisconsin
% mkchung@wisc.edu

%figure_bg('w'); 
filename=strcat(filename, '.pdf');
print('-dpdf','-r300', filename);
