




%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%INPUT
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
NMD.LJ.eps = 1.67E-21;              %aJ (1.67E-21 Joules) aJ=1E-18 J
NMD.LJ.sigma = 3.4E-10;                 %Angstroms 3.4E-10 meters
NMD.LJ.mass = 6.6326E-26;               %1E-28 kg (6.6326E-26 kg)
NMD.LJ.tau = sqrt((NMD.LJ.mass*(NMD.LJ.sigma^2))/NMD.LJ.eps);
NMD.constant.kb = 1.3806E-23;                    %aJ/k (1.3806E-23 J/K)
NMD.constant.hbar = 1.054E-34;                %J/s
NMD.constant.i = sqrt(-1);
NMD.constant.c = 29979245800.00019;      %cm/s
NMD.constant.s2ps = 1E-12;
NMD.constant.ang2m = 1E-10;
NMD.constant.eV2J = 1.60217646E-19;

%--------------------------------------------------------------------------
    [tmp,NMD.str.main]=system('pwd');
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
    NMD.alloy_conc = 0.5;
%--------------------------------------------------------------------------
    NMD.m(1) = 1.0; NMD.m(2) = 3.0; NMD.NUM_ATOMS_TYPE = 2;
    NMD.vm =...
        ( (1-NMD.alloy_conc)*NMD.m(1) + NMD.alloy_conc*NMD.m(2) );
%--------------------------------------------------------------------------

NMD.walltime.lammps = 24; NMD.cpu.lammps = 1; 
NMD.walltime.matlab = 24; NMD.cpu.matlab = 1; NMD.mem.matlab = 2;

%--------------------------------------------------------------------------
    NMD.Nx = 4; NMD.Ny = 4; NMD.Nz = 4;
%--------------------------------------------------------------------------
    NMD.seed.alloy = 1;
    NMD.seed.initial = 1:10;
%--------------------------------------------------------------------------

%SED PARAMETERS------------------------------------------------------------    

%ISEED---------------------------------------------------------------------
    NMD.NUM_SEEDS = size(NMD.seed.initial,2);
%--------------------------------------------------------------------------   

%---IKSLICE----------------------------------------------------------------
    NMD.NUM_KSLICES = 8;
%--------------------------------------------------------------------------   

%TIMES---------------------------------------------------------------------
    NMD.t_total = 2^19; NMD.t_fft = 2^19; NMD.t_step = 2^5; NMD.dt = 0.002;
    NMD.NUM_TSTEPS = NMD.t_fft/NMD.t_step; 
%-------------------------------------------------------------------------- 

%IFFT----------------------------------------------------------------------
    NMD.NUM_FFTS = NMD.t_total/NMD.t_fft;
%-------------------------------------------------------------------------- 

%FREQS---------------------------------------------------------------------
    NMD.w_step = 2*pi/(NMD.t_fft*NMD.dt); 
    NMD.w_max = 2*pi/(NMD.t_step*NMD.dt*2);
    NMD.NUM_OMEGAS = NMD.t_fft/(2*NMD.t_step); 
%-------------------------------------------------------------------------- 

%c=0.0
% alat = 5.269/3.4        %0K 
%NMD.alat = 5.290/3.4;       %10K
% alat = 5.315/3.4;       %20K
% alat = 5.341/3.4;       %30K
% alat = 5.370/3.4;       %40K
% alat = 5.401/3.4;       %50K
% alat = 5.436/3.4;       %60K
% alat = 5.476/3.4;       %70K
% alat = 5.527/3.4;       %80K

%c=0.05
% alat = 5.269/3.4        %0K 
%NMD.alat = 6.22415/4;       %10K
% alat = 5.315/3.4;       %20K
% alat = 5.341/3.4;       %30K
% alat = 5.370/3.4;       %40K
% alat = 5.401/3.4;       %50K
% alat = 5.436/3.4;       %60K
% alat = 5.476/3.4;       %70K
% alat = 5.527/3.4;       %80K

