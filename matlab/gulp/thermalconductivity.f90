  subroutine thermalconductivity(mcv,derv2,eigr,Sij,freq,nphonatc,ncfoc,nphonatptr,maxd2)
!
!  Compute the thermal conductivity in a quasiharmonic supercell approximation
!  according to the method of Allen and Feldman, PRB, 48, 12581 (1993)
!
!   6/12 Created 
!   1/13 JL modified
!   1/13 Loop over Cartesian degrees of freedom added
!
!  Conditions of use:
!
!  GULP is available free of charge to academic institutions
!  and non-commerical establishments only. Copies should be
!  obtained from the author only and should not be distributed
!  in any form by the user to a third party without the express
!  permission of the author. This notice applies to all parts
!  of the program, except any library routines which are
!  distributed with the code for completeness. All rights for
!  such routines remain with the original distributor.
!
!  No claim is made that this program is free from errors and
!  no liability will be accepted for any loss or damage that
!  may result. The user is responsible for checking the validity
!  of their results.
!
!  Copyright Curtin University 2013
!
!  Julian Gale, NRI, Curtin University, January 2013
!
  use current
  use general,        only : bfactor
  use iochannels
  use parallel
  implicit none
!
!  Passed variables
!
  integer(i4), intent(in)                      :: nphonatptr(*)
  integer(i4), intent(in)                      :: maxd2
  integer(i4), intent(in)                      :: mcv
  integer(i4), intent(in)                      :: ncfoc
  integer(i4), intent(in)                      :: nphonatc
  real(dp),    intent(inout)                   :: derv2(maxd2,*)
  real(dp),    intent(in)                      :: eigr(maxd2,*)
  real(dp),    intent(out)                     :: Sij(mcv,*)
  real(dp),    intent(in)                      :: freq(*)
!
!  Local variables
!
  integer(i4)                                  :: i
  integer(i4)                                  :: ii
  integer(i4)                                  :: ind
  integer(i4)                                  :: ix
  integer(i4)                                  :: iy
  integer(i4)                                  :: iz
  integer(i4)                                  :: ixyz
  integer(i4)                                  :: j
  integer(i4)                                  :: jj
  integer(i4)                                  :: jx
  integer(i4)                                  :: jy
  integer(i4)                                  :: jz
  integer(i4)                                  :: ncfoc2
  integer(i4)                                  :: nfreqmin
  integer(i4)                                  :: status
  logical,        allocatable,            save :: ldone(:)
  real(dp)                                     :: constant
  real(dp),       allocatable,            save :: Di(:)
  real(dp)                                     :: Di_loc
  real(dp)                                     :: dwavg
  real(dp)                                     :: dwij
  real(dp)                                     :: dxyz
  real(dp),       allocatable,            save :: freqinv(:)
  real(dp)                                     :: freqsqrt
  real(dp)                                     :: rij
  real(dp)                                     :: xd
  real(dp)                                     :: yd
  real(dp)                                     :: zd
  real(dp),       allocatable,            save :: Vij(:,:)
!
!  Allocate local array ldone to avoid duplicate multiplies in case of partial occupancy
!
  ncfoc2 = ncfoc*(ncfoc+1)/2
  allocate(freqinv(mcv),stat=status)
  if (status/=0) call outofmemory('thermalconductivity','freqinv')
  allocate(ldone(ncfoc2),stat=status)
  if (status/=0) call outofmemory('thermalconductivity','ldone')
  allocate(Di(mcv),stat=status)
  if (status/=0) call outofmemory('thermalconductivity','Di')
  allocate(Vij(mcv,mcv),stat=status)
  if (status/=0) call outofmemory('thermalconductivity','Vij')
!
!  Create inverse frequency factors while trapping translations and imaginary modes
!
  nfreqmin = 0
  do i = 1,mcv
    if (freq(i).gt.1.0_dp) then
      if (nfreqmin.eq.0) nfreqmin = i
      freqinv(i) = 1.0_dp/sqrt(2.0_dp*freq(i))
    else
!
!  If frequency is zero (acoustic mode) or imaginary then set this term to 0 to remove contributions
!
      freqinv(i) = 0.0_dp
    endif
  enddo
!
!  Find mean level spacing
!
  dwavg = 0.0_dp
  do i = nfreqmin,mcv-1
    dwavg = freq(i+1) - freq(i) + dwavg
  enddo
  dwavg = dwavg/(mcv-1 - nfreqmin)
!
  constant = 1.0_dp/12.0_dp    ! 1/3 convoluted with 1/2 squared from A7
!
!  Multiply by large number in order to increase size of Di
!
  constant = 1.0d10/12.0_dp    ! 1/3 convoluted with 1/2 squared from A7
!
!  Initialise thermal conductivities for each mode
!
  Di(1:mcv) = 0.0_dp
!
!  Loop over Cartesian directions
!
  do ixyz = 1,3
!
!  Initialise ldone
!
    ldone(1:ncfoc2) = .false.
!
!  Initialise Vij
!
    Vij(1:mcv,1:mcv) = 0.0_dp
!
!  Scale dynamical matrix elements by minimum image nearest distance between sites
!
    do i = 1,nphonatc
      ii = nphonatptr(i)
      ix = 3*ii - 2
      iy = ix + 1
      iz = ix + 2
      do j = 1,i-1
        jj = nphonatptr(j)
        ind = ii*(ii-1)/2 + jj
        if (.not.ldone(ind)) then
          jx = 3*jj - 2
          jy = jx + 1
          jz = jx + 2
