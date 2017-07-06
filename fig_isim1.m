% Script function used in 
%   "Node and layer eigenvector centralities for multiplex networks" 
%           by F. Arrigo, A. Gautier, and F. Tudisco
% to display the Figures describing the intersection similarity among the
% different centrality measures.
%
%  Last edited: 4th July 2017 by Francesca Arrigo
%  Code available at: http://arrigofrancesca.wixsite.com/farrigo
%
% The script requires as INPUT a third order tensor stored in the variable
% Atensor. 


%% POWER ITERATION
Anew = nozerolayers(Atensor);

n = size(Anew,1);

x0 = ones(n,1); x0 = x0/norm(x0,1);
a = 2.1; 
b = 2;
tol = 1e-6;
[x, ~, ~] = PowerT2(Anew,x0,a,b,tol);


INDX = zeros(n,5);
VALX = zeros(n,5);

% -------------------------------------------------------------
% Derive the rankings 
% -------------------------------------------------------------
valx = x; 
[~,indx] = sort(valx,'descend');
INDX(:,1) = indx;
VALX(:,1) = valx(indx)/norm(valx);
% -------------------------------------------------------------

%% EIGENVECTOR VERSATILITY
[n,~,t_max] = size(Atensor);

SA = supraAdj_from_3T(Atensor);
[v,~] = eigs(SA,1);
V = reshape(abs(v),[n,t_max]);
sa_valx = sum(V,2);

% -------------------------------------------------------------
% Derive the rankings 
% -------------------------------------------------------------
[~,sa_indx] = sort(sa_valx,'descend');
INDX(:,2) = sa_indx;
VALX(:,2) = sa_valx(indx)/norm(sa_valx);
% -------------------------------------------------------------

%% EIG_CEN(I) - ROW SUMS OF THE MATRIX CONTAINING EIGENVECTOR OF EACH LAYER
E = eig_each_layer(Atensor);
cg1_valx = sum(E,2);

% -------------------------------------------------------------
% Derive the rankings 
% -------------------------------------------------------------
[~,cg1_indx] = sort(cg1_valx,'descend');
INDX(:,3) = cg1_indx;
VALX(:,3) = cg1_valx(indx)/norm(cg1_valx);
% -------------------------------------------------------------


%% UNIFORM EIGENVECTOR LIKE CENTRALITY

Ag = sum(Anew,3);

[cg2_valx,d] = eig(Ag);
[~,j] = max(diag(d)); clear d
cg2_valx = abs(cg2_valx(:,j)); clear j

% -------------------------------------------------------------
% Derive the rankings 
% -------------------------------------------------------------
[~,cg2_indx] = sort(cg2_valx,'descend');
INDX(:,4) = cg2_indx;
VALX(:,4) = cg2_valx(indx)/norm(cg2_valx);
% -------------------------------------------------------------

%% AGGREGATE DEGREE

deg_valx = sum(Ag,2);
% -------------------------------------------------------------
% Derive the rankings 
% -------------------------------------------------------------
[~,deg_indx] = sort(deg_valx,'descend');
INDX(:,5) = deg_indx;
VALX(:,5) = deg_valx(indx)/norm(deg_valx);
% -------------------------------------------------------------

isk = zeros(n,4);

iter = 1;
for j = 2:5
    isk(:,j-1) = isim_new(INDX(:,1),INDX(:,j));        
end


%% PLOT
figure
plot(isk)