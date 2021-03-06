
% %4x
% str.NMD = '/home/jason/lammps/LJ/amorphous/4x/1';
% PT_PERC=0.005; INV_PERC = 0.0;

%8x
str.NMD = '/home/jason/lammps/LJ/amorphous/8x/1';
PT_PERC=0.005; INV_PERC = 0.5;



NMD=load(strcat(str.NMD,'/NMDavg.mat'));

SED=load(strcat(str.NMD,'/SEDavg.mat'));

[tmp,str.main]=system('pwd');

for imode=3000:size(SED.modemaster,2)      
%PRINT CURRENT KPT
    SED.modemaster(imode)
%scaling
    HLD_SCALING_PCT=0.95;
%              
w_guess =...
    ceil(...
    SED.HLDfreq(imode)/NMD.w_step*HLD_SCALING_PCT)

%semilogy(1:length(SED.irrkpt.sedavg(:,kpt_list(kpt_cnt))),SED.irrkpt.sedavg(:,kpt_list(kpt_cnt)),'.') 
    semilogy(1:NMD.NUM_OMEGAS,SED.sed(1:NMD.NUM_OMEGAS,imode),'.')
%Set freq to 1:sample_size
    w(:,1)=(1:length(SED.sed(:,imode)));   
%LORENTZIAN FUNCTION FOR SINGLE AND MULTIPLE PEAKS 
    [Ipeak,Jpeak]=max(SED.sed(:,imode));
    [Imin,Jmin] = min(SED.sed(:,imode));
%--------------------------------------------------------------------------
pause
%--------------------------------------------------------------------------

if imode<4
    
%Store 
    SED.sedfreq( imode ) = 0;
%Store 
    SED.life( imode ) = 0;
%Store    
    SED.height( imode ) = 0;
%Store
    SED.wleft(imode) = 0;
    SED.wright(imode) = 0;
    
else

%Find wleft    
    [I,J] =...
        find(...
        SED.sed(...
        1:Jpeak,imode)<PT_PERC*SED.sed(Jpeak,imode));
    wleft = w(I(length(I)));
%Find wright
    [I,J] = find(...
        SED.sed(...
        Jpeak:length(w),imode)>PT_PERC*SED.sed(Jpeak,imode));
%
    wright = Jpeak + I(length(I));
%     wright = w_guess(imode) + I(length(I));
    gamma_guess = 10;
%
    [Imax,Jmax] = max(SED.sed(wleft:wright,imode));          
%
    weights = ones(length(w(wleft:wright)),1);
%
    weights(1:1) = INV_PERC/PT_PERC;
    weights(length(weights)-1:length(weights)) = INV_PERC/PT_PERC;
%
    lor_func = @(c,w)weights.*(c(1))./(1 + ( (w - c(3))./ c(2) ).^2 );
%
    options =...
        optimset(...
        'MaxIter',20000,'MaxFunEvals',20000,'TolFun',1e-7,'TolX',1e-8);  
%
    [Ipeak,Jpeak]=max(SED.sed(:,imode));
%Initial Guess
    c0 = [ 2*Ipeak, gamma_guess, Jpeak ]; 
%    c0 = [ 2*Ipeak, gamma_guess, w_guess(imode) ]; 
%FIT THE LORENTZIAN(S)
    lb(1:length(c0)) = 0.0; ub(1:3:length(c0)) =...
        max(SED.sed(:,imode))*10; 
    ub(2:3:length(c0)) = 1000; ub(3:3:length(c0)) = w(length(w));
    [c_fit] =...
        lsqcurvefit(...
        lor_func,c0,w(wleft:wright),...
        SED.sed(wleft:wright,imode).*weights,...
        lb,ub,options);
%Store separate liftimes and frequencies for single and MULTIPLE FITS
    center=c_fit(3)*NMD.w_step; lifetime=1/(2*c_fit(2))/NMD.w_step;
%Store 
    SED.sedfreq( imode ) = center;
%Store 
    SED.life( imode ) = lifetime;
%Store    
    SED.height( imode ) = c_fit(1);
%Store
    SED.wleft(imode) = wleft;
    SED.wright(imode) = wright;
%Plot each fit, single and multiple
    semilogy(w(wleft:wright),...
        SED.sed(wleft:wright,imode),'.',...
        w(wleft:wright),lor_func(c_fit,w(wleft:wright)),...
        w(wleft:wright),lor_func(c0,w(wleft:wright)))
    axis([wleft wright min(...
        SED.sed(:,imode))...
        max(SED.sed(:,imode))]);

end
    
imode

%--------------------------------------------------------------------------
pause
%--------------------------------------------------------------------------
    disp(sprintf('%s', 'SED FREQ:'));
    SED.sedfreq(imode)
    disp(sprintf('%s', 'SED LIFE:'));
    SED.life(imode)
clf
hold off
clear I J buffer c0 pks loc str_func lifetime center
end
    
save(strcat(str.NMD,'/NMDfit.mat'), '-struct', 'NMD');
save(strcat(str.NMD,'/SEDfit.mat'), '-struct', 'SED');

loglog(SED.sedfreq(:),SED.life(:),'.')

pause

plot(SED.HLDfreq,SED.sedfreq,'.')

% gamma = 1 / (SED.irrkpt.life(1,48)*NMD.w_step*2);
% height = SED.irrkpt.height(1,48); 
% freq = SED.irrkpt.sedfreq(1,48)/NMD.w_step;
% wright = SED.irrkpt.wright(1,48); wleft = SED.irrkpt.wleft(1,48); 
% 
% c_fit = [height, gamma, freq];
% weights(1:size(wleft:wright,2),1) = 1;
% semilogy(...
%     w(wleft:wright) ,...
%     SED.irrkpt.sedavg( wleft:wright , imode , kpt_cnt ),'.',...
%     w(wleft:wright) , lor_func(c_fit , w(wleft:wright) ) );
    
    
   

