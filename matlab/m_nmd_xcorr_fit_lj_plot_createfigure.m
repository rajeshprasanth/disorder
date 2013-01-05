function m_nmd_xcorr_fit_lj_plot_createfigure(X1, Y1, X2, Y2, X3, YMatrix1, YMatrix2)
%CREATEFIGURE(X1,Y1,X2,Y2,X3,YMATRIX1,YMATRIX2)
%  X1:  vector of x data
%  Y1:  vector of y data
%  X2:  vector of x data
%  Y2:  vector of y data
%  X3:  vector of x data
%  YMATRIX1:  matrix of y data
%  YMATRIX2:  matrix of y data

%  Auto-generated by MATLAB on 01-Jan-2013 12:42:26

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'YScale','log','YMinorTick','on',...
    'Units','inches',...
    'TickLength',[0.025 0.025],...
    'Position',[0.6 0.6 3 2.5]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[4 4000]);
box(axes1,'on');
hold(axes1,'all');

% Create semilogy
semilogy(X1,Y1,'Parent',axes1,'LineWidth',2,'DisplayName','$mode_a$');

% Create semilogy
semilogy(X2,Y2,'Parent',axes1,'LineWidth',2,'DisplayName','$mode_b$');

% Create xlabel
xlabel({'$\omega$ (LJ units)'},'Interpreter','latex','FontSize',12);

% Create ylabel
ylabel({'SED (LJ units)'},'Interpreter','latex','FontSize',12);

% Create axes
axes2 = axes('Parent',figure1,'Units','inches','TickLength',[0.025 0.025],...
    'Position',[4.25555555555556 0.6 3 2.5]);
% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes2,[0 15]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes2,[0 1]);
box(axes2,'on');
hold(axes2,'all');

% Create multiple lines using matrix input to plot
plot1 = plot(X3,YMatrix1,'Parent',axes2,'LineWidth',2);
set(plot1(1),'DisplayName','TE $mode_a$');
set(plot1(2),'DisplayName','TE $mode_b$');

% Create xlabel
xlabel({'$t$ (LJ units)'},'Interpreter','latex','FontSize',12);

% Create ylabel
ylabel({'$<E(t)E(0)>/<E(0)E(0)>$'},'Interpreter','latex','FontSize',12);

% Create axes
axes3 = axes('Parent',figure1,'Units','inches','TickLength',[0.025 0.025],...
    'Position',[5.35555555555556 1.82411420708634 1.73382352941176 1.09625100332532]);
% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes3,[0 15]);
box(axes3,'on');
hold(axes3,'all');

% Create multiple lines using matrix input to plot
plot(X3,YMatrix2,'Parent',axes3,'LineWidth',2);

% Create xlabel
xlabel({'$t$ (LJ units)'},'Interpreter','latex');

% Create ylabel
ylabel({'$\tau$ (LJ units)'},'Interpreter','latex');

% Create legend
legend1 = legend(axes1,'show');
set(legend1,'Interpreter','latex','EdgeColor',[1 1 1],'YColor',[1 1 1],...
    'XColor',[1 1 1],...
    'Units','inches',...
    'Position',[2.58194444444445 2.4625 1.00555555555556 0.595833333333333],...
    'FontSize',9);

% Create legend
legend2 = legend(axes2,'show');
set(legend2,'Interpreter','latex','EdgeColor',[1 1 1],'YColor',[1 1 1],...
    'XColor',[1 1 1],...
    'Units','inches',...
    'Position',[6.09861111111111 0.720138888888892 0.990277777777775 0.479861111111108],...
    'FontSize',9);

% Create textbox
annotation(figure1,'textbox',...
    [0.140911634756996 0.799646174259178 0.206658321060383 0.0998014873023886],...
    'Interpreter','latex',...
    'String',{'$N_0=8$ T=0.04135'},...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1],...
    'Units','inches');

% Create textbox
annotation(figure1,'textbox',...
    [0.426007363770251 0.275747508305649 0.0231826215022091 0.00237124960143486],...
    'Interpreter','latex',...
    'String',{'(a)'},...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1],...
    'Units','inches');

% Create textbox
annotation(figure1,'textbox',...
    [0.575609720176732 0.279003322259138 0.0231826215022091 0.00237124960143486],...
    'Interpreter','latex',...
    'String',{'(b)'},...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1],...
    'Units','inches');

