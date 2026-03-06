function [norm1, normInf] = matrix_norms(A)

norm1 = max(sum(abs(A),1));     % column sums
normInf = max(sum(abs(A),2));   % row sums

end

sizes = zeros(1,8);
times = zeros(1,8);

n = 100;

for k = 1:8
    
    sizes(k) = n;
    
    A = rand(n,n);
    
    tic
    norm1 = max(sum(abs(A),1));
    normInf = max(sum(abs(A),2));
    times(k) = toc;
    
    n = 2*n;

end

disp([sizes' times'])

