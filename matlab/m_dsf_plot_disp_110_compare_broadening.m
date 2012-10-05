clear
str.nmd = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/nmd_vc/work/1/';
sed = load(strcat(str.nmd,'SEDdata.mat'));
nmd = load(strcat(str.nmd,'NMDdata.mat'));
sed = nmd_convert_data(nmd,sed);
str.dsf = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/work/';
dsf.long(1) = load(strcat(str.dsf,'DSF_long_110_broaden2.0.mat'));
dsf.long(2) = load(strcat(str.dsf,'DSF_long_110_broaden5.0.mat'));



semilogy(...
    dsf.long(1).freq_range,dsf.long(1).SL(:,1),'.',...
    dsf.long(2).freq_range,dsf.long(2).SL(:,1),'.')




% subplot(3,1,3),...
%     semilogy(...
%     dsf.long.freq_range,dsf.long.SL(:,1),'.',...
%     dsf.long.freq_range,dsf.long.SL(:,2),'.',...
%     dsf.long.freq_range,dsf.long.SL(:,3),'.',...
%     dsf.long.freq_range,dsf.long.SL(:,4),'.',...
%     dsf.long.freq_range,dsf.long.SL(:,5),'.'...
%     )
% subplot(3,1,2),...
%     plot(...
%     [0;dsf.sed.freq(1,1);dsf.sed.freq(2,1);dsf.sed.freq(3,1);...
%     dsf.sed.freq(4,1);dsf.sed.freq(5,1)],...
%     [0;dsf.long.kpt(:,1)],'.',...
%     [0;dsf.sed.freq(1:3,3);dsf.sed.freq(4,5);dsf.sed.freq(5,5)],...
%     [0;dsf.long.kpt(:,1)],'.'...
%     )
% subplot(3,1,1),...
%     semilogy(...
%     dsf.tran.freq_range,dsf.tran.SL(:,1),'.',...
%     dsf.tran.freq_range,dsf.tran.SL(:,2),'.',...
%     dsf.tran.freq_range,dsf.tran.SL(:,3),'.',...
%     dsf.tran.freq_range,dsf.tran.SL(:,4),'.',...
%     dsf.tran.freq_range,dsf.tran.SL(:,5),'.'...
%     )






