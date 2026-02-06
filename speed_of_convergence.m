clear;

k = 1:100; % k = [1 2 3 ... 100]
xk = 1./k.^2; % xk = [1 1/4 1/9 ... 1/10000]
yk = (-1/2).^k; % yk = [-1/2 1/4 -1/8 1/16 ...]
zk = exp(-k.^2); % zk = [e^-1 e^-4 e^-9 ... e^-10000]
xplusyk = xk + yk;

figure(1); % create a figure window
semilogy(k, abs(xk - 0), 'o-'); % semilogy: logarithmic scale on y-axis
%        ^      ^          ^
%      x-coord y-coord  line style and marker --> Here, 'o-' means circle markers connected by lines. 
% Use plot() for linear scale on both axes
% Use loglog() for logarithmic scale on both axes
hold on; % keep the current plot on the figure
semilogy(k, abs(yk - 0), 'x-'); % plot another sequence on the same figure
semilogy(k, abs(zk - 0), 's-'); 
xlabel('k'); % add a label to x-axis
ylabel('difference from limit'); % add a label to y-axis
legend('sublinear', 'linear', 'Location', 'southwest') % add a legend to the plot in the bottom left corner
legend('sublinear', 'linear', 'superlinear');

% To comment multiple lines, you can use %{ and %} as shown below.

figure(2);
semilogy(k, abs(xplusyk - 0), 'o-');
hold on
% semilogy(k, abs(yk - 0), 'o-'); % semilogy: logarithmic scale on y-axis
% uncommment above for comparison to linear (fig2=sublinear)
xlabel('k');
ylabel('difference from limit');
legend('x_k + y_k');


% Try plotting some other sequences. You can use the examples above as a reference.
% Hint: if you have a recursively defined sequence, you can use a for loop to compute its values.