% =========================================================================
% Composite Trapezoidal Rule: Convergence Study
% -------------------------------------------------------------------------
% Approximates  I(f) = integral_a^b f(t) dt  using the composite trapezoidal
% rule, then numerically estimates the convergence rate via least squares
% on a log-log error plot. Compares the empirical rate against the theoretical
% O(m^-2) rate, and explores what happens when f'' is unbounded at an endpoint.
% =========================================================================
 
clear; clc; close all;
 
%% =====================================================================
%  PART (a): Trapezoidal rule on  integral_{0.1}^{1} sqrt(x) dx
%  =====================================================================
fprintf('========================================================\n');
fprintf('  PART (a): Composite trapezoid on  int_{0.1}^{1} sqrt(x) dx\n');
fprintf('========================================================\n\n');
 
f      = @(x) sqrt(x);                  % integrand
a      = 0.1;                           % lower limit
b      = 1.0;                           % upper limit
I_exact = 2/3 - 1/(15*sqrt(10));        % exact value (given)

m_list = [10 20 40 80 160 320 640 1280];   % subinterval counts to test
errors_a = zeros(size(m_list));
 
fprintf('   m         T_m            |error|\n');
fprintf('   --        ----           -------\n');
for k = 1:length(m_list)
    m              = m_list(k);
    T_m            = trapez(f, a, b, m);
    errors_a(k)    = abs(T_m - I_exact);
    fprintf('  %4d   %.10f   %.3e\n', m, T_m, errors_a(k));
end
fprintf('\n');