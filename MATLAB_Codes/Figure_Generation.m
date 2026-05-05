%% ================================================================
%  Figure Generation — Paper 1 (Controllability)  FINAL VERSION
%  ----------------------------------------------------------------
%  "Equivalence of Hewer and Kalman Controllability for
%   Generalised Bilinear Matrix Periodic Systems"
%  Authors: Sri Venkata Durga Sudarsan Madhyannapu &
%           Sravanam Pradheep Kumar
%
%  Generates 4 publication-quality figures at 500 DPI (vector PDF):
%    Fig1_Ctrl_EigModuli.pdf
%    Fig2_Ctrl_GramianSpectrum.pdf
%    Fig3_Ctrl_ScalingStudy.pdf
%    Fig4_Ctrl_StepSizeSensitivity.pdf
%
%  FONT SIZES UPDATED per Springer requirement:
%    Axis labels  : 16pt  (was 13pt)
%    Tick labels  : 15pt  (was 13pt)
%    Annotations  : 14pt  (was 10-11pt)
%    Legend       : 13pt  (was 10pt)
%    Title        : 16pt  (was 14pt)
%
%  Run AFTER Paper1_Controllability_Verification.m  (uses workspace)
%  OR run standalone — all values hardcoded from MATLAB v3 output.
%  ================================================================

clear; clc; close all;

%% ----------------------------------------------------------------
%  VERIFIED VALUES FROM MATLAB v3 RUN
%  ----------------------------------------------------------------

% Monodromy eigenvalues (9 eigenvalues of M)
eig_real   = [0.7877,  0.7877, -1.5883, -0.6296, ...
               0.9597,  0.9597,  1.0000,  1.0000, 1.0000];
eig_imag   = [0.6160, -0.6160,  0.0000,  0.0000, ...
               0.2812, -0.2812,  0.0000,  0.0000, 0.0000];
eig_moduli = abs(eig_real + 1i*eig_imag);
[eig_moduli_sorted, ~] = sort(eig_moduli, 'descend');

% Gramian statistics (Table 1) — MATLAB v3 verified
periods   = [1,      2,      3     ];
lam_min_W = [0.5211, 0.5681, 0.5705];
lam_max_W = [4.084e5, 8.758e6, 1.516e8];
kappa_W   = [7.837e5, 1.542e7, 2.657e8];

% Scaling study (Table 2) — MATLAB v3 verified
n_vals     = [2,       3      ];
kappa_mean = [2.128e10, 4.953e11];
kappa_std  = [6.648e10, 1.357e12];

% Step-size sensitivity — MATLAB v3 verified
tol_vals   = [1e-3,      1e-4      ];
delta_vals = [9.6591e-2, 8.3716e-3 ];

%% ----------------------------------------------------------------
%  GLOBAL STYLE — SPRINGER-COMPLIANT FONT SIZES
%  ----------------------------------------------------------------
FS_label  = 16;   % axis labels
FS_tick   = 15;   % tick labels
FS_title  = 16;   % figure titles
FS_annot  = 14;   % value annotations
FS_legend = 13;   % legend text

set(0, 'DefaultAxesFontSize',   FS_tick);
set(0, 'DefaultAxesFontName',   'Times New Roman');
set(0, 'DefaultTextFontName',   'Times New Roman');
set(0, 'DefaultTextFontSize',   FS_annot);
set(0, 'DefaultAxesLineWidth',  1.2);
set(0, 'DefaultLineLineWidth',  2.2);

clr_blue   = [0.122, 0.471, 0.706];
clr_orange = [1.000, 0.498, 0.055];
clr_red    = [0.839, 0.153, 0.157];
clr_gray   = [0.50,  0.50,  0.50 ];

%% ================================================================
%  FIGURE 1 — Eigenvalue Moduli of Monodromy M
%% ================================================================
fig1 = figure('Units','centimeters','Position',[2,2,16,11]);

b = bar(1:9, eig_moduli_sorted, 0.65);
b.FaceColor = 'flat';

for k = 1:9
    if eig_moduli_sorted(k) > 1 + 1e-6
        b.CData(k,:) = clr_red;
    elseif abs(eig_moduli_sorted(k) - 1.0) <= 1e-3
        b.CData(k,:) = clr_orange;
    else
        b.CData(k,:) = clr_blue;
    end
end

hold on;
yline(1.0, '--k', 'LineWidth', 1.8);
text(8.0, 1.06, '$|\lambda|=1$', ...
    'Interpreter','latex','FontSize',FS_annot,'Color','k');

[~, idx_max] = max(eig_moduli_sorted);
text(idx_max, eig_moduli_sorted(idx_max)+0.07, ...
    sprintf('$%.4f$', eig_moduli_sorted(idx_max)), ...
    'Interpreter','latex','FontSize',FS_annot, ...
    'HorizontalAlignment','center','Color',clr_red,'FontWeight','bold');

