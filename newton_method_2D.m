clc; clear; close all;

%% ---- Define the nonlinear system f(x,y) ----
% Replace these with YOUR functions from parts (a)-(c)

f = @(x) [ ...
    %% x(1)^2 + x(2)^2 - 4;          % f1(x,y)
    %% x(2)^2 + y(8)^2 - 8;          % f1(x,y)
    %%x(1) - x(2) - 1               % f2(x,y)
    

    2*x(1)^2 + 8*x(2)^2 - 8;    % f1(x,y)
    x(2) - (sqrt(3)/2)*x(1)^2   % f2(x,y)
];

% Jacobian matrix
J = @(x) [ ...
    4*x(1), 16*x(2);               % df1/dx , df1/dy
    -sqrt(3)*x(1), 1                    % df2/dx , df2/dy
];

%% ---- Newton parameters ----
maxIter = 5;

% Starting points
x0_1 = [2; 3];
x0_2 = [-1.5; 2];

%% ---- Newton iteration function ----
newton2D = @(x0) ...
    arrayfun(@(k) 0, 1);  % dummy (we implement below)

function X = runNewton(x0, f, J, maxIter)
    X = zeros(2, maxIter+1);
    X(:,1) = x0;

    for k = 1:maxIter
        xk = X(:,k);
        X(:,k+1) = xk - J(xk)\f(xk);   % Solve J*s = f
    end
end

%% ---- Compute iterates ----
X1 = runNewton(x0_1, f, J, maxIter);
X2 = runNewton(x0_2, f, J, maxIter);

%% ---- Plot curves S1 and S2 ----
[x,y] = meshgrid(linspace(-4,4,400));

F1 = x.^2 + y.^2 - 4;      % same as f1
F2 = x - y - 1;            % same as f2

figure;
hold on; grid on;

contour(x,y,F1,[0 0],'LineWidth',2,'LineColor','b');
contour(x,y,F2,[0 0],'LineWidth',2,'LineColor','r');

%% ---- Plot Newton iterates ----
plot(X1(1,:), X1(2,:), 'ko-','LineWidth',2,'MarkerSize',8);
plot(X2(1,:), X2(2,:), 'mo-','LineWidth',2,'MarkerSize',8);

legend('S_1','S_2','Start (2,3)','Start (-1.5,2)','Location','best');

xlabel('x');
ylabel('y');
title('Newton Method in 2D');

axis equal;

%% end