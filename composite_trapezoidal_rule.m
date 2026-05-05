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

% --- Theoretical comparison --------------------------------------------
fprintf('  THEORETICAL COMPARISON:\n');
fprintf('  ------------------------\n');
fprintf('  The composite trapezoidal rule satisfies\n');
fprintf('       |E| <= (b-a)^3 / (12 m^2) * max|f''''(x)|,\n');
fprintf('  which predicts kappa = -2 whenever f'''' is bounded on [a,b].\n');
fprintf('  Here f(x) = sqrt(x) gives f''''(x) = -1/(4 x^(3/2)), which is\n');
fprintf('  bounded on [0.1, 1] (max|f''''| = (1/4)*(0.1)^(-3/2) ~ 7.91).\n');
fprintf('  Hence we expect kappa ~ -2, and indeed observe kappa ~ %.3f.\n\n', kappa_a);

% --- Overlay the fitted line on the plot --------------------------------
figure('Name','Part (b): error vs m with LS fit');
loglog(m_list, errors_a, 'o', 'LineWidth', 1.5, 'MarkerSize', 8); hold on;
m_fine = logspace(log10(m_list(1)), log10(m_list(end)), 100);
loglog(m_fine, exp(D_a) * m_fine.^kappa_a, '--', 'LineWidth', 1.5);
grid on;
xlabel('m (number of subintervals)');
ylabel('|error|');
title(sprintf('Part (b): a=0.1, fitted kappa = %.3f', kappa_a));
legend('observed errors', sprintf('LS fit: C m^{%.2f}', kappa_a), 'Location','southwest');
 
%% =====================================================================
%  PART (c): Repeat with a = 0  (singular f'' at the endpoint)
%  =====================================================================
fprintf('========================================================\n');
fprintf('  PART (c): Repeat with a = 0  (endpoint singularity in f'''')\n');
fprintf('========================================================\n\n');

a2       = 0.0;
I_exact2 = 2/3;                          % integral of sqrt(x) on [0,1]
errors_c = zeros(size(m_list));
 
fprintf('   m         T_m            |error|\n');
fprintf('   --        ----           -------\n');
for k = 1:length(m_list)
    m            = m_list(k);
    T_m          = trapez(f, a2, b, m);
    errors_c(k)  = abs(T_m - I_exact2);
    fprintf('  %4d   %.10f   %.3e\n', m, T_m, errors_c(k));
end
fprintf('\n');
 
[D_c, kappa_c] = fit_convergence_rate(m_list, errors_c);
 
fprintf('  Empirical convergence rate (a = 0):   kappa = %.4f\n', kappa_c);
fprintf('  Implied constant:                     C     = %.4f\n', exp(D_c));
fprintf('\n');

% --- Discussion: can the theoretical estimate still be used? ------------
fprintf('  CAN THE THEORETICAL ESTIMATE STILL BE APPLIED?\n');
fprintf('  ----------------------------------------------\n');
fprintf('  No. The standard bound\n');
fprintf('       |E| <= (b-a)^3 / (12 m^2) * max|f''''(x)|\n');
fprintf('  requires f'''' to be BOUNDED on [a,b]. For f(x) = sqrt(x) we\n');
fprintf('  have f''''(x) = -1/(4 x^(3/2)), which blows up as x -> 0+.\n');
fprintf('  Therefore max_{[0,1]} |f''''(x)| = +infinity and the bound\n');
fprintf('  is vacuous (it gives |E| <= infinity).\n\n');
fprintf('  The empirical rate drops from kappa ~ -2 (smooth case) to\n');
fprintf('  kappa ~ %.2f. This matches the well-known result that for\n', kappa_c);
fprintf('  integrands of the form x^alpha with alpha in (0,1), the\n');
fprintf('  trapezoidal rule converges at rate m^-(1+alpha). Here\n');
fprintf('  alpha = 1/2, predicting kappa = -3/2 = -1.5, in agreement\n');
fprintf('  with the observed value.\n');
fprintf('  To recover O(m^-2), one would need a singularity-aware rule\n');
fprintf('  (e.g., a substitution x = u^2, graded mesh, or Gauss-Jacobi).\n\n');
 
% --- Side-by-side comparison plot --------------------------------------
figure('Name','Part (c): comparison a=0.1 vs a=0');
loglog(m_list, errors_a, 'o-', 'LineWidth', 1.5, 'MarkerSize', 8); hold on;
loglog(m_list, errors_c, 's-', 'LineWidth', 1.5, 'MarkerSize', 8);
% Reference slopes
loglog(m_list, errors_a(1) * (m_list/m_list(1)).^(-2), 'k--');
loglog(m_list, errors_c(1) * (m_list/m_list(1)).^(-1.5), 'k:');
grid on;
xlabel('m (number of subintervals)');
ylabel('|error|');
title('Trapezoidal error: smooth vs. endpoint-singular case');
legend('a = 0.1 (smooth)', 'a = 0 (singular f'''')', ...
       'reference slope -2', 'reference slope -1.5', ...
       'Location','southwest');

%% =====================================================================
%  SUPPORTING FUNCTIONS
%  =====================================================================
 
function T = trapez(f, a, b, m)
    % TRAPEZ  Composite trapezoidal rule on [a,b] with m subintervals.
    %
    %   T = trapez(f, a, b, m) where f is either:
    %     - a function handle  (f is evaluated at the m+1 nodes), or
    %     - a numeric vector of length m+1 containing f(x_0), ..., f(x_m)
    %       already evaluated at the equally spaced nodes.
    %
    %   Returns
    %       T = h * ( f(x_0)/2 + f(x_1) + ... + f(x_{m-1}) + f(x_m)/2 )
    %   where h = (b-a)/m and x_i = a + i*h.
 
    h = (b - a) / m;
 
    if isa(f, 'function_handle')
        x  = a + (0:m).' * h;       % column vector of nodes
        fv = f(x);                  % evaluate f at all nodes
    elseif isnumeric(f)
        if numel(f) ~= m + 1
            error('trapez:badVector', ...
                  'When f is a vector it must have length m+1 = %d.', m+1);
        end
        fv = f(:);                  % force column
    else
        error('trapez:badInput', ...
              'f must be a function handle or numeric vector.');
    end
 
    % Composite trapezoidal sum: weights are [1/2, 1, 1, ..., 1, 1/2] * h
    T = h * ( sum(fv) - 0.5 * (fv(1) + fv(end)) );
end
 
function [D, kappa] = fit_convergence_rate(m_list, errors)
    % FIT_CONVERGENCE_RATE  Least-squares fit of  log(E) = D + kappa*log(m).
    %
    %   Given vectors m_list (subinterval counts) and errors (|E_m|),
    %   solves the linear least-squares problem
    %       [1, log(m_i)] * [D; kappa] ~ log(error_i)
    %   and returns the intercept D and slope kappa.
 
    log_m = log(m_list(:));
    log_E = log(errors(:));
    A     = [ones(size(log_m)), log_m];   % design matrix
    coeff = A \ log_E;                    % solves the LS problem
    D     = coeff(1);
    kappa = coeff(2);
end