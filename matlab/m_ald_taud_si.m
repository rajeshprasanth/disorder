T%function m_ald_taud_si(str_ald,str_nmd_per,str_nmd_vc,str_alloy)
%--------------------------------------------------------------------------
%m_ald_taud(str_ald,str_nmd_perfect,str_nmd_vc,str_alloy)
% m_ald_taud(...
% '/home/jason/disorder/lj/ald/m1.1/10x/Data_fullBZ.xls',...
% '/home/jason/disorder2/lj/alloy/10K/0.05/10x/nmd_vc/work/1/',...
% '/home/jason/disorder2/lj/alloy/10K/0.05/10x/NMD/1/work/',...
% '/home/jason/disorder2/lj/alloy/10K/0.05/10x/nmd_vc/work/1/')
%--------------------------------------------------------------------------

constant = m_constant;

bin_size = 35;

% loglog(...
%     alloy.freq,alloy.life,'.'...
%     )

sys_size = '22x';

%--------------------------------------------------------------------------
%0.001
%-------------------------------------------------------------------------- 
ipt = 1;
str_ald = ['/home/jason/disorder2/si/ald/conv/' sys_size '/Data_fullBZ.xls'];
str_alloy = ['/home/jason/disorder2/si/alloy/0.001/' sys_size '/'];
str_nmd_per = ['/home/jason/disorder2/si/alloy/0.001/' sys_size '/'];
ald = m_joe_read_data_si(str_ald);
nmd_per(ipt)=load(strcat(str_nmd_per,'nmd.mat'));
sedald(ipt) = m_joe_ald2nmd_si( nmd_per(ipt) , ald );
sedald = m_joe_ald2nmd_si( NUM_KPTS, kptmodelist , NUM_MODES , ald )
alloy(ipt) = load(strcat(str_alloy,'ALLOY.mat'));

cond(ipt).nmd_per =...
    m_ald_cond(...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) )),...
    sedald(ipt).vel(:,1)/sqrt(nmd_per(ipt).x0.vm),...
    nmd_per(ipt).x0.VOLUME*constant.ang2m^3)
[nmd_freq(ipt).bins nmd_cond(ipt).freq] =...
    m_ald_cond_freq(...
    sedald(ipt).freq/sqrt(nmd_per(ipt).x0.vm),...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) )),...
    sedald(ipt).vel(:,1)/sqrt(nmd_per(ipt).x0.vm),...
    nmd_per(ipt).x0.VOLUME*constant.ang2m^3,...
    bin_size);
cond(ipt).ald =...
    m_ald_cond(...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) +...
    (1./alloy(ipt).life(:,1)) )),...
    sedald(ipt).vel(:,1)/sqrt(nmd_per(ipt).x0.vm),...
    nmd_per(ipt).x0.VOLUME*constant.ang2m^3)
[ald_freq(ipt).bins ald_cond(ipt).freq] =...
    m_ald_cond_freq(...
    sedald(ipt).freq/sqrt(nmd_per(ipt).x0.vm),...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) +...
    (1./alloy(ipt).life(:,1)) )),...
    sedald(ipt).vel(:,1)/sqrt(nmd_per(ipt).x0.vm),...
    nmd_per(ipt).x0.VOLUME*constant.ang2m^3,...
    bin_size);
loglog(...
    sedald(ipt).freq*sqrt(nmd_per(ipt).x0.vm),...
    sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm),'.',...
    alloy(ipt).freq,...
    alloy(ipt).life,'.',...
    alloy(ipt).freq,...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) +...
    (1./alloy(ipt).life(:,1)) )),'.',...
    alloy(ipt).freq/sqrt(nmd_per(ipt).x0.vm),...
    1E17*alloy(ipt).freq.^(-2),...
    alloy(ipt).freq/sqrt(nmd_per(ipt).x0.vm),...
    1E42*alloy(ipt).freq.^(-4)...
    )
%--------------------------------------------------------------------------
pause
%-------------------------------------------------------------------------- 

%--------------------------------------------------------------------------
%0.01
%-------------------------------------------------------------------------- 
ipt = 2;
str_ald = ['/home/jason/disorder2/si/ald/conv/' sys_size '/Data_fullBZ.xls'];
str_alloy = ['/home/jason/disorder2/si/alloy/0.01/' sys_size '/'];
str_nmd_per = ['/home/jason/disorder2/si/alloy/0.01/' sys_size '/'];
ald = m_joe_read_data_si(str_ald);
nmd_per(ipt)=load(strcat(str_nmd_per,'nmd.mat'));
sedald(ipt) = m_joe_ald2nmd_si( nmd_per(ipt) , ald );
alloy(ipt) = load(strcat(str_alloy,'ALLOY.mat'));

