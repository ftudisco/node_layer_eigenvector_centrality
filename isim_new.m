function [isk,nc]=isim_new(x,y)
% ISIM_NEW Intersection similarity with ranking vectors
%
% isk = isim(x,y) returns the intersection similarity at k for each value
% of k between 1 and n assuming that vectors x and y give a numeric rating
% for n items where x(i) and y(i) are the rankings for item i. 
% [isk,nc] = isim(x,y) returns the intersection similarity and the new
% contribution NC provided at each level. In particular, NC = 0 if the two
% sets of nodes at that level are the same. 
%
%
% Works with vectors of  rankings!
%
% The intersection similarity at k is the average of the normalized
% intersection size for 1 <= t <= k, mathematically,
%   isk(k) = mean(symdiff(A(t),B(t))/(2*t))
% where A(t) is the top-t set of items from A (likewise for B) and the
% normalization factor insures that symdiff(A(t),B(t))/(2*t) <= 1.
%
% Example:
% 
% isk = isim([1 2.5 3 4 5 6],[1 2.4 3 4 5.3 6]) % identical ratings
% isk = isim([1 2 3 4 5 6],[6 5 4 3 2 1]) % reversed ratings
% isk = isim([3 2 1 4 5 6],[1 2 3 4 5 6]) % rates top 3 the same.
% 
% Last edited 4th July 2017 by Francesca Arrigo
% Code available at: http://arrigofrancesca.wixsite.com/farrigo
% Based on a code by Christine Klymko.


if ~isvector(x)||~isvector(y), error('isim:input','x and y must be vectors'); end
if numel(x)~=numel(y), error('isim:size','arguments must have equal length'); end

n = numel(x); X=x(:); Y=y(:); % if x,y are row vectors, this line transforms them in columns  
nc = zeros(n,1); nc(1) = NaN;

    % the case without ties is simple
    isk = zeros(n,1);
    
    for k=1:n
        sumsymdiff = 0; 
        
        for i = 1:k %summation index
            x = sort(X(1:i),'descend');
            y = sort(Y(1:i),'descend');
            for j = 1:i
                if isempty(find(y(1:i) == x(j),1)), 
                    sumsymdiff = sumsymdiff + 1/(i); 
                end
            end
        end
        isk(k) = sumsymdiff/k; 
        if k > 1
        nc(k) = k*isk(k) - (k-1)*isk(k-1);
        end
    end
 
