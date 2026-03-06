% Data
X = [0.0 0.5 1.0 1.5 2.0 2.0 2.5]';
Y = [0.0 0.20 0.27 0.30 0.32 0.35 0.27]';

% Construct matrix A
A = [exp(X) X.^2 X ones(size(X))];

% Solve least squares problem
beta = A\Y;