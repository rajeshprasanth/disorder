
loglog(ald.freq,ald.life,'.')
ald1 = m_joe_read_data('/home/jason/disorder2/lj/ald/m0.01/Data_fullBZ.xls');
ald2 = m_joe_read_data('/home/jason/disorder2/lj/ald/m0.1/Data_fullBZ.xls');
ald3 = m_joe_read_data('/home/jason/disorder2/lj/ald/m1/10x/Data_fullBZ.xls');

loglog(...
    ald1.freq,ald1.life,'.',...
    ald2.freq,ald2.life,'.',...
    ald3.freq,ald3.life,'.'...
    )