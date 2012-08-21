function xcorr_alloy_cum_cond_createfigure(X1, Y1, X2, Y2, X3, Y3, X4, Y4, X5, Y5)
%CREATEFIGURE(X1,Y1,X2,Y2,X3,Y3,X4,Y4,X5,Y5)
%  X1:  vector of x data
%  Y1:  vector of y data
%  X2:  vector of x data
%  Y2:  vector of y data
%  X3:  vector of x data
%  Y3:  vector of y data
%  X4:  vector of x data
%  Y4:  vector of y data
%  X5:  vector of x data
%  Y5:  vector of y data

%  Auto-generated by MATLAB on 07-Jul-2012 14:18:50

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'XScale','log','XMinorTick','on',...
    'Units','inches',...
    'Position',[0.739555555555558 0.722222222222223 4.40888888888889 3.14861111111111],...
    'LineWidth',2,...
    'FontSize',15);
% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0.4 300]);
box(axes1,'on');
hold(axes1,'all');

% Create semilogx
semilogx(X1,Y1,'Parent',axes1,'LineWidth',2,'DisplayName','perfect');

% Create semilogx
semilogx(X2,Y2,'Parent',axes1,'LineWidth',2,'DisplayName','c=0.05');

% Create semilogx
semilogx(X3,Y3,'Parent',axes1,'LineWidth',2,'DisplayName','c=0.15');

% Create semilogx
semilogx(X4,Y4,'Parent',axes1,'LineWidth',2,'DisplayName','c=0.5');

% Create semilogx
semilogx(X5,Y5,'Parent',axes1,'LineWidth',2,'DisplayName','amorphous');

% Create xlabel
xlabel({'$\Lambda$ (nm)'},'Interpreter','latex','FontSize',20);

% Create ylabel
ylabel({'Cumulative Conductivity / Bulk (W/m-K)'},'Interpreter','latex',...
    'FontSize',15);

% Create legend
legend1 = legend(axes1,'show');
set(legend1,'Interpreter','latex','Units','inches',...
    'Position',[0.848611111111113 0.825344287949927 1.65 1.00798904538341],...
    'LineWidth',2);

