%% ================================================================
%  Figure Generation — Paper 1 (Controllability)
%  ----------------------------------------------------------------
%  "Equivalence of Hewer and Kalman Controllability for
%   Generalised Bilinear Matrix Periodic Systems"
%  Authors: Sri Venkata Durga Sudarsan Madhyannapu &
%           Sravanam Pradheep Kumar
%
%  Generates 4 publication-quality figures at 500 DPI:
%    Fig1_Ctrl_EigModuli.pdf
%    Fig2_Ctrl_GramianSpectrum.pdf
%    Fig3_Ctrl_ScalingStudy.pdf
%    Fig4_Ctrl_StepSizeSensitivity.pdf
%
%  Run AFTER Supp_Paper1_Controllability_v3.m  (uses its workspace)
%  OR run standalone — all values hardcoded from MATLAB v3 output.
%  ================================================================

clear; clc; close all;

% ----------------------------------------------------------------
%  VERIFIED VALUES FROM MATLAB v3 RUN
% ----------------------------------------------------------------

% Monodromy eigenvalues (9 eigenvalues of M)
eig_real = [0.7877, 0.7877, -1.5883, -0.6296, 0.9597, 0.9597, ...
            1.0000, 1.0000, 1.0000];
eig_imag = [0.6160, -0.6160, 0, 0, 0.2812, -0.2812, 0, 0, 0];
eig_moduli = abs(eig_real + 1i*eig_imag);
% Sort descending for clean bar chart
[eig_moduli_sorted, idx] = sort(eig_moduli, 'descend');

% Gramian statistics (Table 1) — MATLAB v3 verified
periods    = [1, 2, 3];
lam_min_W  = [0.5211, 0.5681, 0.5705];
lam_max_W  = [4.084e5, 8.758e6, 1.516e8];
kappa_W    = [7.837e5, 1.542e7, 2.657e8];

% Scaling study (Table 2) — MATLAB v3 verified
n_vals     = [2, 3];
kappa_mean = [2.128e10, 4.953e11];
kappa_std  = [6.648e10, 1.357e12];

% Step-size sensitivity — MATLAB v3 verified
reltols    = [1e-3, 1e-4, 1e-5];
delta_M    = [9.6591e-2, 8.3716e-3, NaN];  % differences between consecutive

% H-controllability
min_H_integral = 1.8270;

% ----------------------------------------------------------------
%  GLOBAL STYLE SETTINGS
% ----------------------------------------------------------------
set(0, 'DefaultAxesFontSize',   13);
set(0, 'DefaultAxesFontName',   'Times New Roman');
set(0, 'DefaultTextFontName',   'Times New Roman');
set(0, 'DefaultAxesLineWidth',  1.2);
set(0, 'DefaultLineLineWidth',  2.0);

clr_blue   = [0.122, 0.471, 0.706];
clr_orange = [1.000, 0.498, 0.055];
clr_green  = [0.173, 0.627, 0.173];
clr_red    = [0.839, 0.153, 0.157];
clr_gray   = [0.5, 0.5, 0.5];

% ================================================================
%  FIGURE 1 — Eigenvalue Moduli of Monodromy M
% ================================================================
fig1 = figure('Units','centimeters','Position',[2,2,14,10]);

% Bar plot
b = bar(1:9, eig_moduli_sorted, 0.65);
b.FaceColor = 'flat';

% Color coding: unstable / neutral / stable
for k = 1:9
    if eig_moduli_sorted(k) > 1 + 1e-6
        b.CData(k,:) = clr_red;        % unstable
    elseif abs(eig_moduli_sorted(k) - 1.0) <= 1e-3
        b.CData(k,:) = clr_orange;     % neutral
    else
        b.CData(k,:) = clr_blue;       % stable
    end
end

hold on;

% Unit circle reference line
yline(1.0, '--k', 'LineWidth', 1.5);
text(8.3, 1.05, '$|\lambda|=1$', ...
    'Interpreter','latex','FontSize',11,'Color','k');

