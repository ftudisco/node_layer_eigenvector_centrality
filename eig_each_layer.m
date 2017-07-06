function E = eig_each_layer(Atensor)
% EIG_EACH_LAYER Computes the eigenvector centrality of each layer in a 3rd
% order tensor and stores it in a (n x t_max) matrix, where n is the number 
% of nodes and t_max the number of layers.
% 
%  Last edited: 4th July 2017 by Francesca Arrigo
%  Code available at: http://arrigofrancesca.wixsite.com/farrigo

[n,~,t_max] = size(Atensor);
E = zeros(n,t_max);

for i = 1:t_max
    A = Atensor(:,:,i);
    [v,d] = eig(A);
    [~,j] = max(diag(d));
    E(:,i) = abs(v(:,j));
end