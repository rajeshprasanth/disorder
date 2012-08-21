function lj_alloy_gk_results_createfigure(X1, Y1, X2, Y2)
%CREATEFIGURE(X1,Y1,X2,Y2)
%  X1:  vector of x data
%  Y1:  vector of y data
%  X2:  vector of x data
%  Y2:  vector of y data

%  Auto-generated by MATLAB on 07-Jul-2012 09:41:06

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'YScale','log','YMinorTick','on',...
    'Units','inches',...
    'Position',[0.755555555555557 0.588888888888889 4.01511111111111 3.35555555555556],...
    'LineWidth',2,...
    'FontSize',15);
% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[-1e-05 0.55]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0.1 10]);
box(axes1,'on');
hold(axes1,'all');

% Create semilogy
semilogy(X1,Y1,'Parent',axes1,'MarkerSize',20,'Marker','.',...
    'LineStyle','none',...
    'DisplayName','LJ Alloy ($m_{avg}$ = 2, $m_r$ = 3.0)');

% Create semilogy
semilogy(X2,Y2,'Parent',axes1,'MarkerSize',20,'Marker','.',...
    'LineStyle','none',...
    'DisplayName','LJ Amorphous ($m$ = 2)');

% Create xlabel
xlabel({'c'},'FontSize',20);

% Create ylabel
ylabel({'$\kappa$ (W/m-K)'},'Interpreter','latex','FontSize',20);

% Create legend
legend1 = legend(axes1,'show');
set(legend1,'Interpreter','latex','Units','inches',...
    'Position',[1.16805555555556 3.04027777777778 3.50555555555556 0.773611111111111],...
    'LineWidth',2);