!
!  Compute initial vector
!
          xd = xclat(jj) - xclat(ii)
          yd = yclat(jj) - yclat(ii)
          zd = zclat(jj) - zclat(ii)
!
!  Find minimum distance between images
!
          call nearestr(ndim,xd,yd,zd,rv,rij)
          if (ixyz.eq.1) then
            dxyz = xd
          elseif (ixyz.eq.2) then
            dxyz = yd
          else
            dxyz = zd
          endif
!  
          Vij(jx,ix) = derv2(jx,ix)*dxyz
          Vij(jy,ix) = derv2(jy,ix)*dxyz
          Vij(jz,ix) = derv2(jz,ix)*dxyz
          Vij(jx,iy) = derv2(jx,iy)*dxyz
          Vij(jy,iy) = derv2(jy,iy)*dxyz
          Vij(jz,iy) = derv2(jz,iy)*dxyz
          Vij(jx,iz) = derv2(jx,iz)*dxyz
          Vij(jy,iz) = derv2(jy,iz)*dxyz
          Vij(jz,iz) = derv2(jz,iz)*dxyz
!  
          Vij(ix,jx) = - derv2(ix,jx)*dxyz
          Vij(iy,jx) = - derv2(iy,jx)*dxyz
          Vij(iz,jx) = - derv2(iz,jx)*dxyz
          Vij(ix,jy) = - derv2(ix,jy)*dxyz
          Vij(iy,jy) = - derv2(iy,jy)*dxyz
          Vij(iz,jy) = - derv2(iz,jy)*dxyz
          Vij(ix,jz) = - derv2(ix,jz)*dxyz
          Vij(iy,jz) = - derv2(iy,jz)*dxyz
          Vij(iz,jz) = - derv2(iz,jz)*dxyz
          ldone(ind) = .true.
        endif
      enddo
!
!  Self term is zero
!
      Vij(ix,ix) = 0.0_dp
      Vij(iy,ix) = 0.0_dp
      Vij(iz,ix) = 0.0_dp
      Vij(ix,iy) = 0.0_dp
      Vij(iy,iy) = 0.0_dp
      Vij(iz,iy) = 0.0_dp
      Vij(ix,iz) = 0.0_dp
      Vij(iy,iz) = 0.0_dp
      Vij(iz,iz) = 0.0_dp
    enddo
!
!  Multiply eigenvectors by distance weighted dynamical matrix from both sides
!
    call dgemm('N','N',mcv,mcv,mcv,1.0_dp,Vij,mcv,eigr,maxd2,0.0_dp,Sij,mcv)
    call dgemm('T','N',mcv,mcv,mcv,1.0_dp,eigr,maxd2,Sij,mcv,0.0_dp,Vij,mcv)
!
!  Copy results back to Sij
!
    Sij(1:mcv,1:mcv) = Vij(1:mcv,1:mcv)
!
!  Scale by constants and frequency factors to get to Sij
!
    do i = 1,mcv
      do j = 1,mcv
        freqsqrt = sqrt(freqinv(i)*freqinv(j))
        Sij(j,i) = Sij(j,i)*freqsqrt*(freq(i) + freq(j))
      enddo
    enddo
!
!  Compute Di values (factors of pi have been cancelled)
!
    do i = nfreqmin,mcv
      Di_loc = 0.0_dp
!
!  Sum over coupling with mode j weighted by Lorentzian factor
!
      do j = nfreqmin,i-1
        dwij = (1.0/pi)*(bfactor*dwavg)/( (freq(j) - freq(i))**2 + (bfactor*dwavg)**2 )
        Di_loc = Di_loc + dwij*Sij(j,i)**2
      enddo
      do j = i+1,mcv
        dwij = (1.0/pi)*(bfactor*dwavg)/( (freq(j) - freq(i))**2 + (bfactor*dwavg)**2 )
        Di_loc = Di_loc + dwij*Sij(j,i)**2
      enddo
!
!  Scale by constants and inverse frequency squared - factor of third is for averaging over directions
!
      Di(i) = Di(i) + Di_loc*constant/(3.0_dp*freq(i)**2)
    enddo
!
!  End loop over Cartesian degrees of freedom
!
  enddo
!
!  Output banner for thermal conductivity
!
  if (ioproc) then
    write(ioout,'(/,''  Thermal conductivity: '',/)')
    write(ioout,'(''  Lorentzian broadening factor = '',f10.4,/)') bfactor*dwavg
    write(ioout,'(''--------------------------------------------------------------------------------'')')
    write(ioout,'('' Mode    : Frequency (cm-1)         Thermal conductivity                        '')')
    write(ioout,'(''--------------------------------------------------------------------------------'')')
  endif
!
!  Compute Di values (factors of pi have been cancelled)
!
  if (ioproc) then
    do i = nfreqmin,mcv
      write(ioout,'(i6,2x,f12.4,10x,f18.8)') i,freq(i),Di(i)
    enddo
  endif
!
!  Close output
!
  if (ioproc) then
    write(ioout,'(''--------------------------------------------------------------------------------'',/)')
  endif
!
!  Deallocate local memory
!
  deallocate(Vij,stat=status)
  if (status/=0) call deallocate_error('thermalconductivity','Vij')
  deallocate(Di,stat=status)
  if (status/=0) call deallocate_error('thermalconductivity','Di')
  deallocate(ldone,stat=status)
  if (status/=0) call deallocate_error('thermalconductivity','ldone')
  deallocate(freqinv,stat=status)
  if (status/=0) call deallocate_error('thermalconductivity','freqinv')
!
  return
  end