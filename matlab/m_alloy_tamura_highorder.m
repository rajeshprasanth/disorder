clear
constant = m_constant; lj = m_lj;
str.main = '/home/jason/disorder2/lj/alloy/10K/0.15/12x/NMD/1/work/';
NUM_BINS = 1000; BROADEN = 1000;
m1 = 1.0; m2 = 3.0; c = 0.25; vm = (1-c)*m1 + c*m2;
%lj
nmd =...
    load([str.main 'NMDdata.mat']);
sed =...
    load([str.main 'SEDdata.mat']);
alloy =...
    load([str.main 'ALLOY.mat']);
g(1) =...
    (1-c)*((1 - (m1/vm) )^1) + c*((1 - (m2/vm) )^1);
g(2) =...
    (1-c)*((1 - (m1/vm) )^2) + c*((1 - (m2/vm) )^2);
g(3) =...
    (1-c)*((1 - (m1/vm) )^3) + c*((1 - (m2/vm) )^3);
g(4) =...
    (1-c)*((1 - (m1/vm) )^4) + c*((1 - (m2/vm) )^4);
tamura =...
    m_alloy_tamura_highorder_Iw(...
    g,sed.freq,nmd.NUM_UCELL_COPIES,NUM_BINS,BROADEN);
[tamura.dosx tamura.dosy] = m_dos(sed.freq, 17 , 1);
subplot(4,1,1),...
semilogx(...
    tamura.dosx,tamura.dosy,'.'...
    )
subplot(4,1,2),...
loglog(...
    tamura.freq_range,abs(tamura.dw),'.'...
    )
subplot(4,1,3),...
loglog(...    
    tamura.freq_range,tamura.life,'.',...
    alloy.freq,alloy.life,'.'...
    )
subplot(4,1,4),...
loglog(...    
    tamura.freq_range,abs(tamura.g3Iwg2),'.',...
    tamura.freq_range,abs(tamura.g4Iwg2),'.'...
    )
save( [ str.main 'tamura_' int2str(BROADEN) '.mat' ], '-struct', 'tamura');

%--------------------------------------------------------------------------
%pause
%--------------------------------------------------------------------------