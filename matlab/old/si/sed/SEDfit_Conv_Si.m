
%--------------INPUT-------------------------------------------------------
kb = 1.3806E-23;                    %aJ/k (1.3806E-23 J/K)
hbar = 1.054E-34;                %J/s
i = sqrt(-1);

mass_Si = 28.0855/(6.022 * 10^23)/(10^3);   %kg
ps2s = 10E11;
ang2m = 10E-11;



%Set main directory 
        str_main=strcat('D:\CMU\work\Si\SED\300K\6x\');

        
        NUM_SUPERCELL = input('Enter number of supercell copies: ');
        NUM_MODES = input('Enter number of modes to expect: ');

%KPTLIST: Load kpt list
    str_read=strcat(str_main,'SED\conv\kptlist.dat');
    %Linux
    %str_main=strcat('/home/jason/lammps/Si/500K/4x/');
    %str_read=strcat(str_main,'NMD/1atom/kptlist.dat');
    SED.kptlist(:,1:3) = load(str_read); [NUM_KPTS, blank] = size(SED.kptlist(:,1:3));
%INITIAL POSITIONS: Set initial positions for id matching
    %Windoze
    str_read=strcat(str_main,'SED\conv\x0.data');
    %Linux
    %str_read=strcat(str_main,'NMD/1atom/x0.data');
    x0 = load(str_read);
    %Define number of atoms
    NUM_ATOMS = x0(1,1); NUM_ATOMS_UCELL = x0(1,2); NUM_UCELL_COPIES=NUM_ATOMS/NUM_ATOMS_UCELL; 
    NUM_UCELL_INX = (NUM_ATOMS/8)^(1/3);
    %Define box size and conventional cell lattice parameters
    L(1) = x0(1,3); L(2) = x0(1,4); L(3) = x0(1,5); alat = L/( NUM_UCELL_INX );
    VOLUME = (L(1)*ang2m)^3;
    %chop off first line of input structure
    x0 = x0(2:length(x0),:);
%SED PARAMETERS: load SED parameters
    %Windoze
    str_read=strcat(str_main,'SED\conv\SED_param.dat');
    %Linux
    %str_read=strcat(str_main,'NMD/1atom/SED_param.dat');
    SEDparam = load(str_read);
    N_wmax = SEDparam(1); N_wstep = SEDparam(2); t_total = SEDparam(3); t_step = SEDparam(4);
    dt = SEDparam(5);  NUM_FFTS = SEDparam(6); NUM_SEED = SEDparam(7);
    w_step = 2*pi/(t_total*dt/ps2s); w_max = 2*pi/(t_step*dt*2/ps2s);
    NUM_TSTEPS = t_total/t_step; NUM_OMEGAS = t_total/(2*t_step);  
    NUM_MODES = NUM_ATOMS_UCELL*3;
    w_plot = NUM_OMEGAS; 
    w_plot_left = 1;
    w_plot_right = 1200;
    
%FREQUENCIES
        %Windoze
        str_read=strcat(str_main,'SED\conv\freq.dat');
        %Linux
        %str_read=strcat(str_main,'NMD/1atom/freq.dat');
        freq = load(str_read);
%GROUP VEL
        %Windoze
        str_read=strcat(str_main,'SED\conv\vel.dat');
        %Linux
        %str_read=strcat(str_main,'NMD/1atom/freq.dat');
        group_vel = load(str_read);
            
%READ IN FIRST FILE        
        str_read=strcat(str_main,'SED\conv\SED_1.txt');
        dummy = importdata(str_read,'\t');  
            %This figures out how many kpts are being read in by checking the length
            %of dummy and dividing by the number of kpt sections SAMPLE_RATE+1.  
            %we've been having SAMPLE_RATE=1024;
        NUM_KPTS = floor(length(dummy(:,1)) / (NUM_OMEGAS+1));
        SED.redkpt.sed(1:NUM_OMEGAS,1:NUM_KPTS) = 0.0;
        
    %------AVG OVER SEEDS------------------------------------------------------
        for i1=1:NUM_SEED
                %ME
                str=strcat(str_main,'SED\conv\SED_',int2str(i1),'.txt');
                %ALEX
                %str=strcat(str_main,'SEDseed_avg.txt');

                dummy = importdata(str,' ');  
                %This figures out how many kpts are being read in by checking the length
                %of dummy and dividing by the number of kpt sections SAMPLE_RATE+1.  
                %we've been having SAMPLE_RATE=1024;
                NUM_KPTS = length(dummy(:,1)) / (NUM_OMEGAS+1);

                %This takes the SED data in dummy and puts it in the object SED.freq.  The
                %data is stored SED.freq(1:1024,1:NUM_KPTS).  The kpt data is stored in
                %SED.kpt(1:NUM_KPTS,1:3) => [kx ky kz];
                    for i2=1:NUM_KPTS
                    SED.redkpt.sed(:,i2) = SED.redkpt.sed(:,i2) + dummy((i2-1)*(NUM_OMEGAS+1)+2:(i2)*(NUM_OMEGAS+1),2);
                    SED.redkpt.kpt(i2,1:3) = dummy((i2-1)*(NUM_OMEGAS+1)+1,1:3);
                    end
        end
        SED.redkpt.sed(:,:) = SED.redkpt.sed(:,:)/NUM_SEED;


    %------FIND NUMBER IRR KPTS AND AVG------------------------------------ 

        % Identify irreducible k-points, store in SED.irrkpt
        % The first kpt is automatically a irreducible point.
        SED.irrkpt.kpt(1,1:3) = SED.redkpt.kpt(1,1:3); SED.irrkpt.numdegen(1)=1; SED.irrkpt.numirr=1;
        SED.irrkpt.sedavg(1:NUM_OMEGAS,SED.irrkpt.numirr)=0;
        %str_write=strcat(str_main,'redkpt.dat');
        %dlmwrite(str_write,SED.redkpt.kpt(1,1:3),'-append');
i1=1;
SED.redkpt.groupvel(1:NUM_MODES,1:3,i1) = group_vel((i1-1)*NUM_ATOMS_UCELL*3+1:(i1)*NUM_ATOMS_UCELL*3,1:3);
SED.redkpt.freq(i1,1:NUM_MODES) = freq(i1,1:NUM_MODES);
SED.irrkpt.HLDfreq(1:NUM_MODES,SED.irrkpt.numirr) = SED.redkpt.freq(i1,1:NUM_MODES);
SED.irrkpt.HLDvel(1:NUM_MODES,1:3,SED.irrkpt.numirr) = SED.redkpt.groupvel(1:NUM_MODES,1:3,i1);
        
        for i1=2:NUM_KPTS  
%Put in group velocities and HLD       
            
            SED.redkpt.groupvel(1:NUM_MODES,1:3,i1) = group_vel((i1-1)*NUM_ATOMS_UCELL*3+1:(i1)*NUM_ATOMS_UCELL*3,1:3);
            SED.redkpt.freq(i1,1:NUM_MODES) = freq(i1,1:NUM_MODES);
            
            tempcnt = 0.0;
            %dlmwrite(str_write,SED.redkpt.kpt(i1,1:3),'-append');
            for i2=1:SED.irrkpt.numirr 
                if issym(SED.irrkpt.kpt(i2,1:3),SED.redkpt.kpt(i1,1:3)) == 1.0;
                     tempcnt = 1.0;
                     idegen = i2;
                end
            end
            
            if tempcnt==0.0 %didn't find in the irrkpt list, its a new point
            SED.irrkpt.numirr = SED.irrkpt.numirr +1;
            SED.irrkpt.kpt(SED.irrkpt.numirr,1:3) = SED.redkpt.kpt(i1,1:3);
%Put in HLD  

            SED.irrkpt.HLDfreq(1:NUM_MODES,SED.irrkpt.numirr) = SED.redkpt.freq(i1,1:NUM_MODES);
            SED.irrkpt.HLDvel(1:NUM_MODES,1:3,SED.irrkpt.numirr) = SED.redkpt.groupvel(1:NUM_MODES,1:3,i1);
            
            SED.irrkpt.sedavg(:,SED.irrkpt.numirr) = SED.redkpt.sed(:,i1);
            SED.irrkpt.numdegen(SED.irrkpt.numirr) = 1;
            SED.redkpt.degen(i1)=SED.irrkpt.numirr;
            
            else %found it in the irrkpt list, add it as a degen
            SED.irrkpt.numdegen(idegen) = SED.irrkpt.numdegen(idegen) +1;
            SED.irrkpt.sedavg(:,idegen) = SED.irrkpt.sedavg(:,idegen) + SED.redkpt.sed(:,i1);
            SED.redkpt.degen(i1)=idegen;
            end


        end
 %AVG over degen pts       
    for i2=1:SED.irrkpt.numirr         
        SED.irrkpt.sedavg(:,i2) = SED.irrkpt.sedavg(:,i2)./SED.irrkpt.numdegen(i2);
    end
        
%-----------------------------------------------------------
pause
%-----------------------------------------------------------            

%RE-DO LIST
    REDO=1; 
    AUTO=0;
%BUILD MAIN LIST OF IRRKPTS TO RUN OVER    
    kpt_list = 1:SED.irrkpt.numirr;
    RUN=1;

while RUN==1
    for kpt_cnt=1:length(kpt_list)      
        %PRINT CURRENT KPT
                    SED.irrkpt.kpt(kpt_list(kpt_cnt),1:3)
    %CALCULATE HLD INFO
            KPT_TOL = 10E-6; 
            DEGEN_WIDTH=3.0;
                         kx = SED.irrkpt.kpt(kpt_list(kpt_cnt),1)/NUM_SUPERCELL;
                         ky = SED.irrkpt.kpt(kpt_list(kpt_cnt),2)/NUM_SUPERCELL;
                         kz = SED.irrkpt.kpt(kpt_list(kpt_cnt),3)/NUM_SUPERCELL;
                    
if kx==0 & ky==0 & kz==0
        SED.irrkpt.sedfreq( 1:NUM_MODES ,kpt_list(kpt_cnt)) = 0;
        %Store in ps
        SED.irrkpt.life( 1:NUM_MODES ,kpt_list(kpt_cnt)) = 0; 
        SED.irrkpt.flag(kpt_list(kpt_cnt))=0;
else                    
                    
            HLD_SCALING_PCT=0.99;

            ceil(SED.irrkpt.HLDfreq(1:NUM_MODES,kpt_list(kpt_cnt))/w_step*HLD_SCALING_PCT)

            %FIND # OF NON_DEGENERATE HLD PEAKS
                        %[HLDndpks,numndpks] = ndpks_HLD(ceil(HLDpks/tau_Ar/w_step*HLD_SCALING_PCT),DEGEN_WIDTH);

            %semilogy(1:length(SED.irrkpt.sedavg(:,kpt_list(kpt_cnt))),SED.irrkpt.sedavg(:,kpt_list(kpt_cnt)),'.') 
            semilogy(w_plot_left:w_plot_right,SED.irrkpt.sedavg(w_plot_left:w_plot_right,kpt_list(kpt_cnt)),'.')

            %SPECIFY LOCATION OF PEAKS AUTO OR MANUAL (REDO)        

            if AUTO==1                       
                        %FIND # OF NON_DEGENERATE PEAKS
                        %HLDdegenlist = group_peaks(ceil(HLDpks/tau_Ar/w_step*HLD_SCALING_PCT),DEGEN_WIDTH);
                        HLDdegenlist = group_peaks(ceil( SED.irrkpt.HLDfreq(1:NUM_MODES,kpt_list(kpt_cnt))/w_step*HLD_SCALING_PCT ),DEGEN_WIDTH);
                        [HLDndpks,numndpks] = ndpks_HLD(ceil( SED.irrkpt.HLDfreq(1:NUM_MODES,kpt_list(kpt_cnt))/w_step*HLD_SCALING_PCT ),DEGEN_WIDTH);
                        loc=HLDndpks
                        
                        %Don't look for 0 freq at the gamma pt
                        if SED.irrkpt.kpt(kpt_list(kpt_cnt),1)==0 & SED.irrkpt.kpt(kpt_list(kpt_cnt),2)==0 & SED.irrkpt.kpt(kpt_list(kpt_cnt),3)==0
                            %loctemp=loc; clear loc
                            %loc=(loctemp(2:length(loctemp)));
                            loc = [1 2 3];
                        end   

            elseif REDO==1
                %semilogy(1:length(SED.irrkpt.sedavg(:,kpt_list(kpt_cnt))),SED.irrkpt.sedavg(:,kpt_list(kpt_cnt)),'.')
                semilogy(w_plot_left:w_plot_right,SED.irrkpt.sedavg(w_plot_left:w_plot_right,kpt_list(kpt_cnt)),'.')
                number_pks = input('Enter the number of peaks: ');
                number_pks = 24;
%                 loc=ceil( SED.irrkpt.HLDfreq(1:NUM_MODES,kpt_list(kpt_cnt))/w_step*HLD_SCALING_PCT )
                for i2=1:number_pks
                    str_input = strcat('Enter peak  ',int2str(i2),' location: ');
                    loc(i2) = input(str_input);
                end
                %FIND # OF NON_DEGENERATE PEAKS
                HLDdegenlist = group_peaks(ceil( SED.irrkpt.HLDfreq(1:NUM_MODES,kpt_list(kpt_cnt))/w_step*HLD_SCALING_PCT ),DEGEN_WIDTH);
                [HLDndpks,numndpks] = ndpks_HLD(loc,DEGEN_WIDTH);
                loc=HLDndpks
            end


    %Set freq to 1:sample_size
                    w(:,1)=(1:length(SED.irrkpt.sedavg(:,kpt_list(kpt_cnt))));   
    %Run over all peak locations found
                    str_func= '';
    %GROUP LOCATION WIDTH
                    if REDO==1
                        GROUP_LOCATION_WIDTH=input('Enter GROUP LOCATION WIDTH: ');
                    else
                        GROUP_LOCATION_WIDTH=20;
                    end
                    %GROUP PEAKS FOR SINGLE OR MULTIPLE FITS        
                    group_loc = group_peaks(loc,GROUP_LOCATION_WIDTH);
    %BUILD LORENTZIAN FUNCTIONS SINGLE AND MULTIPLE     
        %Pad the frequencies and lifetimes by the 0 freqs from HLD
                    HLD_FREQ_TOL = 0.01;
                    Ipad = find(abs(SED.irrkpt.HLDfreq(:,kpt_list(kpt_cnt)))<HLD_FREQ_TOL);
                    SED.irrkpt.sedfreq(1:length(Ipad),kpt_list(kpt_cnt)) = SED.irrkpt.HLDfreq(1:length(Ipad),kpt_list(kpt_cnt));

    %Loop over grouped peaks and fit 
            %Keep track of pk count w.r.t. HLD degen
            pk_cnt=1;
            for group_id = 1:group_loc(length(group_loc))               
                Igroup = find(group_loc==group_id);
                str_func= '';
                for i3=1:length(Igroup)
                    if length(Igroup)==1
                    strtemp= strcat('(c(',int2str(i3),'))./(1 + ( (w - c(',int2str(i3+2),'))./ c(',int2str(i3+1),') ).^2 )');
                    str_func = strcat(str_func,strtemp);
                    else
                    strtemp= strcat(' + ( c(',int2str(3*(i3-1)+1),'))./(1 + ( (w - c(',int2str(3*(i3-1)+3),'))./ c(',int2str(3*(i3-1)+2),') ).^2 )');
                    str_func = strcat(str_func,strtemp);
                    end  
                end
                
            %LORENTZIAN FUNCTION FOR SINGLE AND MULTIPLE PEAKS            
                lor_func = inline(str_func,'c','w');
    %PERCENT PAST PEAKS
            if REDO==1
            PT_PERC=input('Enter PERCENT PAST PEAKS: ');
            else
                if length(Igroup) == 1
                    PT_PERC = 0.01;
                else
                    PT_PERC = 0.01;
                end
            end


            if SED.irrkpt.kpt(kpt_list(kpt_cnt),1)==0 & SED.irrkpt.kpt(kpt_list(kpt_cnt),2)==0 & SED.irrkpt.kpt(kpt_list(kpt_cnt),3)==0
                wleft = 1; wright = w_plot;
            else
                %Find wleft    
                        [I,J] = find(PT_PERC*mean(SED.irrkpt.sedavg(loc(Igroup(1)),kpt_list(kpt_cnt)))>SED.irrkpt.sedavg(1:loc(Igroup(1)),kpt_list(kpt_cnt)) );
    %                     loc(Igroup(1))
    %                     SED.irrkpt.sedavg(loc(Igroup(1)),kpt_list(kpt_cnt))
    %                     PT_PERC*SED.irrkpt.sedavg(loc(Igroup(1)),kpt_list(kpt_cnt))
                        wleft = w(I(length(I)));
                %Find wright
                        [I,J] = find(PT_PERC*mean(SED.irrkpt.sedavg(loc(Igroup(length(Igroup))),kpt_list(kpt_cnt)))>SED.irrkpt.sedavg(loc(Igroup(length(Igroup))):length(SED.irrkpt.sedavg),kpt_list(kpt_cnt)) );
                        wright = w(loc(Igroup(length(Igroup)))+I(1)  );
                        gamma_guess = 0.2;
            end
            

            
                %Build intial guess array
                        for i3=1:length(Igroup)   
                            if length(Igroup)==1
                               gamma_guess = input('Input gamma guess: ');
                            c0(1+(i3-1)*3:i3*3) = [ 100*SED.irrkpt.sedavg(loc(Igroup(i3)), kpt_list(kpt_cnt) ) , gamma_guess, loc(Igroup(i3)) ];
                            else
                            %make gamma_guess/length(Igroup) to make a guess that all
                            %multiple lorentzians have 1/N (1/3 for N=3 example) the width
                                if REDO==1  
                                    gamma_guess = input('Input gamma guess: ');
                                    [Imax,Jmax] = max(SED.irrkpt.sedavg(wleft:wright,kpt_list(kpt_cnt)));
                                c0(1+(i3-1)*3:i3*3) = [ 100*SED.irrkpt.sedavg(loc(Igroup(i3)), kpt_list(kpt_cnt) ) , gamma_guess, loc(Igroup(i3)) ];    
                                else
                                    gamma_guess = 0.2;
                                    [Imax,Jmax] = max(SED.irrkpt.sedavg(wleft:wright,kpt_list(kpt_cnt)));
                                c0(1+(i3-1)*3:i3*3) = [ 100*SED.irrkpt.sedavg(loc(Igroup(i3)), kpt_list(kpt_cnt) ) , gamma_guess, loc(Igroup(i3)) ];    
                                end
                            end
                        end 

                %FIT THE LORENTZIAN(S)
                options = optimset('MaxIter',50000,'MaxFunEvals',50000,'TolFun',1e-4,'TolX',1e-4);  
                c = c0;
                %[c_fit,r,j] = nlinfit(w(wleft:wright),SED.irrkpt.sedavg(wleft:wright,kpt_list(kpt_cnt)),lor_func,c);
                lb(1:length(c0)) = 0.0; ub(1:3:length(c0)) = max(SED.irrkpt.sedavg(:,kpt_list(kpt_cnt)))*20; ub(2:3:length(c0)) = 100; ub(3:3:length(c0)) = w(length(w));
                [c_fit,RESNORM,RESIDUAL,EXITFLAG,OUTPUT,LAMBDA,JACOBIAN] = lsqcurvefit(lor_func,c0,w(wleft:wright),SED.irrkpt.sedavg(wleft:wright,kpt_list(kpt_cnt)),lb,ub,options);

%                 if EXITFLAG~=1
%                     options = optimset('MaxIter',50000,'MaxFunEvals',50000,'TolFun',1e-3,'TolX',1e-4);
%                     [c_fit,RESNORM,RESIDUAL,EXITFLAG,OUTPUT,LAMBDA,JACOBIAN] = lsqcurvefit(lor_func,c_fit,w(wleft:wright),SED.irrkpt.sedavg(wleft:wright,kpt_list(kpt_cnt)),lb,ub,options);
%                 end
                %Store separate liftimes and frequencies for single and MULTIPLE FITS
                %Hold on to plot multiple peaks
                hold on
                        Igroup = find(group_loc==group_id);
                            for i3=1:length(Igroup)  
                                %if length(Ipad)==0
                                    Idegen = find(HLDdegenlist==pk_cnt);
                                %else
                                %    Idegen = find(HLDdegenlist==pk_cnt+1);
                                %end
                                center=c_fit(3*i3)*w_step;
                                lifetime=1/(2*c_fit(3*i3-1))/w_step;
                                %Store in rads/ps
                                SED.irrkpt.sedfreq( Idegen ,kpt_list(kpt_cnt)) = center;
                                %Store in ps
                                SED.irrkpt.life( Idegen ,kpt_list(kpt_cnt)) = lifetime;
                                %Keep track of pk position taking
                                %into account degen w.r.t. HLD
                                pk_cnt = pk_cnt +1;
                            end
                %Plot each fit, single and multiple
                semilogy(w(wleft:wright),SED.irrkpt.sedavg(wleft:wright,kpt_list(kpt_cnt)),w(wleft:wright),lor_func(c_fit,w(wleft:wright)))
                %axis([0 1.0*length(w) 0.0001*max(SED.irrkpt.sedavg(:,kpt_list(kpt_cnt))) max(SED.irrkpt.sedavg(:,kpt_list(kpt_cnt)))]);
                axis([w_plot_left w_plot_right 0.0001*max(SED.irrkpt.sedavg(:,kpt_list(kpt_cnt))) max(SED.irrkpt.sedavg(:,kpt_list(kpt_cnt)))]);
%-----------------------------------------------------------
pause
%-----------------------------------------------------------
            end
end
            
        %Calculate integral of SED = 2TE
            SED.irrkpt.sedintegral(kpt_list(kpt_cnt)) = ( trapz(w*(w_step*5E-15),SED.irrkpt.sedavg(:,kpt_list(kpt_cnt))));
        
                disp(sprintf('%s', 'SED FREQ:'));
                SED.irrkpt.sedfreq(:,kpt_list(kpt_cnt))
                disp(sprintf('%s', 'SED LIFE:'));
                SED.irrkpt.life(:,kpt_list(kpt_cnt))
               
        %1=yes, 0=no
        SED.irrkpt.flag(kpt_list(kpt_cnt)) = input('Flag?: ');
        %Clear current plot
        clf
        hold off
    clear I J buffer wleft wright c0 lb ub pks loc str_func lifetime center
    end
    

    %Check for any flags, if so redo those kpts manually
        for i1=1:length(SED.irrkpt.flag(:))
            Iflag = find(SED.irrkpt.flag==1);
            if length(Iflag)==0;
                RUN=0;
            else
                RUN=1; AUTO=0; REDO=1; kpt_list = Iflag;
                %disp(sprintf('%s', 'REDO:'));
            end
        end
    
end



%--------------------OUTPUT DATA-------------------------------------------  

    str_loop = input('Write data to file?: ');
    str_write=strcat(str_main,'SED_data.dat');
    str_write_life=strcat(str_main,'SED_life.dat');
    str_write_integral=strcat(str_main,'SED_integral.dat');
    if str_loop ==1
        NUM_MODES = length(SED.irrkpt.HLDfreq(:,1));
                %------FIND RED KPTS------------------------------------------------ 

            for i1=1:NUM_KPTS
                for kpt_cnt=1:SED.irrkpt.numirr
                        if issym(SED.irrkpt.kpt(kpt_cnt,1:3),SED.redkpt.kpt(i1,1:3)) == 1.0;
                            %Write the wavevector first
                            dlmwrite(str_write,SED.redkpt.kpt(i1,1:3),'-append');
                            %Write the number of degenerate kpts for mult factor
                            %dlmwrite(str,SED.irrkpt.numdegen(kpt_list(kpt_cnt)),'-append')
                            %;
                            
                            %CALCULATE CONTRIBUTION TO TE INTEGRAL
                            SED.redkpt.sedintegral(i1) = SED.irrkpt.sedintegral(kpt_cnt);
                            dlmwrite(str_write_integral,SED.redkpt.sedintegral(i1),'-append');
                            
                            
                            %CALCULATE HLD DATA FOR RED KPT
                                kx = SED.redkpt.kpt(i1,1)/NUM_SUPERCELL;
                                ky = SED.redkpt.kpt(i1,2)/NUM_SUPERCELL;
                                kz = SED.redkpt.kpt(i1,3)/NUM_SUPERCELL;
                                if kx==0.5; kx = kx-KPT_TOL; end
                                if ky==0.5; ky = ky-KPT_TOL; end
                                if kz==0.5; kz = kz-KPT_TOL; end
                                
                                    for i2=1:NUM_MODES
                                        whld = SED.redkpt.freq(i1,i2);
                                        wsed = SED.irrkpt.sedfreq(i2,kpt_cnt);
                                        lifetau = SED.irrkpt.life(i2,kpt_cnt);
                                        velx = SED.redkpt.groupvel(i2,1,i1);
                                        vely = SED.redkpt.groupvel(i2,2,i1);
                                        velz = SED.redkpt.groupvel(i2,3,i1);
                                        svelx = velx*(wsed/whld);
                                        svely = vely*(wsed/whld);
                                        svelz = velz*(wsed/whld);
                                        kappax = (kb/VOLUME)*lifetau*(svelx^2);
                                        kappay = (kb/VOLUME)*lifetau*(svely^2);
                                        kappaz = (kb/VOLUME)*lifetau*(svelz^2);


                                        SED.redkpt.HLDfreq(i2,i1) = whld;
                                        SED.redkpt.sedfreq(i2,i1) = wsed;
                                        SED.redkpt.life(i2,i1) = lifetau;
                                        SED.redkpt.HLDvel(i2,1,i1) = velx;
                                        SED.redkpt.HLDvel(i2,2,i1) = vely;
                                        SED.redkpt.HLDvel(i2,3,i1) = velz;
                                        SED.redkpt.svel(i2,1,i1) = svelx;
                                        SED.redkpt.svel(i2,2,i1) = svely;
                                        SED.redkpt.svel(i2,3,i1) = svelz;
                                        SED.redkpt.kappa(i2,1,i1) = kappax;
                                        SED.redkpt.kappa(i2,2,i1) = kappay;
                                        SED.redkpt.kappa(i2,3,i1) = kappaz;

                                    output_format = [whld wsed lifetau velx vely velz svelx svely svelz,kappax,kappay,kappaz];
                                    output_life = [whld wsed lifetau velx vely velz svelx svely svelz,kappax,kappay,kappaz];
                                    dlmwrite(str_write,output_format,'-append');
                                    dlmwrite(str_write_life,output_life,'-append');
%                                 if wsed<(w_max*10^12) && wsed>(w_step) && lifetau<(10^-10) && lifetau>(10^-13)
%                                 output_format = [whld wsed lifetau velx vely velz svelx svely svelz]; 
%                                 else
%                                 output_format = [0 0 0 0 0 0 0 0 0]; 
                                    end
                        end
                end
            end
    end
%END MAIN FUNCTION    
%end



%-------------FUNCTIONS----------------------------------------------------


% function istrue=issym(kpt1,kpt2)
% istrue=0.0;
% istrue1=0.0; istrue2=0.0;
%         for i2=-1:2:1
%             for i3=-1:2:1
%                 for i4=-1:2:1
%                     
%                     temp(1) = i2*kpt2(1); temp(2) = i3*kpt2(2); temp(3) = i4*kpt2(3);
% 
%                     if kpt1(1) == temp(1) && kpt1(2) == temp(2) && kpt1(3) == temp(3)
%                         istrue=1.0;
%                     elseif kpt1(1) == temp(3) && kpt1(2) == temp(1) && kpt1(3) == temp(2)
%                         istrue=1.0;
%                     elseif kpt1(1) == temp(2) && kpt1(2) == temp(3) && kpt1(3) == temp(1)
%                         istrue=1.0;
%                     elseif kpt1(1) == temp(1) && kpt1(2) == temp(3) && kpt1(3) == temp(2)
%                         istrue=1.0;
%                     elseif kpt1(1) == temp(3) && kpt1(2) == temp(2) && kpt1(3) == temp(1)
%                         istrue=1.0;
%                     elseif kpt1(1) == temp(2) && kpt1(2) == temp(1) && kpt1(3) == temp(3)
%                         istrue=1.0;
%                     end
%                 end
%             end
%         end
% end


     
% function group_loc = group_peaks(loc,groupdis)
%     sup_peak_dist = groupdis;
%     clear fitpks
%     for i=1:length(loc)-1
%         dist(i) = loc(i+1) - loc(i);
%     end
% 
%     id = 1;
%     for i=1:length(loc) - 1
%         fitpks(i) = id;
%         if (dist(i) > sup_peak_dist)
%             id = id + 1;
%         end
%     end
%     fitpks(i + 1) = id;
%     group_loc = fitpks; 
% end

% function [HLDndpks,numndpks] = ndpks_HLD(HLDpks,DEGEN_WIDTH)
%     numndpks = 1;
%     HLDndpks(1) = HLDpks(1);
%     for j=2:length(HLDpks) %should be equal to 12
%         degencount = 0;
%         for k=1:numndpks
%             if abs(HLDpks(j)-HLDndpks(k)) < DEGEN_WIDTH
%                 degencount = 1;
%             end
%         end
%         if degencount == 0
%             numndpks = numndpks +1;
%             HLDndpks(numndpks) = HLDpks(j);
%         end
%     end
% end