cond(ipt).nmd_per =...
    m_ald_cond(...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) )),...
    sedald(ipt).vel(:,1)/sqrt(nmd_per(ipt).x0.vm),...
    nmd_per(ipt).x0.VOLUME*constant.ang2m^3)
[nmd_freq(ipt).bins nmd_cond(ipt).freq] =...
    m_ald_cond_freq(...
    sedald(ipt).freq/sqrt(nmd_per(ipt).x0.vm),...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) )),...
    sedald(ipt).vel(:,1)/sqrt(nmd_per(ipt).x0.vm),...
    nmd_per(ipt).x0.VOLUME*constant.ang2m^3,...
    bin_size);
cond(ipt).ald =...
    m_ald_cond(...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) +...
    (1./alloy(ipt).life(:,1)) )),...
    sedald(ipt).vel(:,1)/sqrt(nmd_per(ipt).x0.vm),...
    nmd_per(ipt).x0.VOLUME*constant.ang2m^3)
[ald_freq(ipt).bins ald_cond(ipt).freq] =...
    m_ald_cond_freq(...
    sedald(ipt).freq/sqrt(nmd_per(ipt).x0.vm),...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) +...
    (1./alloy(ipt).life(:,1)) )),...
    sedald(ipt).vel(:,1)/sqrt(nmd_per(ipt).x0.vm),...
    nmd_per(ipt).x0.VOLUME*constant.ang2m^3,...
    bin_size);
loglog(...
    sedald(ipt).freq*sqrt(nmd_per(ipt).x0.vm),...
    sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm),'.',...
    alloy(ipt).freq,...
    alloy(ipt).life,'.',...
    alloy(ipt).freq,...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) +...
    (1./alloy(ipt).life(:,1)) )),'.',...
    alloy(ipt).freq/sqrt(nmd_per(ipt).x0.vm),...
    1E17*alloy(ipt).freq.^(-2),...
    alloy(ipt).freq/sqrt(nmd_per(ipt).x0.vm),...
    1E42*alloy(ipt).freq.^(-4)...
    )
%--------------------------------------------------------------------------
pause
%-------------------------------------------------------------------------- 
 
%--------------------------------------------------------------------------
%0.05
%-------------------------------------------------------------------------- 
ipt = 3;
str_ald = ['/home/jason/disorder2/si/ald/conv/' sys_size '/Data_fullBZ.xls'];
str_alloy = ['/home/jason/disorder2/si/alloy/0.05/' sys_size '/'];
str_nmd_per = ['/home/jason/disorder2/si/alloy/0.05/' sys_size '/'];
ald = m_joe_read_data_si(str_ald);
nmd_per(ipt)=load(strcat(str_nmd_per,'nmd.mat'));
sedald(ipt) = m_joe_ald2nmd_si( nmd_per(ipt) , ald );
alloy(ipt) = load(strcat(str_alloy,'ALLOY.mat'));

cond(ipt).nmd_per =...
    m_ald_cond(...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) )),...
    sedald(ipt).vel(:,1)/sqrt(nmd_per(ipt).x0.vm),...
    nmd_per(ipt).x0.VOLUME*constant.ang2m^3)
[nmd_freq(ipt).bins nmd_cond(ipt).freq] =...
    m_ald_cond_freq(...
    sedald(ipt).freq/sqrt(nmd_per(ipt).x0.vm),...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) )),...
    sedald(ipt).vel(:,1)/sqrt(nmd_per(ipt).x0.vm),...
    nmd_per(ipt).x0.VOLUME*constant.ang2m^3,...
    bin_size);
cond(ipt).ald =...
    m_ald_cond(...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) +...
    (1./alloy(ipt).life(:,1)) )),...
    sedald(ipt).vel(:,1)/sqrt(nmd_per(ipt).x0.vm),...
    nmd_per(ipt).x0.VOLUME*constant.ang2m^3)
[ald_freq(ipt).bins ald_cond(ipt).freq] =...
    m_ald_cond_freq(...
    sedald(ipt).freq/sqrt(nmd_per(ipt).x0.vm),...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) +...
    (1./alloy(ipt).life(:,1)) )),...
    sedald(ipt).vel(:,1)/sqrt(nmd_per(ipt).x0.vm),...
    nmd_per(ipt).x0.VOLUME*constant.ang2m^3,...
    bin_size);