xlabel('Eigenvalue index $j$', 'Interpreter','latex', 'FontSize',FS_label);
ylabel('$|\lambda_j(\mathcal{M})|$', 'Interpreter','latex', 'FontSize',FS_label);
title({'Moduli of Monodromy Eigenvalues'; ...
       '$\mathcal{M} = \Phi_{\mathcal{A}}(2\pi,0),\quad n=3$'}, ...
      'Interpreter','latex', 'FontSize',FS_title);

hb1 = bar(NaN, NaN, 'FaceColor', clr_red);
hb2 = bar(NaN, NaN, 'FaceColor', clr_orange);
hb3 = bar(NaN, NaN, 'FaceColor', clr_blue);
hl  = plot(NaN, NaN, '--k', 'LineWidth',1.8);
legend([hb1,hb2,hb3,hl], ...
    {'$|\lambda|>1$ (unstable)', ...
     '$|\lambda|=1$ (neutral)', ...
     '$|\lambda|<1$ (stable)', ...
     'Unit circle'}, ...
    'Interpreter','latex','Location','northeast', ...
    'FontSize',FS_legend,'Box','on');

xlim([0.5,9.5]); ylim([0,1.9]);
xticks(1:9);
ax = gca; ax.FontSize = FS_tick;
grid on; grid minor; box on;

set(fig1,'PaperUnits','centimeters','PaperSize',[16,11], ...
         'PaperPosition',[0,0,16,11]);
print(fig1, 'Fig1_Ctrl_EigModuli', '-dpdf', '-r500');
fprintf('✅ Fig1_Ctrl_EigModuli.pdf saved.\n');

%% ================================================================
%  FIGURE 2 — Gramian Spectrum: λ_min and λ_max across periods
%% ================================================================
fig2 = figure('Units','centimeters','Position',[2,2,16,11]);

yyaxis left
h1 = semilogy(periods, lam_min_W, 'o-', ...
    'Color',clr_blue,'MarkerFaceColor',clr_blue,'MarkerSize',10);
ylabel('$\lambda_{\min}(\widetilde{W}_i)$','Interpreter','latex', ...
    'FontSize',FS_label);
ylim([0.40, 1.0]);
ax = gca;
ax.YAxis(1).Color = clr_blue;

hold on;
yyaxis right
h2 = semilogy(periods, lam_max_W, 's--', ...
    'Color',clr_red,'MarkerFaceColor',clr_red,'MarkerSize',10);
ylabel('$\lambda_{\max}(\widetilde{W}_i)$','Interpreter','latex', ...
    'FontSize',FS_label);
ax.YAxis(2).Color = clr_red;

% Annotations
for i = 1:3
    yyaxis left
    text(periods(i)+0.06, lam_min_W(i)*1.04, ...
        sprintf('%.4f', lam_min_W(i)), ...
        'FontSize',FS_annot,'Color',clr_blue,'FontWeight','bold');
    yyaxis right
    text(periods(i)+0.06, lam_max_W(i)*1.3, ...
        sprintf('$%.3e$', lam_max_W(i)), ...
        'FontSize',FS_annot-1,'Color',clr_red, ...
        'Interpreter','latex','FontWeight','bold');
end

xlabel('Period index $i$','Interpreter','latex','FontSize',FS_label);
title({'Controllability Gramian Spectrum vs.\ Period'; ...
       '$n=3$,\quad $T=2\pi$,\quad \texttt{ode45}'}, ...
      'Interpreter','latex','FontSize',FS_title);

legend([h1,h2], ...
    {'$\lambda_{\min}(\widetilde{W}_i)$ (stable $\approx 0.52$--$0.57$)', ...
     '$\lambda_{\max}(\widetilde{W}_i)$ (growing geometrically)'}, ...
    'Interpreter','latex','Location','west', ...
    'FontSize',FS_legend,'Box','on');

xticks([1,2,3]); xlim([0.7,3.5]);
ax.FontSize = FS_tick;
grid on; grid minor; box on;

set(fig2,'PaperUnits','centimeters','PaperSize',[16,11], ...
         'PaperPosition',[0,0,16,11]);
print(fig2, 'Fig2_Ctrl_GramianSpectrum', '-dpdf', '-r500');
fprintf('✅ Fig2_Ctrl_GramianSpectrum.pdf saved.\n');

%% ================================================================
%  FIGURE 3 — Scaling Study: Condition Number κ vs dimension n
%% ================================================================
fig3 = figure('Units','centimeters','Position',[2,2,14,10]);

kappa_mean = abs(kappa_mean);
kappa_std  = abs(kappa_std);
lower      = max(kappa_mean - kappa_std, 1e-12);
upper      = kappa_mean + kappa_std;

h1 = errorbar(n_vals, kappa_mean, ...
    kappa_mean - lower, upper - kappa_mean, 'o-', ...
    'Color',clr_blue,'MarkerFaceColor',clr_blue, ...
    'MarkerSize',10,'LineWidth',2.2,'CapSize',12);
hold on;

