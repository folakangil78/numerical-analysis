function [norm1, normInf] = matrix_norms(A)

norm1 = max(sum(abs(A),1));     % column sums
normInf = max(sum(abs(A),2));   % row sums

end