loglog(...
    sedald(ipt).freq*sqrt(nmd_per(ipt).x0.vm),...
    sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm),'.',...
    alloy(ipt).freq,...
    alloy(ipt).life,'.',...
    alloy(ipt).freq,...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) +...
    (1./alloy(ipt).life(:,1)) )),'.',...
    alloy(ipt).freq/sqrt(nmd_per(ipt).x0.vm),...
    1E17*alloy(ipt).freq.^(-2),...
    alloy(ipt).freq/sqrt(nmd_per(ipt).x0.vm),...
    1E42*alloy(ipt).freq.^(-4)...
    )
%--------------------------------------------------------------------------
pause
%-------------------------------------------------------------------------- 

%--------------------------------------------------------------------------
%0.15
%-------------------------------------------------------------------------- 
ipt = 4;
str_ald = ['/home/jason/disorder2/si/ald/conv/' sys_size '/Data_fullBZ.xls'];
str_alloy = ['/home/jason/disorder2/si/alloy/0.15/' sys_size '/'];
str_nmd_per = ['/home/jason/disorder2/si/alloy/0.15/' sys_size '/'];
ald = m_joe_read_data_si(str_ald);
nmd_per(ipt)=load(strcat(str_nmd_per,'nmd.mat'));
sedald(ipt) = m_joe_ald2nmd_si( nmd_per(ipt) , ald );
alloy(ipt) = load(strcat(str_alloy,'ALLOY.mat'));

cond(ipt).nmd_per =...
    m_ald_cond(...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) )),...
    sedald(ipt).vel(:,1)/sqrt(nmd_per(ipt).x0.vm),...
    nmd_per(ipt).x0.VOLUME*constant.ang2m^3)
[nmd_freq(ipt).bins nmd_cond(ipt).freq] =...
    m_ald_cond_freq(...
    sedald(ipt).freq/sqrt(nmd_per(ipt).x0.vm),...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) )),...
    sedald(ipt).vel(:,1)/sqrt(nmd_per(ipt).x0.vm),...
    nmd_per(ipt).x0.VOLUME*constant.ang2m^3,...
    bin_size);
cond(ipt).ald =...
    m_ald_cond(...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) +...
    (1./alloy(ipt).life(:,1)) )),...
    sedald(ipt).vel(:,1)/sqrt(nmd_per(ipt).x0.vm),...
    nmd_per(ipt).x0.VOLUME*constant.ang2m^3)
[ald_freq(ipt).bins ald_cond(ipt).freq] =...
    m_ald_cond_freq(...
    sedald(ipt).freq/sqrt(nmd_per(ipt).x0.vm),...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) +...
    (1./alloy(ipt).life(:,1)) )),...
    sedald(ipt).vel(:,1)/sqrt(nmd_per(ipt).x0.vm),...
    nmd_per(ipt).x0.VOLUME*constant.ang2m^3,...
    bin_size);
loglog(...
    sedald(ipt).freq*sqrt(nmd_per(ipt).x0.vm),...
    sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm),'.',...
    alloy(ipt).freq,...
    alloy(ipt).life,'.',...
    alloy(ipt).freq,...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) +...
    (1./alloy(ipt).life(:,1)) )),'.',...
    alloy(ipt).freq/sqrt(nmd_per(ipt).x0.vm),...
    1E17*alloy(ipt).freq.^(-2),...
    alloy(ipt).freq/sqrt(nmd_per(ipt).x0.vm),...
    1E42*alloy(ipt).freq.^(-4)...
    )
%--------------------------------------------------------------------------
pause
%-------------------------------------------------------------------------- 

%--------------------------------------------------------------------------
%0.5
%-------------------------------------------------------------------------- 
ipt = 5;
str_ald = ['/home/jason/disorder2/si/ald/conv/' sys_size '/Data_fullBZ.xls'];
str_alloy = ['/home/jason/disorder2/si/alloy/0.5/' sys_size '/'];
str_nmd_per = ['/home/jason/disorder2/si/alloy/0.5/' sys_size '/'];
ald = m_joe_read_data_si(str_ald);
nmd_per(ipt)=load(strcat(str_nmd_per,'nmd.mat'));
sedald(ipt) = m_joe_ald2nmd_si( nmd_per(ipt) , ald );
alloy(ipt) = load(strcat(str_alloy,'ALLOY.mat'));

