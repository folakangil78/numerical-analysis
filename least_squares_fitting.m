% Data
X = [0.0 0.5 1.0 1.5 2.0 2.0 2.5]';
Y = [0.0 0.20 0.27 0.30 0.32 0.35 0.27]';

% Construct matrix A
A = [exp(X) X.^2 X ones(size(X))];

% Solve least squares problem
beta = A\Y;

a = beta(1);
b = beta(2);
c = beta(3);
d = beta(4);

disp('Coefficients:')
disp(beta)

% Generate smooth curve for plotting
xplot = linspace(min(X),max(X),200);
yplot = a*exp(xplot) + b*xplot.^2 + c*xplot + d;

% Plot
figure
plot(X,Y,'ro')      % data points only
hold on
plot(xplot,yplot)   % best fit curve
xlabel('X')
ylabel('Y')
title('Least Squares Fit')
legend('Data','Best Fit')