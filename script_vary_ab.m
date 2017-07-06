% Script function used in 
%   "Node and layer eigenvector centralities for multiplex networks" 
%           by F. Arrigo, A. Gautier, and F. Tudisco
% to build the Figures displaying the spaghetti plots showing the evolution
% of the rankings as the parameter a/b varys.
%
%  Last edited: 4th July 2017 by Francesca Arrigo
%  Code available at: http://arrigofrancesca.wixsite.com/farrigo
%
% The script requires as INPUT a third order tensor stored in the variable
% Atensor. 


Anew = nozerolayers(Atensor);

[n,~,t_max] = size(Anew);

x0 = ones(n,1); x0 = x0/norm(x0,1);
tol = 1e-06;


% Vary a

a =  [2.1, 2.5, 2.7, 3, 4, 5, 10]; a = a(:); lab = a; 
N = length(a);
b = 2*ones(size(a));

% % Vary b
% 
% b = [2, 2.5, 5, 7.5, 10, 15, 20, 50, 100]; b = b(:); lab = b;  
% N = length(b);
% a = 2.1*ones(N,1); 



% Preallocate memory
x = zeros(n,N); 
y = zeros(t_max,N); 
w = zeros(N,1);
it = zeros(N,1); TT = it;

for i = 1:N
    tic;
    [x(:,i), y(:,i), it(i)] = PowerT2(Anew,x0,a(i),b(i),tol);
    w(i) = toc;
    [~,x(:,i)] = sort(x(:,i),'descend');
    [~,y(:,i)] = sort(y(:,i),'descend');
end

pos_x = zeros(size(x)); 
pos_y = zeros(size(y));
for i = 1:N
    [~,pos_x(:,i)] = sort(x(:,i),'ascend');
    [~,pos_y(:,i)] = sort(y(:,i),'ascend');
end

figure
subplot(2,2,1) 
plot(pos_x')
set(gca,'XTickLabel',lab)
set(gca,'YTickLabel',[])
title('Rankings of nodes')
subplot(2,2,2)
plot(pos_y')
set(gca,'XTickLabel',lab)
set(gca,'YTickLabel',[])
title('Rankings of layers')