% Highlight largest eigenvalue
[~, idx_max] = max(eig_moduli_sorted);
text(idx_max, eig_moduli_sorted(idx_max)+0.06, ...
    sprintf('$%.4f$', eig_moduli_sorted(idx_max)), ...
    'Interpreter','latex','FontSize',10, ...
    'HorizontalAlignment','center','Color', clr_red);

% Labels and title
xlabel('Eigenvalue index $j$', 'Interpreter','latex');
ylabel('$|\lambda_j(\mathcal{M})|$', 'Interpreter','latex');
title({'Moduli of Monodromy Eigenvalues'; ...
       '$\mathcal{M} = \Phi_{\mathcal{A}}(2\pi,0)$, $n=3$'}, ...
      'Interpreter','latex');

% ---------- Clean custom legend ----------
hb1 = bar(NaN, NaN, 'FaceColor', clr_red);
hb2 = bar(NaN, NaN, 'FaceColor', clr_orange);
hb3 = bar(NaN, NaN, 'FaceColor', clr_blue);
hl  = plot(NaN, NaN, '--k', 'LineWidth',1.5);

legend([hb1, hb2, hb3, hl], ...
    {'$|\lambda|>1$ (unstable)', ...
     '$|\lambda|=1$ (neutral)', ...
     '$|\lambda|<1$ (stable)', ...
     'Unit circle'}, ...
    'Interpreter','latex', ...
    'Location','northeast', ...
    'FontSize',10, ...
    'Box','on');

% Axes formatting
xlim([0.5, 9.5]);
ylim([0, 1.85]);
xticks(1:9);

grid on;
grid minor;
box on;

% Export settings (500 DPI)
set(fig1,'PaperUnits','centimeters', ...
         'PaperSize',[14,10], ...
         'PaperPosition',[0,0,14,10]);

print(fig1, 'Fig1_Ctrl_EigModuli', '-dpdf', '-r500');

fprintf('Fig1_Ctrl_EigModuli.pdf saved.\n');

% ================================================================
%  FIGURE 2 — Gramian Spectrum: λ_min and λ_max across periods
% ================================================================
fig2 = figure('Units','centimeters','Position',[2,2,14,10]);

% ---------- LEFT AXIS: lambda_min ----------
yyaxis left
h1 = semilogy(periods, lam_min_W, 'o-', ...
    'Color', clr_blue, ...
    'MarkerFaceColor', clr_blue, ...
    'MarkerSize', 8);

ylabel('$\lambda_{\min}(\widetilde{W}_i)$', 'Interpreter','latex');
ylim([0.4, 1.0]);
yticks([0.40, 0.50, 0.52, 0.57, 0.60, 0.80, 1.0]);

ax = gca;
ax.YAxis(1).Color = clr_blue;

hold on;

% ---------- RIGHT AXIS: lambda_max ----------
yyaxis right
h2 = semilogy(periods, lam_max_W, 's--', ...
    'Color', clr_red, ...
    'MarkerFaceColor', clr_red, ...
    'MarkerSize', 8);

ylabel('$\lambda_{\max}(\widetilde{W}_i)$', 'Interpreter','latex');

ax.YAxis(2).Color = clr_red;

% ---------- VALUE ANNOTATIONS ----------
for i = 1:length(periods)
    
    % lambda_min annotation (safe offset)
    yyaxis left
    text(periods(i)+0.05, lam_min_W(i)*1.03, ...
        sprintf('%.4f', lam_min_W(i)), ...
        'FontSize',10, ...
        'Color',clr_blue, ...
        'Interpreter','latex');

    % lambda_max annotation (log-scale safe)
    yyaxis right
    text(periods(i)+0.05, lam_max_W(i)*1.2, ...
        sprintf('$%.3e$', lam_max_W(i)), ...
        'FontSize',9, ...
        'Color',clr_red, ...
        'Interpreter','latex');
end

% ---------- LABELS ----------
xlabel('Period index $i$', 'Interpreter','latex');

