clear
lj = m_lj; con = m_constant;


Di(1).Di = m_gulp_af_si_readDi(...
    '/home/jason/disorder2/si/amor/prepare/4x/annealHe/emin/','gulp_Di.gout');

Di(2).Di = m_gulp_af_si_readDi(...
    '/home/jason/disorder2/si/amor/prepare/4x/annealDonadio/','gulp_Di_emin.gout');

Di(3).Di = m_gulp_af_si_readDi(...
    '/home/jason/disorder2/si/amor/prepare/6x/annealDonadio/emin/','gulp_Di_emin.gout');


plot(...
    Di(1).Di(:,2),Di(1).Di(:,3),'.',...
    Di(2).Di(:,2),Di(2).Di(:,3),'.',...
    Di(3).Di(:,2),Di(3).Di(:,3),'.'...
    )



D = load('/home/jason/disorder2/si/amor/normand/perfect2/Di.gout');
plot(D(:,2),D(:,3),'.')
D = load('/home/jason/disorder2/si/amor/normand/perfect3/Di.gout');
plot(D(:,2),D(:,3),'.')
D = load('/home/jason/disorder2/si/amor/normand/init216/Di.gout');
plot(D(:,2),D(:,3),'.')
D = load('/home/jason/disorder2/si/amor/normand/initb216/Di.gout');
plot(D(:,2),D(:,3),'.')
D = load('/home/jason/disorder2/si/amor/normand/init216/Di.gout');
plot(D(:,2),D(:,3),'.')
D = load('/home/jason/disorder2/si/amor/normand/perfect2/Di.gout');



% plot(AF.freq/max(AF.freq),AF.Di(:,2)/max(AF.Di(:,2)),'.')
% 
% [AF.dosx AF.dosy] = m_dos(AF.freq(4:end)/max(AF.freq(4:end)),15,1);
% 
% [dosx dosy] = m_dos(Di(:,2)/max(Di(:,2)),15,1);
% 
% 
% subplot(3,1,1),...
%     plot(...
%     AF.freq(4:end)/max(AF.freq(4:end)), Di(:,2)/max(Di(:,2)),'.',...
%     AF.freq(4:end)/max(AF.freq(4:end)),AF.freq(4:end)/max(AF.freq(4:end)))
% subplot(3,1,2),...
% plot(...
%     AF.freq/max(AF.freq),AF.Di(:,2)/max(AF.Di(:,2)),'.',...
%     Di(:,2)/max(Di(:,2)),Di(:,3)/max(Di(:,3)),'.'...
%     )
% subplot(3,1,3),...
% plot(...
%     AF.Di(4:end,2)/max(AF.Di(4:end,2)),Di(:,3)/max(Di(:,3)),'.',...
%     AF.Di(4:end,2)/max(AF.Di(4:end,2)),AF.Di(4:end,2)/max(AF.Di(4:end,2))...
%     )
% 
% pause
% 
% plot(AF.freq,AF.Di(:,2),'.',Di(:,2),Di(:,3),'.')
% 