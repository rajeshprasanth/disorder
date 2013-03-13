function cond = m_pbte_cond

%\cite{thermal_fedorov_1969}
cond.qiu_expt = load('/home/jason/disorder/pbte/m_pbte_cond_qiu_expt.txt');
cond.qiu_expt(:,1) = (cond.qiu_expt(:,1) - 32)*(5/9) + 273 ; 
cond.qiu_expt
cond.qiu = load('/home/jason/disorder/pbte/m_pbte_cond_qiu_own.txt');
cond.qiu(:,1) = (cond.qiu(:,1) - 32)*(5/9) + 273 ; 
cond.qiu

cond.tian.pbte_expt = load('/home/jason/disorder/pbte/m_pbte_cond_tian_pbte(T)_expt.txt');
cond.tian.pbte_300K = load('/home/jason/disorder/pbte/m_pbte_cond_tian_pbte_se_300K.txt');
cond.tian.pbte_500K = load('/home/jason/disorder/pbte/m_pbte_cond_tian_pbte_se_500K.txt');

cond.Tmelt.pbte = 917+273;	%\cite{lead_dughaish_2002} K
cond.Tmelt.pbse = 1067+273;	%\cite{law_structural_2008} K

cond.pbte.HS = 0.36;		%\cite{lattice_koh_2009} W/m-K

plot(...
    cond.qiu(:,1)/cond.Tmelt.pbte,cond.qiu(:,2),'.',...
    cond.qiu_expt(:,1)/cond.Tmelt.pbte,cond.qiu_expt(:,2),'.'...
    )

end