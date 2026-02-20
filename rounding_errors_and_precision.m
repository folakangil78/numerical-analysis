% Set the format to long to display more decimal places, 
% though we will use fprintf for specific precision.
format long;

% Part (a): Evaluating variables 'a' and 'b'

% Evaluate 'a'
a_computer = (1 - 1) + 10^-16;
a_exact = 10^-16; % Analytical result

fprintf('--- Results for a ---\n');
fprintf('Analytical exact result: %2.20f\n', a_exact);
fprintf('Computer result:         %2.20f\n\n', a_computer);

% Evaluate 'b'
b_computer = 1 - (1 + 10^-16);
b_exact = -10^-16; % Analytical result

fprintf('--- Results for b ---\n');
fprintf('Analytical exact result: %2.20f\n', b_exact);
fprintf('Computer result:         %2.20f\n\n', b_computer);

% What I think is happening:

% For calculation 'a':
% The computer evaluates the expression in the parentheses first. 
% (1 - 1) evaluates to 0. Then, it evaluates 0 + 10^-16. 
% Since it is adding 10^-16 to exactly 0, there is no precision issue, 
% and the computer matches the analytical result of 10^-16.
%
% For 'b':
% The computer again evaluates the parentheses first: (1 + 10^-16). 
% As noted in prompt, the "machine epsilon" for double precision 
% is approximately 2.22 x 10^-16. This is the smallest gap between 1 
% and the next representable floating-point number. Because 10^-16 is 
% smaller than half this gap, the computer does not have enough bits
% or memory to store the 10^-16 addition. Therefore, (1 + 10^-16) 
% simply rounds off and evaluates to 1. 
% Finally, the outer calculation becomes 1 - 1, resulting in exactly 0. 
% The 10^-16 term has been completely "absorbed" due to finite precision.

% Part (b)

% Define values of n to test
n_values = [5, 10, 20];

fprintf('Results for Part (b): Hilbert Matrix Rounding Errors \n\n');

for i = 1:length(n_values)
    n = n_values(i);
    
    % 1. Create n-th Hilbert matrix and column vector e_n of all 1's
    H = hilb(n);
    e = ones(n, 1);
    
    % 2. Calculate the exact analytical value
    % Mathematically, a matrix multiplied by its inverse is the identity matrix (I).
    % So, H * (H^-1 * e) simplifies to I * e, which is just e. 
    % Therefore, the exact Euclidean norm ||e - e|| is exactly 0.
    exact_val = 0;
    
    % 3. Calculate numerically computed value using Euclidean norm (2-norm)
    % being close to singular or badly scaled
    numerical_val = norm(H * (inv(H) * e) - e);
    
    % 4. Calculate condition number of H_n (using the default 2-norm)
    condition_num = cond(H);
    
    fprintf('For n = %d:\n', n);
    fprintf('  Exact value:              %d\n', exact_val);
    fprintf('  Numerically computed:     %e\n', numerical_val);
    fprintf('  Condition number cond(H): %e\n\n', condition_num);
end

% Part (c)

% Define the exact derivative given in the problem
exact_deriv = 3.101766393836051;
x0 = pi/4;

% Define the function f(x) using an anonymous function
% We use element-wise operations (./, .^) just as good practice
f = @(x) exp(x) ./ (cos(x).^3 + sin(x).^3);

% Define the range for k and pre-allocate arrays
k = 1:16;
h = 10.^(-k);
errors = zeros(size(h));

% Compute the numerical derivative and the error for each h
for i = 1:length(k)
    % Finite difference approximation
    num_deriv = (f(x0 + h(i)) - f(x0)) / h(i);
    
    % Calculate the absolute error
    errors(i) = abs(num_deriv - exact_deriv);
end

% Find the best approximation (minimum error)
[min_error, best_index] = min(errors);
best_h = h(best_index);

% Print the best result to the console
fprintf('--- Results for Part (c) ---\n');
fprintf('The minimum error is %e, which occurs at h = 10^-%d\n\n', min_error, k(best_index));

% Plot the results on a log-log scale
figure;
loglog(h, errors, 'o-', 'LineWidth', 1.5, 'MarkerFaceColor', 'b');
grid on;

% Add labels and a title
xlabel('Step size (h)');
ylabel('Absolute Error');
title('Error of Finite Difference Approximation vs. Step Size');


% Reverse x-axis so that smaller h values (like 10^-16) are on the right
% or leave it standard. Have left it standard (smaller h on left).
% set(gca, 'XDir', 'reverse'); 

% What's observed as h becomes smaller:

% When looking at the log-log plot, the error graph forms a "V" shape. 
% Initially, as h decreases from 10^-1 to about 10^-8, the approximation 
% gets better and the error steadily drops. This is the mathematical 
% truncation error shrinking. 
% 
% However, as h gets smaller than 10^-8, the error goes up
% This happens because f(x0 + h) and f(x0) become 
% so similar that subtracting them causes "catastrophic cancellation" 
% due to finite precision. You lose significant digits in the numerator, 
% and then dividing by a tiny h heavily amplifies that rounding error.
%
% h that gives best approximation:

% The best approximation typically occurs around h = 10^-8 (roughly the 
% square root of machine epsilon, which is ~10^-16). At this point, the 
% trade-off between truncation error and floating-point 
% rounding error is balanced.

% part (d)

% Set format to long to see the digits of accuracy
format long;

% 1. Define the given parameters
C = 1.0;
r = 0.025;
n = 10^16;

% 2. Calculate using the naive/standard formula provided in equation (1)
f_naive = C * (1 + r/n)^n;

% 3. Calculate using the limit approximation for reference
f_limit = exp(0.025);