cond(ipt).nmd_per =...
    m_ald_cond(...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) )),...
    sedald(ipt).vel(:,1)/sqrt(nmd_per(ipt).x0.vm),...
    nmd_per(ipt).x0.VOLUME*constant.ang2m^3)
[nmd_freq(ipt).bins nmd_cond(ipt).freq] =...
    m_ald_cond_freq(...
    sedald(ipt).freq/sqrt(nmd_per(ipt).x0.vm),...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) )),...
    sedald(ipt).vel(:,1)/sqrt(nmd_per(ipt).x0.vm),...
    nmd_per(ipt).x0.VOLUME*constant.ang2m^3,...
    bin_size);
cond(ipt).ald =...
    m_ald_cond(...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) +...
    (1./alloy(ipt).life(:,1)) )),...
    sedald(ipt).vel(:,1)/sqrt(nmd_per(ipt).x0.vm),...
    nmd_per(ipt).x0.VOLUME*constant.ang2m^3)
[ald_freq(ipt).bins ald_cond(ipt).freq] =...
    m_ald_cond_freq(...
    sedald(ipt).freq/sqrt(nmd_per(ipt).x0.vm),...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) +...
    (1./alloy(ipt).life(:,1)) )),...
    sedald(ipt).vel(:,1)/sqrt(nmd_per(ipt).x0.vm),...
    nmd_per(ipt).x0.VOLUME*constant.ang2m^3,...
    bin_size);
loglog(...
    sedald(ipt).freq*sqrt(nmd_per(ipt).x0.vm),...
    sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm),'.',...
    alloy(ipt).freq,...
    alloy(ipt).life,'.',...
    alloy(ipt).freq,...
    (1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) +...
    (1./alloy(ipt).life(:,1)) )),'.',...
    alloy(ipt).freq/sqrt(nmd_per(ipt).x0.vm),...
    1E17*alloy(ipt).freq.^(-2),...
    alloy(ipt).freq/sqrt(nmd_per(ipt).x0.vm),...
    1E42*alloy(ipt).freq.^(-4)...
    )
%--------------------------------------------------------------------------
pause
%-------------------------------------------------------------------------- 

subplot(2,1,1),...
    plot(...
    nmd_freq(1).bins,nmd_cond(1).freq/sum(nmd_cond(1).freq),...
    ald_freq(1).bins,ald_cond(1).freq/sum(ald_cond(1).freq),...
    ald_freq(5).bins,ald_cond(5).freq/sum(ald_cond(5).freq)...
    )
subplot(2,1,2),...
    plot(...
    nmd_freq(1).bins,cumtrapz(nmd_cond(1).freq)/sum(nmd_cond(1).freq),...
    ald_freq(1).bins,cumtrapz(ald_cond(1).freq)/sum(ald_cond(1).freq),...
    ald_freq(5).bins,cumtrapz(ald_cond(5).freq)/sum(ald_cond(5).freq)...
    )

%--------------------------------------------------------------------------
pause
%-------------------------------------------------------------------------- 
ipt=1;
subplot(2,1,1),...
    loglog(...
    sedald(ipt).freq/sqrt(nmd_per(1).x0.vm),sedald(ipt).life/sqrt(nmd_per(1).x0.vm),'.',...
    alloy(ipt).freq,alloy(ipt).life,'.',...
    alloy(ipt).freq,(1./( (1./(sedald(ipt).life/sqrt(nmd_per(ipt).x0.vm))) +...
    (1./alloy(ipt).life(:,1)) )),'.',...
    alloy(5).freq,alloy(5).life,'.',...
    alloy(5).freq,(1./( (1./(sedald(5).life/sqrt(nmd_per(5).x0.vm))) +...
    (1./alloy(5).life(:,1)) )),'.',...
    alloy(ipt).freq/sqrt(nmd_per(1).x0.vm),1E17*alloy(ipt).freq.^(-2),...
    alloy(ipt).freq/sqrt(nmd_per(1).x0.vm),1E42*alloy(ipt).freq.^(-4)...
    )
subplot(2,1,2),...
    semilogx(...
    nmd_freq(1).bins,cumtrapz(nmd_cond(1).freq)/sum(nmd_cond(1).freq),...
    ald_freq(1).bins,cumtrapz(ald_cond(1).freq)/sum(ald_cond(1).freq),...
    ald_freq(5).bins,cumtrapz(ald_cond(5).freq)/sum(ald_cond(5).freq)...
    )

