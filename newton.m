clear

max_iter = 50; % maximum number of iterations
tol = 1e-14; % tolerance for stopping criterion
err = inf; % initialize error to a large value
x0 = 20.0; % initial guess

x = zeros(max_iter, 1); % preallocate array for iterates
x(1) = x0; % set initial guess
k = 1; % iteration counter
while err > tol && k <= max_iter % loop continues until convergence or max iterations
    x(k+1) = x(k) - f(x(k)) / dfdx(x(k)); % Newton's update
    err = abs(f(x(k))); % compute error
    k = k + 1; % increment iteration counter
end

% ====== Create some plots that show the convergence behavior ======
figure(1)
semilogy(1:k-1, abs(x(1:k-1)), 'o-'); % plot absolute error on semilog scale
xlabel('Iteration number');
ylabel('Absolute error |x_k|');

q = 2; % potential order of convg
figure(2)
loglog(abs(x(2:k-2) - x(1:k-3)), abs(x(3:k-1) - x(2:k-2)), 'o-'); % plot increments on a log-log scale
hold on
loglog(abs(x(2:k-2) - x(1:k-3)), abs(x(2:k-2) - x(1:k-3)).^q, 'r--'); % jj

figure(3)
xplot = -5:0.01:5; % range of x values for plotting
yplot = f(xplot); % compute corresponding x values
plot(xplot, yplot, 'b-'); % plot the function f(x)
hold on
plot()
xlabel('x');
ylabel('f(x)');
title('Function Plot');
grid on;
% ==================================================================

function y = f(x)
    y = (x + 1)^2 - 1;
end

function dydx = dfdx(x)
    dydx = 2 * (x + 1);
end