% Script function used in 
%   "Node and layer eigenvector centralities for multiplex networks" 
%           by F. Arrigo, A. Gautier, and F. Tudisco
% to display the Figures displaying the scatter plots between any two of the
% different centrality measures investigated.
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

y0 = etprod('jt',Anew,'ijt',x0,'i');
y0 = etprod('t',y0,'jt',x0,'j');
y0 = y0/norm(y0,1);


a = 2.1; 
b = 2; 
tol = 1e-6;
[x, y, it] = PowerT2(Anew,x0,a,b,tol);

VALX = zeros(n,5);
INDX = zeros(n,5);
% Pears = zeros(5);
% Kend = zeros(5);

% -------------------------------------------------------------
% Derive the rankings 
% -------------------------------------------------------------
valx = x; valy = y;
[~,indx] = sort(valx,'descend');
[~,indy] = sort(valy,'descend');
VALX(:,1) = valx;
INDX(:,1) = indx;
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
VALX(:,2) = sa_valx;
INDX(:,2) = sa_indx;
% -------------------------------------------------------------

%% EIG_CEN(I) - ROW SUMS OF THE MATRIX CONTAINING EIGENVECTOR OF EACH LAYER
E = eig_each_layer(Atensor);
cg1_valx = sum(E,2);

% -------------------------------------------------------------
% Derive the rankings 
% -------------------------------------------------------------
[~,cg1_indx] = sort(cg1_valx,'descend');
VALX(:,3) = cg1_valx;
INDX(:,3) = cg1_indx;
% -------------------------------------------------------------

%% EIG_CEN(I) - ROW SUMS OF THE MATRIX CONTAINING EIGENVECTOR OF EACH LAYER

Ag = sum(Anew,3);

[cg2_valx,d] = eig(Ag);
[~,j] = max(diag(d)); clear d
cg2_valx = abs(cg2_valx(:,j)); clear j

% -------------------------------------------------------------
% Derive the rankings 
% -------------------------------------------------------------
[~,cg2_indx] = sort(cg2_valx,'descend');
VALX(:,4) = cg2_valx;
INDX(:,4) = cg2_indx;
% -------------------------------------------------------------

%% AGGREGATE DEGREE

deg_valx = sum(Ag,2);
% -------------------------------------------------------------
% Derive the rankings 
% -------------------------------------------------------------
[~,deg_indx] = sort(deg_valx,'descend');
VALX(:,5) = deg_valx;
INDX(:,5) = deg_indx;
% -------------------------------------------------------------

%% PLOT
figure
for k = 1:25
    
    j = mod(k,5); if j == 0; j=5; end
    i = ceil(k/5);
    
    subplot(5,5,k)
    plot(VALX(:,j),VALX(:,i),'b.','MarkerSize',8)
%     if j >= i
%         P = corr(VALX(:,j),VALX(:,i));
%         %fprintf('Pearson between %d and %d = %d\n', i, j, P)
%         K = corr(VALX(:,j), VALX(:,i),'type','Kendall');
%         %fprintf('Kendall between %d and %d = %d\n', i, j, K)
%         Pears(i,j) = P;
%         Kend(i,j) = K;
%     end

    % Labels
    if j == 1 && i == 1
        ylabel('C_f','FontSize',12);
    end
    if j == 1 && i == 2
        ylabel('eig\_ver','FontSize',12)
    end
    if j == 1 && i == 3
        ylabel('eig\_cen','FontSize',12)
    end
    if j == 1 && i == 4
        ylabel('agg\_eig','FontSize',12)
    end
    if j == 1 && i == 5
        ylabel('agg\_deg','FontSize',12)
    end
    if i == 5 && j == 1
         xlabel('C_f','FontSize',12);
    end
    if i == 5 && j == 2
        xlabel('eig\_ver','FontSize',12)
    end
    if i == 5 && j == 3
        xlabel('eig\_cen','FontSize',12)
    end
    if i == 5 && j == 4
        xlabel('agg\_eig','FontSize',12)
    end
    if i == 5 && j == 5
        xlabel('agg\_deg','FontSize',12)
    end
end
%     fprintf('Pearsons\n')
%     Pears = Pears+Pears' - eye(5)
%     fprintf('Kendall')
%     Kend = Kend+ Kend' - eye(5)