p   = polyfit(log10(n_vals), log10(kappa_mean), 1);
n_f = linspace(1.8, 3.2, 100);
h2  = plot(n_f, 10.^polyval(p,log10(n_f)), '--', ...
    'Color',clr_gray,'LineWidth',1.8);

set(gca,'YScale','log');

xlabel('State dimension $n$','Interpreter','latex','FontSize',FS_label);
ylabel('$\kappa(\widetilde{W}_1)$ (mean $\pm$ std, 10 trials)', ...
    'Interpreter','latex','FontSize',FS_label);
title({'Gramian Condition Number Scaling'; ...
       '$\widetilde{W}_1$, random trials, \texttt{ode45}'}, ...
      'Interpreter','latex','FontSize',FS_title);

xticks([2,3]);
xticklabels({'$n=2$\;($n^2=4$)','$n=3$\;($n^2=9$)'});
ax = gca;
ax.XAxis.TickLabelInterpreter = 'latex';
ax.FontSize = FS_tick;
xlim([1.7,3.4]);

for i = 1:2
    text(n_vals(i)+0.06, kappa_mean(i)*2.0, ...
        sprintf('$%.3e$',kappa_mean(i)), ...
        'Interpreter','latex','FontSize',FS_annot, ...
        'Color',clr_blue,'FontWeight','bold');
end

text(3.05, kappa_mean(2)*0.12, ...
    {'$n=4$ excluded:';'$256{\times}256$ ODE';'$>5\,\mathrm{GB}$ memory'}, ...
    'Interpreter','latex','FontSize',FS_annot-2,'Color',clr_red);

legend([h1,h2], ...
    {'Mean $\pm$ std (10 trials)','Log-linear trend fit'}, ...
    'Interpreter','latex','Location','northwest', ...
    'FontSize',FS_legend,'Box','on');

grid on; grid minor; box on;
set(fig3,'Toolbar','none','PaperUnits','centimeters', ...
         'PaperSize',[14,10],'PaperPosition',[0,0,14,10]);
print(fig3, 'Fig3_Ctrl_ScalingStudy', '-dpdf', '-r500');
fprintf('✅ Fig3_Ctrl_ScalingStudy.pdf saved.\n');

%% ================================================================
%  FIGURE 4 — Step-Size Sensitivity (||ΔM||_F convergence)
%% ================================================================
fig4 = figure('Units','centimeters','Position',[2,2,14,10]);

h1 = loglog(tol_vals, delta_vals, 'o-', ...
    'Color',clr_blue,'MarkerFaceColor',clr_blue, ...
    'MarkerSize',10,'LineWidth',2.2);
hold on;

t_ref = logspace(-4.5, -2.5, 100);
ref   = delta_vals(1) * (t_ref / tol_vals(1)).^1;
h2    = loglog(t_ref, ref, '--', 'Color',clr_gray,'LineWidth',1.8);

% Annotations
text(tol_vals(1)*1.08, delta_vals(1)*1.35, ...
    '$9.66\times10^{-2}$','Interpreter','latex', ...
    'FontSize',FS_annot,'Color',clr_blue,'FontWeight','bold');
text(tol_vals(2)*1.08, delta_vals(2)*1.35, ...
    '$8.37\times10^{-3}$','Interpreter','latex', ...
    'FontSize',FS_annot,'Color',clr_blue,'FontWeight','bold');

ratio = delta_vals(1)/delta_vals(2);
text(2.5e-4, 3.5e-2, ...
    sprintf('Ratio $\\approx %.1f$ (1st-order)',ratio), ...
    'Interpreter','latex','FontSize',FS_annot,'Color',clr_gray);

xlabel('RelTol','Interpreter','latex','FontSize',FS_label);
ylabel('$\|\Delta\mathcal{M}\|_F$','Interpreter','latex','FontSize',FS_label);
title({'Step-Size Sensitivity of Monodromy Computation'; ...
       'AbsTol $=10^{-10}$,\quad \texttt{ode45}'}, ...
      'Interpreter','latex','FontSize',FS_title);

legend([h1,h2], ...
    {'$\|\mathcal{M}_{\mathrm{coarse}}-\mathcal{M}_{\mathrm{fine}}\|_F$', ...
     'First-order reference'}, ...
    'Interpreter','latex','Location','northwest', ...
    'FontSize',FS_legend,'Box','on');

set(gca,'XScale','log','YScale','log','FontSize',FS_tick);
xlim([5e-5,5e-3]); ylim([1e-3,5e-1]);
grid on; grid minor; box on;

set(fig4,'Toolbar','none','PaperUnits','centimeters', ...
         'PaperSize',[14,10],'PaperPosition',[0,0,14,10]);
print(fig4, 'Fig4_Ctrl_StepSizeSensitivity', '-dpdf', '-r500');
fprintf('✅ Fig4_Ctrl_StepSizeSensitivity.pdf saved.\n');

fprintf('\n✅ All 4 figures saved. Vector PDF, 500 DPI, Springer font sizes.\n');
