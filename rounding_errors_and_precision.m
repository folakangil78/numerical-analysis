% Set the format to long to display more decimal places, 
% though we will use fprintf for specific precision.
format long;

% Part (a): Evaluating variables 'a' and 'b'

% 1. Evaluate 'a'
a_computer = (1 - 1) + 10^-16;
a_exact = 10^-16; % Analytical result

fprintf('--- Results for a ---\n');
fprintf('Analytical exact result: %2.20f\n', a_exact);
fprintf('Computer result:         %2.20f\n\n', a_computer);