title({'Controllability Gramian Spectrum vs.\ Period'; ...
       '$n=3$, $T=2\pi$, \texttt{ode45}'}, ...
      'Interpreter','latex');

% ---------- LEGEND (CRITICAL FIX) ----------
legend([h1, h2], ...
    {'$\lambda_{\min}(\widetilde{W}_i)$ (stable $\approx 0.52$--$0.57$)', ...
     '$\lambda_{\max}(\widetilde{W}_i)$ (growing geometrically)'}, ...
    'Interpreter','latex', ...
    'Location','west', ...
    'FontSize',10, ...
    'Box','on');

% ---------- AXES SETTINGS ----------
xticks([1,2,3]);
xlim([0.7, 3.5]);

grid on;
grid minor;
box on;

% ---------- EXPORT ----------
set(fig2,'PaperUnits','centimeters', ...
         'PaperSize',[14,10], ...
         'PaperPosition',[0,0,14,10]);

print(fig2, 'Fig2_Ctrl_GramianSpectrum', '-dpdf', '-r500');

fprintf('Fig2_Ctrl_GramianSpectrum.pdf saved.\n');


% ================================================================
%  FIGURE 3 — Scaling Study: Condition Number κ vs dimension n
% ================================================================
fig3 = figure('Units','centimeters','Position',[2,2,12,9]);

% ---------- DATA CHECK (SAFETY) ----------
kappa_mean = abs(kappa_mean);   % ensure positivity
kappa_std  = abs(kappa_std);

% ---------- LOG-SAFE ERROR BARS ----------
lower = max(kappa_mean - kappa_std, 1e-12);   % strictly positive
upper = kappa_mean + kappa_std;

err_low  = kappa_mean - lower;
err_high = upper - kappa_mean;

h1 = errorbar(n_vals, kappa_mean, err_low, err_high, 'o-', ...
    'Color', clr_blue, ...
    'MarkerFaceColor', clr_blue, ...
    'MarkerSize', 9, ...
    'LineWidth', 2.0, ...
    'CapSize', 10);

hold on;

% ---------- LOG-LINEAR FIT ----------
p   = polyfit(log10(n_vals), log10(kappa_mean), 1);
n_f = linspace(1.8, 3.2, 100);

h2 = plot(n_f, 10.^polyval(p, log10(n_f)), '--', ...
    'Color', clr_gray, ...
    'LineWidth', 1.5);

% ---------- AXIS SETTINGS ----------
set(gca,'YScale','log');

xlabel('State dimension $n$', 'Interpreter','latex');
ylabel('$\kappa(\widetilde{W}_1)$ (mean $\pm$ std, 10 trials)', ...
    'Interpreter','latex');

title({'Gramian Condition Number Scaling'; ...
       '$\widetilde{W}_1$, random trials, \texttt{ode45}'}, ...
      'Interpreter','latex');

% ---------- TICKS ----------
xticks([2,3]);
xticklabels({'$n=2$\ ($n^2=4$)', '$n=3$\ ($n^2=9$)'});

ax = gca;
ax.XAxis.TickLabelInterpreter = 'latex';

xlim([1.7, 3.4]);

% ---------- ANNOTATIONS (LOG-SAFE POSITIONING) ----------
for i = 1:length(n_vals)
    text(n_vals(i)+0.05, kappa_mean(i)*1.5, ...
        sprintf('$%.3e$', kappa_mean(i)), ...
        'Interpreter','latex', ...
        'FontSize',10, ...
        'Color',clr_blue);
end

% ---------- EXCLUSION NOTE ----------
text(3.05, kappa_mean(2)*0.15, ...
    {'$n=4$ excluded:'; ...
     '$256{\times}256$ ODE'; ...
     '$>5\,\mathrm{GB}$ memory'}, ...
    'Interpreter','latex', ...
    'FontSize',9, ...
    'Color',clr_red, ...
    'HorizontalAlignment','left');

% ---------- LEGEND ----------
legend([h1, h2], ...
    {'Mean $\pm$ std (10 trials)', ...
     'Log-linear trend fit'}, ...
    'Interpreter','latex', ...
    'Location','northwest', ...
    'FontSize',10, ...
    'Box','on');

