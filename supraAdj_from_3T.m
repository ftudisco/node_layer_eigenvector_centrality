function SA = supraAdj_from_3T(Atensor)
% SUPRAADJ_FROM_3T build the supra-adj matrix of a multilayer. 
% A supra adj-matrix is a block matrix that has the layers 
% on the diagonal and identity matrices in all the other blocks, to
% represent identification among nodes. 
% 
% Last edited 4th July 2017 by Francesca Arrigo
% Code available at: http://arrigofrancesca.wixsite.com/farrigo


[n,~,t_max] = size(Atensor);

SA  = kron((ones(t_max) - eye(t_max)),eye(n));


for i = 1:t_max
    SA((i-1)*n + 1 : i*n, (i-1)*n + 1 : i*n) = Atensor(:,:,i);
end