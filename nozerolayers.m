function  [Atensor, Ind] = nozerolayers(Atensor)
% NOZEROLAYERS removes empty layers from tensors
% [ANEW, IND] = NOZEROLAYERS(ATENSOR)
%
% Input:
% ATENSOR - third order tenrsor
% 
% Output:
% ANEW - third order tensor obtained from ATENSOR by removing the empty
%        layers, if any.
% IND - vector contining the labels of the removed layers
% 
%  Last edited: 4th July 2017 by Francesca Arrigo
%  Code available at: http://arrigofrancesca.wixsite.com/farrigo

Ind = find(sum(sum(Atensor,1),2) == 0);
Atensor(:,:,Ind) = [];