% m_si_cond_alloy_tau_intk_createfigure(X1, Y1, X2, YMatrix1, X3, YMatrix2,...
%     X4, YMatrix3, X5, YMatrix4, X6, Y2)
% 
% m_si_cond_alloy_tau_intk_createfigure(...
%     sedald(ipt).freq*sqrt(nmd_per.x0.vm),...
%     sedald(ipt).life/sqrt(nmd_per.x0.vm),...
%     alloy(ipt).freq,...
%     [alloy(ipt).life ...
%     (1./( (1./(sedald(ipt).life/sqrt(nmd_per.x0.vm))) +...
%     (1./alloy(ipt).life(:,1)) ))],... 
%     alloy(5).freq,... 
%     [alloy(5).life ...
%     (1./( (1./(sedald(5).life/sqrt(nmd_per.x0.vm))) +...
%     (1./alloy(5).life(:,1)) ))],...
%     alloy(ipt).freq/sqrt(nmd_per.x0.vm),...
%     [1E17*alloy(ipt).freq.^(-2) ...
%     1E42*alloy(ipt).freq.^(-4)],...
%     nmd_freq(1).bins,...
%     
%     )


% 
% sed_per.ald
% alloy
% 
% loglog(...
%     sed_per.ald.freq,sed_per.ald.life,'.',...
%     sed_per.ald.freq,...
%     1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.',...
%     alloy.freq,alloy.life(:,1),'.'...
%     )
% 
% size(alloy.life)
% size(sed_per.ald.life)
% 
% %--------------------------------------------------------------------------
% pause
% %-------------------------------------------------------------------------- 
% 
% loglog(...
%     sed_vc.freq,sed_vc.life,'.',...
%     sed_per.ald.freq,...
%     1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.'...
%     )
% %--------------------------------------------------------------------------
% pause
% %-------------------------------------------------------------------------- 
% 
% cond_sed_per =...
%     m_ald_cond(...
%     sed_per.life*lj.tau,...
%     sed_per.groupvel(:,1)*(lj.sigma/lj.tau),...
%     nmd_per.VOLUME)
% 
% [sed_per_freq_bins sed_per_cond_freq] =...
%     m_ald_cond_freq(...
%     sed_per.freq,sed_per.life*lj.tau,...
%     sed_per.groupvel(:,1)*(lj.sigma/lj.tau),...
%     nmd_per.VOLUME,20)
% 
% subplot(2,1,1),...
%     loglog(sed_per_freq_bins,sed_per_cond_freq)
% size(sed_per_freq_bins)
% size(sed_per_cond_freq)
% hold on
% %--------------------------------------------------------------------------
% pause
% %-------------------------------------------------------------------------- 
% 
% cond_sed_vc =...
%     m_ald_cond(...
%     sed_vc.life*lj.tau,...
%     sed_vc.groupvel(:,1)*(lj.sigma/lj.tau),...
%     nmd_per.VOLUME)
% 
% [sed_vc_freq_bins sed_vc_cond_freq] =...
%     m_ald_cond_freq(...
%     sed_vc.freq,sed_vc.life*lj.tau,...
%     sed_vc.groupvel(:,1)*(lj.sigma/lj.tau),...
%     nmd_per.VOLUME,20)
% 
% subplot(2,1,1),...
%     loglog(sed_vc_freq_bins,sed_vc_cond_freq)
% %--------------------------------------------------------------------------
% pause
% %-------------------------------------------------------------------------- 
% 
% cond_ald =...
%     m_ald_cond(...
%     (1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ))*lj.tau,...
%     sed_per.ald.vel(:,1)*(lj.sigma/lj.tau),...
%     nmd_per.VOLUME)
% [ald_freq_bins ald_cond_freq] =...
%     m_ald_cond_freq(...
%     sed_per.ald.freq,...
%     (1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ))*lj.tau,...
%     sed_per.ald.vel(:,1)*(lj.sigma/lj.tau),...
%     nmd_per.VOLUME,20)
% 
% subplot(2,1,1),...
%     loglog(ald_freq_bins,ald_cond_freq)
% %--------------------------------------------------------------------------
% pause
% %-------------------------------------------------------------------------- 
% 
% subplot(2,1,2),...
%     loglog(...
%     sed_vc.freq,sed_vc.life,'.',...
%     sed_per.ald.freq,sed_per.ald.life,'.',...
%     0.97*sed_per.ald.freq,...
%     1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.',...
%     sed_per.ald.freq , 2*pi./sed_per.ald.freq...
%     )
% 
% hold off




%end