function [x,y,it] = PowerT2(A,x0,a,b,tol)
% POWERT2 power method for 3rd order tensors
% [X,Y,IT] = POWERT2(A,X0,a,b,tol)
%
% Computes the node and layer centrality vectors obtained when the power 
% method is applied to a three order tensor as described in 
%   "Node and layer eigenvector centralities for multiplex networks" 
%           by F. Arrigo, A. Gautier, and F. Tudisco.
%
% Stopping criterion: relative difference (Euclidean norm) between two 
% subsequent iterations. 
%
% THIS FUNCTION REQUIRES THE TOOLBOX TPROD by Jason Farquhar AVAILABLE AT:
%
% https://uk.mathworks.com/matlabcentral/fileexchange/16275-tprod-arbitary-...
%           tensor-products-between-n-d-arrays#functions_tab
%
%   Input:
% A  - 3rd order tensor describing the multilayer
% x0 - (normalized) starting vector
% a  - parameter alpha
% b  - parameter beta
% tol - tolerance used in the stopping criterion. (Default: tol = 1e-05)
%
%   Output:
% x  - vector of node centralities
% y  - vector of layer centralities
% it - number of iterations required to achieve the desired accuracy
%
%  Last edited: 4th July 2017 by Francesca Arrigo
%  Code available at: http://arrigofrancesca.wixsite.com/farrigo
%
%  Reference: "Node and layer eigenvector centralities for multiplex 
%  networks" F. Arrigo, A. Gautier, and F. Tudisco.
%

if nargin == 4
    tol = 1e-05;
end


x = x0/norm(x0,1);
y = etprod('jt',A,'ijt',x,'i');
y = etprod('t',y,'jt',x,'j');
y = y/norm(y,1);


rex = 1; rey = 1;
it = 0;
bool = 0; 

while rex > tol || rey > tol
    xold = x;
    yold = y;
    
    xx = etprod('it',A,'ijt',x,'j');
    xx = etprod('i',xx,'it',y,'t');
    xx = xx.^(1/b);
    x = abs(xx)/norm(abs(xx),1); 
    
    yy = etprod('jt',A,'ijt',x,'i');
    yy = etprod('t',yy,'jt',x,'j');
    yy = yy.^(1/a);
    y = abs(yy)/norm(abs(yy),1);
    
    rex = norm(xold - x)/norm(x);
    rey = norm(yold - y)/norm(y);
    
    
    if rex <= tol && bool == 0
        bool = 1;
        fprintf('\n * Node centrality vector converges first (%d iterations) \n', it+1)
    end
    if rey <= tol && bool == 0
        bool = 1;
        fprintf('\n * Layer centrality vector converges first (%d iterations) \n', it + 1)
    end
    
    
    it = it + 1;
    
end     