%c=0.5
% alat = 5.269/3.4        %0K 
NMD.alat = 6.22599/4;       %10K
% alat = 5.315/3.4;       %20K
% alat = 5.341/3.4;       %30K
% alat = 5.370/3.4;       %40K
% alat = 5.401/3.4;       %50K
% alat = 5.436/3.4;       %60K
% alat = 5.476/3.4;       %70K
% alat = 5.527/3.4;       %80K



%--------------------------------------------------------------------------

%Unit cell and lattice vectors
dummy = [   1.0 0.0  0.0 
            0.0  1.0 0.0 
            0.0  0.0  1.0
            0.0  0.0  0.0
            0.5  0.5  0.0
            0.5  0.0  0.5
            0.0  0.5  0.5];
    
%Define box size and conventional cell lattice parameters
    NMD.latvec(1,1) = dummy(1,1); NMD.latvec(1,2) = dummy(1,2); 
    NMD.latvec(1,3) = dummy(1,3);
    NMD.latvec(2,1) = dummy(2,1); NMD.latvec(2,2) = dummy(2,2); 
    NMD.latvec(2,3) = dummy(2,3);    
    NMD.latvec(3,1) = dummy(3,1); NMD.latvec(3,2) = dummy(3,2); 
    NMD.latvec(3,3) = dummy(3,3);
    
    NMD.latvec = NMD.alat*NMD.latvec;
    
NMD.latvec_rec = [   1.0 0.0  0.0 
                    0.0  1.0 0.0 
                    0.0  0.0  1.0];
    
%first 3 rows are the lattice vectors
    NMD.x.direct = dummy(4:length(dummy),:);
    
    NMD.x.cart(:,1) = NMD.x.direct(:,1)*NMD.latvec(1,1) +...
        NMD.x.direct(:,2)*NMD.latvec(2,1) +...
        NMD.x.direct(:,3)*NMD.latvec(3,1) ;
	NMD.x.cart(:,2) = NMD.x.direct(:,1)*NMD.latvec(1,2) +...
        NMD.x.direct(:,2)*NMD.latvec(2,2) +...
        NMD.x.direct(:,3)*NMD.latvec(3,2) ;
	NMD.x.cart(:,3) = NMD.x.direct(:,1)*NMD.latvec(1,3) +...
        NMD.x.direct(:,2)*NMD.latvec(2,3) +...
        NMD.x.direct(:,3)*NMD.latvec(3,3) ;

%--------------------------------------------------------------------------

%build supercell
N_cnt = 1;
for iNx = 0:NMD.Nx-1
    for iNy = 0:NMD.Ny-1
        for iNz = 0:NMD.Nz-1
NMD.x0( (N_cnt-1)*size(NMD.x.direct,1)+1:(N_cnt)*size(NMD.x.direct,1) ,3) =...
        NMD.x.cart(:,1) + iNx * NMD.latvec(1,1) +...
            iNy*NMD.latvec(2,1) + iNz*NMD.latvec(3,1); 
NMD.x0( (N_cnt-1)*size(NMD.x.direct,1)+1:(N_cnt)*size(NMD.x.direct,1) ,4) =...
        NMD.x.cart(:,2) + iNx * NMD.latvec(1,2) +...
            iNy*NMD.latvec(2,2) + iNz*NMD.latvec(3,2);
NMD.x0( (N_cnt-1)*size(NMD.x.direct,1)+1:(N_cnt)*size(NMD.x.direct,1) ,5) =...
        NMD.x.cart(:,3) + iNx * NMD.latvec(1,3) +...
            iNy*NMD.latvec(2,3) + iNz*NMD.latvec(3,3);
        N_cnt =N_cnt+1;
        end
    end
end

NMD.NUM_ATOMS = size(NMD.x0,1);


%create kptlist in integers
cnt=1;
for ix=(-(NMD.Nx/2)+1):1:(NMD.Nx/2)
    for iy=(-(NMD.Ny/2)+1):1:(NMD.Ny/2)
        for iz=(-(NMD.Nz/2)+1):1:(NMD.Nz/2)            
        NMD.kpt.integer(cnt,:) = [ix iy iz];
        NMD.kpt.cart(cnt,1:3) = ix/NMD.Nx*NMD.latvec_rec(1,:) +...
            iy/NMD.Ny*NMD.latvec_rec(2,:) +...
            iz/NMD.Nz*NMD.latvec_rec(3,:) ;
        NMD.kpt.NUM_KPTS = cnt;
        cnt=cnt+1;
        end
    end
