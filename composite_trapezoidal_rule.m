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