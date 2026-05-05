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


% --- Log-log plot of error vs m -----------------------------------------
figure('Name','Part (a): error vs m');
loglog(m_list, errors_a, 'o-', 'LineWidth', 1.5, 'MarkerSize', 8); grid on;
xlabel('m (number of subintervals)');
ylabel('|error|');
title('Part (a): Trapezoidal error on [0.1, 1] for f(x) = sqrt(x)');
 
%% =====================================================================
%  PART (b): Estimate the convergence rate kappa via least squares
%  =====================================================================
fprintf('========================================================\n');
fprintf('  PART (b): Least-squares fit of  log(error) = D + kappa*log(m)\n');
fprintf('========================================================\n\n');
 
[D_a, kappa_a] = fit_convergence_rate(m_list, errors_a);
 
fprintf('  Empirical convergence rate (a = 0.1): kappa = %.4f\n', kappa_a);
fprintf('  Implied constant:                     C     = %.4f\n', exp(D_a));
fprintf('\n');