end
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%INPUT
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------




%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%GULP
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

NMD.kptmaster = bsxfun(@times,NMD.kpt.cart,[NMD.Nx NMD.Ny NMD.Nz]);
NMD.NUM_KPTS = size(NMD.kptmaster(:,1:3),1);
NMD.kptmaster_index = 1:NMD.NUM_KPTS;

%--------------------------------------------------------------------------
%This is required to get the kpt + dk to properly input to GULP
    format long
%--------------------------------------------------------------------------

%Define number of atoms
NMD.NUM_ATOMS =size( NMD.x0,1); NMD.NUM_ATOMS_UCELL = size(NMD.x.cart,1); 
NMD.NUM_UCELL_COPIES=NMD.NUM_ATOMS/NMD.NUM_ATOMS_UCELL; 
NMD.NUM_MODES = 3*NMD.NUM_ATOMS_UCELL;
%Define finite difference increment
		dk = 10E-5;
%--------------------------------------------------------------------------
%-------------------------KPTS---------------------------------------------
%--------------------------------------------------------------------------

if exist(['./' int2str(NMD.seed.alloy) '/eigvec.dat'], 'file')~=0
    system(['rm -f ./' int2str(NMD.seed.alloy) '/eigvec.dat']);
    system(['rm -f ./' int2str(NMD.seed.alloy) '/freq.dat']);
    system(['rm -f ./' int2str(NMD.seed.alloy) '/vel.dat']);
end    

for ikpt=1:size(NMD.kptmaster,1)
    NMD.kptmaster(ikpt,:)           

    kpt = NMD.kptmaster(ikpt,:)./[NMD.Nx NMD.Ny NMD.Nz];

    eigvec =...
        gulp_lj_eig(kpt,...
        NMD.NUM_MODES,NMD.NUM_ATOMS_UCELL,...
        NMD.alat*NMD.LJ.sigma/NMD.constant.ang2m,NMD.vm,NMD.str.main);
    freq =...
        gulp_lj_freq(kpt,...
        NMD.NUM_MODES,NMD.NUM_ATOMS_UCELL,...
        NMD.alat*NMD.LJ.sigma/NMD.constant.ang2m,NMD.vm,NMD.str.main);
    vel =...
        gulp_lj_vel(kpt,...
        NMD.NUM_MODES,NMD.NUM_ATOMS_UCELL,...
        NMD.alat*NMD.LJ.sigma/NMD.constant.ang2m,NMD.vm,NMD.str.main);

%Output formatted eigvec		
    str.write=strcat(NMD.str.main,'/',int2str(NMD.seed.alloy),'/eigvec.dat');
    dlmwrite(str.write,eigvec,'-append','delimiter',' ');
%Output formatted freqs
    str.write=strcat(NMD.str.main,'/',int2str(NMD.seed.alloy),'/freq.dat');
    dlmwrite(str.write,freq,'-append','delimiter',' ');
%Output velocities
    str.write=strcat(NMD.str.main,'/',int2str(NMD.seed.alloy),'/vel.dat');
    dlmwrite(str.write,vel,'-append','delimiter',' ');
    
end

NMD.eigvec =...
    dlmread(strcat(NMD.str.main,'/',int2str(NMD.seed.alloy),'/eigvec.dat'));
NMD.freq =...
    dlmread(strcat(NMD.str.main,'/',int2str(NMD.seed.alloy),'/freq.dat'));
NMD.vel =...
    dlmread(strcat(NMD.str.main,'/',int2str(NMD.seed.alloy),'/vel.dat'));

%--------------------------------------------------------------------------
%pause
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%GULP
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%MATLAB
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------


    
%CREATE PROGRAM FILES------------------------------------------------------   

%KPT LISTS-----------------------------------------------------------------

