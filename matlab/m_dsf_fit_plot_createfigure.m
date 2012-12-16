function m_dsf_fit_plot_createfigure(X1, Y1, X2, YMatrix1, X3, Y2, X4, Y3, X5, Y4, X6, Y5, X7, Y6, X8, YMatrix2)
%CREATEFIGURE(X1,Y1,X2,YMATRIX1,X3,Y2,X4,Y3,X5,Y4,X6,Y5,X7,Y6,X8,YMATRIX2)
%  X1:  vector of x data
%  Y1:  vector of y data
%  X2:  vector of x data
%  YMATRIX1:  matrix of y data
%  X3:  vector of x data
%  Y2:  vector of y data
%  X4:  vector of x data
%  Y3:  vector of y data
%  X5:  vector of x data
%  Y4:  vector of y data
%  X6:  vector of x data
%  Y5:  vector of y data
%  X7:  vector of x data
%  Y6:  vector of y data
%  X8:  vector of x data
%  YMATRIX2:  matrix of y data

%  Auto-generated by MATLAB on 04-Dec-2012 14:03:08

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'YScale','log','YMinorTick','on',...
    'XScale','log',...
    'XMinorTick','on',...
    'Units','inches',...
    'Position',[0.808888888888889 4.68217647058824 3.5 2]);
% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[1.5 30]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0.2 200]);
box(axes1,'on');
hold(axes1,'all');

% Create loglog
loglog(X1,Y1,'Parent',axes1,'MarkerSize',15,'Marker','.','LineStyle','none',...
    'DisplayName','VC-NMD');

% Create multiple lines using matrix input to loglog
loglog1 = loglog(X2,YMatrix1,'Parent',axes1);
set(loglog1(1),'Marker','+','LineStyle','none','DisplayName','DSF b=2');
set(loglog1(2),'DisplayName','$2\pi/\omega$');
set(loglog1(3),'DisplayName','$1/\omega^4$');
set(loglog1(4),'DisplayName','$1/\omega^2$');

% Create loglog
loglog(X3,Y2,'Parent',axes1,'Marker','o','LineStyle','none',...
    'DisplayName','DSF b=5');

% Create loglog
loglog(X4,Y3,'Parent',axes1,'Marker','*','LineStyle','none',...
    'DisplayName','DSF b=10');

% Create loglog
loglog(X5,Y4,'Parent',axes1,'Marker','x','LineStyle','none',...
    'DisplayName','DSF b=20');

% Create ylabel
ylabel({'$\tau$ (LJ units)'},'Interpreter','latex','FontSize',12);

% Create axes
axes2 = axes('Parent',figure1,'XScale','log','XMinorTick','on',...
    'Units','inches',...
    'Position',[0.808888888888889 2.68242156862745 3.5 2]);
% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes2,[1.5 30]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes2,[0 0.13]);
box(axes2,'on');
hold(axes2,'all');

% Create semilogx
semilogx(X6,Y5,'Parent',axes2,'LineWidth',2,'DisplayName','VC-NMD');

% Create semilogx
semilogx(X7,Y6,'Parent',axes2,'LineWidth',2,'DisplayName','Gamma');

% Create ylabel
ylabel({'DOS'},'Interpreter','latex','FontSize',12);

% Create axes
axes3 = axes('Parent',figure1,'YScale','log','YMinorTick','on',...
    'XScale','log',...
    'XMinorTick','on',...
    'Units','inches',...
    'Position',[0.808888888888889 0.682666666666667 3.5 2]);
% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes3,[1.5 30]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes3,[0.0001 9.99999]);
box(axes3,'on');
hold(axes3,'all');

% Create multiple lines using matrix input to loglog
loglog2 = loglog(X8,YMatrix2,'Parent',axes3);
set(loglog2(1),'Marker','.','LineStyle','none',...
    'DisplayName','$\delta\omega$');
set(loglog2(2),'LineWidth',3,'DisplayName','$\delta\omega_{avg}$');

% Create xlabel
xlabel({'$\omega$ (LJ units)'},'Interpreter','latex','FontSize',12);

% Create ylabel
ylabel({'$\delta\omega_{i,i+1}$'},'Interpreter','latex','FontSize',12);

% Create legend
legend1 = legend(axes1,'show');
set(legend1,'Interpreter','latex','Units','inches',...
    'Position',[0.943055555555557 3.05902777777778 1.29444444444444 1.47430555555555],...
    'FontSize',9);

% Create legend
legend2 = legend(axes2,'show');
set(legend2,'Interpreter','latex','Units','inches',...
    'Position',[3.03611111111112 2.75555555555556 1.09722222222222 0.444444444444442],...
    'FontSize',9);

% Create legend
legend3 = legend(axes3,'show');
set(legend3,'Interpreter','latex','Units','inches',...
    'Position',[3.19166666666667 1.91805555555556 0.983333333333333 0.595833333333333]);
