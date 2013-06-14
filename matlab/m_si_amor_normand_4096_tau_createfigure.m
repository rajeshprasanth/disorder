function m_si_amor_normand_4096_tau_createfigure(X1, Y1, X2, Y2, X3, Y3, X4, YMatrix1, X5, Y4, X6, Y5, X7, Y6)
%CREATEFIGURE(X1,Y1,X2,Y2,X3,Y3,X4,YMATRIX1,X5,Y4,X6,Y5,X7,Y6)
%  X1:  vector of x data
%  Y1:  vector of y data
%  X2:  vector of x data
%  Y2:  vector of y data
%  X3:  vector of x data
%  Y3:  vector of y data
%  X4:  vector of x data
%  YMATRIX1:  matrix of y data
%  X5:  vector of x data
%  Y4:  vector of y data
%  X6:  vector of x data
%  Y5:  vector of y data
%  X7:  vector of x data
%  Y6:  vector of y data

%  Auto-generated by MATLAB on 12-Jun-2013 14:21:05

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'YScale','log','YMinorTick','on',...
    'XScale','log',...
    'XMinorTick','on',...
    'Units','inches',...
    'TickLength',[0.025 0.025],...
    'Position',[0.6 2.6 2.8 2]);
%% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[1000000001000 400000000000000]);
%% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[1.000000001e-14 2e-11]);
box(axes1,'on');
hold(axes1,'all');

% Create loglog
loglog(X1,Y1,'Parent',axes1,'Marker','o','LineStyle','none',...
    'DisplayName','NMD');

% Create loglog
loglog(X2,Y2,'Parent',axes1,'LineStyle','-.','DisplayName','$S_{L}$');

% Create loglog
loglog(X3,Y3,'Parent',axes1,'LineStyle','--','DisplayName','$S_{T}$');

% Create multiple lines using matrix input to loglog
loglog1 = loglog(X4,YMatrix1,'Parent',axes1);
set(loglog1(1),'LineWidth',2,'DisplayName','$\propto \omega^{-2}$');
set(loglog1(2),'DisplayName','$2\pi/\omega$');

% Create ylabel
ylabel({'$\tau$ (s)'},'Interpreter','latex');

% Create legend
legend1 = legend(axes1,'show');
set(legend1,'Interpreter','latex','EdgeColor',[1 1 1],'YColor',[1 1 1],...
    'XColor',[1 1 1],...
    'Units','inches',...
    'Position',[0.718402777777779 2.71527777777778 0.57048611111111 0.927777777777778],...
    'FontSize',9);

% Create axes
axes2 = axes('Parent',figure1,'YScale','log','YMinorTick','on',...
    'XScale','log',...
    'XMinorTick','on',...
    'Units','inches',...
    'TickLength',[0.025 0.025],...
    'Position',[0.6 0.6 2.8 2]);
%% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes2,[1000000000000 400000000000000]);
%% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes2,[1e-14 2e-11]);
box(axes2,'on');
hold(axes2,'all');

% Create loglog
loglog(X5,Y4,'Parent',axes2,'Marker','square','LineStyle','none',...
    'Color',[0 0.498039215686275 0],...
    'DisplayName','NMD');

% Create loglog
loglog(X6,Y5,'Parent',axes2,'LineStyle','-.','DisplayName','$S_{L}$');

% Create loglog
loglog(X7,Y6,'Parent',axes2,'LineStyle','--','DisplayName','$S_{L}$');

% Create multiple lines using matrix input to loglog
loglog2 = loglog(X4,YMatrix1,'Parent',axes2);
set(loglog2(1),'LineWidth',2,'DisplayName','$\propto \omega^{-2}$');
set(loglog2(2),'DisplayName','$2\pi/\omega$');

% Create xlabel
xlabel({'$\omega$ (rads/s)'},'Interpreter','latex');

% Create ylabel
ylabel({'$\tau$ (s)'},'Interpreter','latex');

% Create legend
legend2 = legend(axes2,'show');
set(legend2,'Interpreter','latex','EdgeColor',[1 1 1],'YColor',[1 1 1],...
    'XColor',[1 1 1],...
    'Units','inches',...
    'Position',[0.701736111111112 0.691666666666667 0.609374999999999 0.927777777777778],...
    'FontSize',9);

