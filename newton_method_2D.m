clc; clear; close all;

%% ---- Define the nonlinear system f(x,y) ----
% Replace these with YOUR functions from parts (a)-(c)

f = @(x) [ ...
    x(1)^2 + x(2)^2 - 4;          % f1(x,y)
    x(1) - x(2) - 1               % f2(x,y)
];

% Jacobian matrix
J = @(x) [ ...
    2*x(1), 2*x(2);               % df1/dx , df1/dy
    1,      -1                    % df2/dx , df2/dy
];

%% ---- Newton parameters ----
maxIter = 5;

% Starting points
x0_1 = [2; 3];
x0_2 = [-1.5; 2];