slice_length = size(NMD.kptmaster,1)/NMD.NUM_KSLICES;
% remainder_length = size(NMD.kptlist,1) - slice_length*(NMD.NUM_KSLICE-1);
for ikslice = 1:NMD.NUM_KSLICES
    NMD.kptlist(:,1:3,ikslice) =...
        NMD.kptmaster( (ikslice-1)*slice_length+1:(ikslice)*slice_length,1:3);
    NMD.kpt_index(:,ikslice) =...
        NMD.kptmaster_index( (ikslice-1)*slice_length+1:(ikslice)*slice_length);
end

%MAKES JOB FILES-----------------------------------------------------------

system(...
    strcat('cp ./NMD_submit.sh.temp ./',int2str(NMD.seed.alloy),'/NMD_submit.sh'));

for iseed=1:size(NMD.seed.initial,2)

    for ikslice = 1:NMD.NUM_KSLICES
%NMD_ISEED_IKSLICE.sh------------------------------------------------------        
        str.orig = 'NMD_temp';
        str.change = ['NMD_' int2str(iseed) '_' int2str(ikslice)];
        str.cmd1 = ['-e ''s/\<' str.orig '\>/' str.change '/g'' '];
        str.orig = 'runpath';
        str.change = strcat(NMD.str.main,'/',int2str(NMD.seed.alloy) );
        str.temp = strcat('-e ''s|',str.orig,'|',str.change);
        str.cmd2 = [str.temp '|g'' '];
        str.orig = 'NMD_TEMP.m';
        str.change = ['NMD_' int2str(iseed) '_' int2str(ikslice) '.m'];
        str.cmd3 = ['-e ''s/\<' str.orig '\>/' str.change '/g'' '];
    str.cmd4 =...
        ['NMD.sh.temp > ./' int2str(NMD.seed.alloy) '/NMD_' int2str(iseed) '_' int2str(ikslice) '.sh'];
    
    
    str.cmd = ['sed ' str.cmd1 str.cmd2 str.cmd3 str.cmd4];
        system(str.cmd);
%NMD_ISEED_IKSLICE.m-------------------------------------------------------        
        str.orig = 'ISEED';
        str.change = [int2str(iseed)];
        str.cmd1 = ['-e ''s/\<' str.orig '\>/' str.change '/g'' '];
        str.orig = 'IKSLICE';
        str.change = [int2str(ikslice)];
        str.cmd2 = ['-e ''s/\<' str.orig '\>/' str.change '/g'' '];
        str.cmd3 = ['NMD.m.temp > ./' int2str(NMD.seed.alloy) '/NMD_' int2str(iseed) '_' int2str(ikslice) '.m'];
        str.cmd = ['sed ' str.cmd1 str.cmd2 str.cmd3];
        system(str.cmd);
%NMD_submit.sh------------------------------------------------------------- 
    output =...
        ['qsub -l walltime=' int2str(NMD.walltime.matlab)...
        ':00:00,nodes=' int2str(NMD.cpu.matlab)...
        ',mem=' int2str(NMD.mem.matlab)...
        'gb NMD_' int2str(iseed) '_' int2str(ikslice) '.sh'];
    
    str.write = strcat(NMD.str.main,'/',int2str(NMD.seed.alloy),'/NMD_submit.sh');
    dlmwrite(str.write,output,'-append','delimiter','');

    end
end


%NMD_grep.m-------------------------------------------------------        
    str.cmd3 = ['NMD.m.temp > ./' int2str(NMD.seed.alloy) '/NMD_' int2str(iseed) '_' int2str(ikslice) '.m'];
    str.cmd = ['sed ' str.cmd1 str.cmd2 str.cmd3];
    system(str.cmd);


system(strcat('cp ./NMD_grep.m.temp ./',int2str(NMD.seed.alloy),'/NMD_grep.m'));

%SAVE NMD structure--------------------------------------------------------  

save(strcat(NMD.str.main,'/',int2str(NMD.seed.alloy),'/NMD.mat'), '-struct', 'NMD');

size(NMD.freq)


% str(1,:) = 'qdel 515042'; cnt=2;
% for i=515042:515121
% str(cnt,:) = ['qdel ' int2str(i)]; cnt = cnt+1;
% end