% ---------- GRID ----------
grid on;
grid minor;
box on;

% ---------- REMOVE TOOLBAR (EXPORT FIX) ----------
set(fig3,'Toolbar','none');

% ---------- EXPORT ----------
set(fig3,'PaperUnits','centimeters', ...
         'PaperSize',[12,9], ...
         'PaperPosition',[0,0,12,9]);

print(fig3, 'Fig3_Ctrl_ScalingStudy', '-dpdf', '-r500');

fprintf('Fig3_Ctrl_ScalingStudy.pdf saved.\n');

% ================================================================
%  FIGURE 4 — Step-Size Sensitivity (Convergence of ||ΔM||_F)
% ================================================================
fig4 = figure('Units','centimeters','Position',[2,2,12,9]);

% ---------- DATA ----------
tol_vals   = [1e-3, 1e-4];                 
delta_vals = [9.6591e-2, 8.3716e-3];      

% ---------- MAIN LOG-LOG PLOT ----------
h1 = loglog(tol_vals, delta_vals, 'o-', ...
    'Color', clr_blue, ...
    'MarkerFaceColor', clr_blue, ...
    'MarkerSize', 9, ...
    'LineWidth', 2.0);

hold on;

% ---------- FIRST-ORDER REFERENCE LINE ----------
t_ref = logspace(-4.5, -2.5, 100);
ref   = delta_vals(1) * (t_ref / tol_vals(1)).^1;

h2 = loglog(t_ref, ref, '--', ...   % ✅ FIX: use loglog (not plot)
    'Color', clr_gray, ...
    'LineWidth', 1.5);

% ---------- ANNOTATIONS ----------
text(1e-3*1.05, 9.6591e-2*1.2, ...
    '$9.66\times10^{-2}$', ...
    'Interpreter','latex','FontSize',10,'Color',clr_blue);

text(1e-4*1.05, 8.3716e-3*1.2, ...
    '$8.37\times10^{-3}$', ...
    'Interpreter','latex','FontSize',10,'Color',clr_blue);

% ---------- CONVERGENCE RATIO ----------
ratio = delta_vals(1)/delta_vals(2);

text(2.5e-4, 3e-2, ...
    sprintf('Ratio $\\approx %.1f$ (1st-order)', ratio), ...
    'Interpreter','latex', ...
    'FontSize',10, ...
    'Color',clr_gray);

% ---------- LABELS ----------
xlabel('RelTol', 'Interpreter','latex');
ylabel('$\|\Delta\mathcal{M}\|_F$', 'Interpreter','latex');

title({'Step-Size Sensitivity of Monodromy Computation'; ...
       'AbsTol $=10^{-10}$, \texttt{ode45}'}, ...
      'Interpreter','latex');

% ---------- LEGEND ----------
legend([h1, h2], ...
    {'$\|\mathcal{M}_{\mathrm{coarse}} - \mathcal{M}_{\mathrm{fine}}\|_F$', ...
     'First-order reference'}, ...
    'Interpreter','latex', ...
    'Location','northwest', ...
    'FontSize',10, ...
    'Box','on');

% ---------- AXIS CONTROL ----------
set(gca,'XScale','log','YScale','log');   % ✅ ensures consistency

xlim([5e-5, 5e-3]);
ylim([1e-3, 5e-1]);

% ---------- GRID ----------
grid on; grid minor; box on;

% ---------- REMOVE TOOLBAR (IMPORTANT FOR EXPORT) ----------
set(fig4,'Toolbar','none');

% ---------- EXPORT ----------
set(fig4,'PaperUnits','centimeters', ...
         'PaperSize',[12,9], ...
         'PaperPosition',[0,0,12,9]);

print(fig4, 'Fig4_Ctrl_StepSizeSensitivity', '-dpdf', '-r500');

fprintf('Fig4_Ctrl_StepSizeSensitivity.pdf saved.\n');