function m_lj_nmd_xcorr_compare_createfigure(X1, YMatrix1, X2, YMatrix2)
%CREATEFIGURE(X1,YMATRIX1,X2,YMATRIX2)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data
%  X2:  vector of x data
%  YMATRIX2:  matrix of y data

%  Auto-generated by MATLAB on 10-Dec-2012 19:59:16

% Create figure
figure1 = figure('XVisual',...
    '0xa5 (TrueColor, depth 24, RGB mask 0xff0000 0xff00 0x00ff)');

% Create axes
axes1 = axes('Parent',figure1,'YScale','log','YMinorTick','on',...
    'Units','inches',...
    'TickLength',[0.025 0.025],...
    'Position',[0.620333333333333 0.500000000000019 3.5 3.5]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[3 1000000]);
box(axes1,'on');
hold(axes1,'all');

% Create multiple lines using matrix input to semilogy
semilogy1 = semilogy(X1,YMatrix1,'Parent',axes1,'LineWidth',2);
set(semilogy1(1),'DisplayName','$\Phi$ $\nu = 3$');
set(semilogy1(2),'Color',[1 0 0],'DisplayName','$\Phi$ $\nu = 4$');

% Create xlabel
xlabel({'$\omega$ (LJ units)'},'Interpreter','latex','FontSize',12);

% Create ylabel
ylabel({'$\Phi$ (LJ units)'},'Interpreter','latex','FontSize',12);

% Create axes
axes2 = axes('Parent',figure1,'Units','inches','TickLength',[0.025 0.025],...
    'Position',[1.60922222222222 2.13333333333334 2.33522222222222 1.71111111111111]);
% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes2,[0 5]);
box(axes2,'on');
hold(axes2,'all');

% Create multiple lines using matrix input to plot
plot1 = plot(X2,YMatrix2,'Parent',axes2,'LineWidth',2);
set(plot1(1),'DisplayName','$KE$ $\nu=3$');
set(plot1(2),'DisplayName','$TE$ $\nu=3$');
set(plot1(3),'DisplayName','$KE$ $\nu=4$');
set(plot1(4),'DisplayName','$TE$ $\nu=4$');

% Create xlabel
xlabel({'$t$ (LJ units)'},'Interpreter','latex');

% Create ylabel
ylabel({'$<E(t)E(0)>/<E(0)E(0)>$'},'Interpreter','latex');

% Create legend
legend1 = legend(axes2,'show');
set(legend1,'Interpreter','latex','Units','inches',...
    'Position',[2.80833333333333 1.14722222222224 1.14722222222222 0.719444444444431],...
    'FontSize',9,...
    'Color','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.232273076923077 0.197916666666667 0.0144016025641026 0.0494791666666665],...
    'Interpreter','latex',...
    'String',{'$\omega_0$'},...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1],...
    'Units','inches');

% Create line
annotation(figure1,'line',[0.228305288461538 0.228305288461538],...
    [0.231770833333333 0.1171875],'LineWidth',1,'Units','inches');

% Create line
annotation(figure1,'line',[0.556959935897436 0.556959935897436],...
    [0.23 0.115416666666667],'LineWidth',1,'Units','inches');

% Create textbox
annotation(figure1,'textbox',...
    [0.560927724358974 0.196145833333333 0.0144016025641026 0.0494791666666665],...
    'Interpreter','latex',...
    'String',{'$\omega_0$'},...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1],...
    'Units','inches');
