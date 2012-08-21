% %amorphous
% AF.eigvec = load('/home/jason/lammps/LJ/amorphous/8x/prepare/eigvec_1.dat');
% AF.x0 = load('/home/jason/lammps/LJ/amorphous/8x/prepare/LJ_amor_1.pos');

%alloy
AF.eigvec = load('/home/jason/lammps/LJ/alloy/10K/0.5/8x/NMD_AF/AF_eigvec_1.dat');
AF.x0 = load('/home/jason/lammps/LJ/alloy/10K/0.5/8x/NMD_AF/x0_0.5_1.data');

AF.NUM_ATOMS = AF.x0(1,1); AF.NUM_ATOMS_UCELL = AF.x0(1,2); 
AF.Lx = AF.x0(1,3); AF.Ly = AF.x0(1,4); AF.Lz = AF.x0(1,5);
AF.VOLUME = AF.Lx*AF.Ly*AF.Lz; AF.dr = (AF.VOLUME/AF.NUM_ATOMS)^(1/3);

AF.x0 = AF.x0(2:size(AF.x0,1),:);

for imode = 2000:size(AF.eigvec,1)
quiver3(...
    AF.x0(:,3),AF.x0(:,4),AF.x0(:,5),...
    AF.eigvec(1:3:size(AF.eigvec,1),imode),...
    AF.eigvec(2:3:size(AF.eigvec,1),imode),...
    AF.eigvec(3:3:size(AF.eigvec,1),imode)     )
[XI,YI,ZI] =...
    meshgrid(AF.dr:AF.dr:AF.Lx, AF.dr:AF.dr:AF.Ly, AF.dr:AF.dr:AF.Lz);
VX =...
    griddata3(...
    AF.x0(:,3),AF.x0(:,4),AF.x0(:,5),...
    AF.eigvec(1:3:size(AF.eigvec,1),imode),...
    XI,YI,ZI);
VY =...
    griddata3(...
    AF.x0(:,3),AF.x0(:,4),AF.x0(:,5),...
    AF.eigvec(2:3:size(AF.eigvec,1),imode),...
    XI,YI,ZI);
VZ =...
    griddata3(...
    AF.x0(:,3),AF.x0(:,4),AF.x0(:,5),...
    AF.eigvec(3:3:size(AF.eigvec,1),imode),...
    XI,YI,ZI);
quiver3(    XI,YI,ZI,  VX , VY, VZ   )
imode
%--------------------------------------------------------------------------
pause
%--------------------------------------------------------------------------
end



