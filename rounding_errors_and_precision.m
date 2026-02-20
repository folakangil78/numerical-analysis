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