function [diffx,diffy,diffz,diff] = therm_diff_5(D,eigV,W,PHI1,PHI2,PHI3,V,hbar,epsilon_Ar,tau_Ar,a2,x,x_ucell,m,kappa)
%FUNCTION: find forces acting on all atoms in system.
%update: tried to save Rij and PHI, but that ran out of memory
%update: trying to vectorize everything. version 3 was able to calcualte
%the diff of perfect crystal to be 0, seems like it should be!
%comment: changing that internal loop over alpha beta to 9 separate
%expressions actually SLOWED the calculation down!

%For force constant matrix
   A=size(x);
   N=A(1,1);
   I=sqrt(-1);
   i=sqrt(-1);
%For thermal diffusivity    
%Measure mode diffusivity
diffx(1:length(W)) = 0;
diffy(1:length(W)) = 0;
diffz(1:length(W)) = 0;
diff(1:length(W)) = 0;

hbar2 = hbar*tau_Ar/epsilon_Ar;

%     %Measure average frequency separation     
%     for i1=2:length(W)
%         dw(i1) = abs(W(i1,i1) - W(i1-1,i1-1));
%     end
%     gamma = mean(dw)           %set full-width half max equal to average frequency separation

    delL=10.0;                 %controls accuracy of lorentzian
 
%    facsx = 0.0; facsy = 0.0; facsz = 0.0;
    
    for i1=1:length(W)
        i1
        sij=0.0;
        sijx=0.0;
        sijy=0.0;
        sijz=0.0;
        for i2=1:length(W)
            facsx=0.0;
            facsy=0.0;
            facsz=0.0;
            fac1=0.0;
            fac2x=0.0; fac2y=0.0; fac2z=0.0;
            fac3=0.0;
            fac4=0.0;
            wi = W(i1,i1);
            wj = W(i2,i2);
            %Sum over k and k'
            %sizeR=size(Rij);
            %lor1 = 0.065175777;
            %delw = abs(wi - wj);
            %lor2 = delw^2 + lor1^2;
            %lor = lor1/lor2;
            gamma = abs(wi - wj);
            lor = (1/pi)*(gamma/( (wj-wi)^2 + gamma^2));        %Lorentzian
            %pause
            if i1~=i2 & lor>delL & wi~=0 & wj~=0
                for i3=1:N
                    for i4=1:N
                        eig1 = eigV(1+(i3-1)*3:3*i3,i1);          %kth atom, wi's frequency
                        eig2 = eigV(1+(i4-1)*3:3*i4,i2);          %k'th atom, wj's frequency
                        Dij1 = PHI1( 1+(i3-1)*3:3*i3, 1+(i4-1)*3:3*i4 );
                        Dij2 = PHI2( 1+(i3-1)*3:3*i3, 1+(i4-1)*3:3*i4 );
                        Dij3 = PHI3( 1+(i3-1)*3:3*i3, 1+(i4-1)*3:3*i4 );
                        for i5=1:3
                            for i6=1:3
                                facsx = facsx + eig1(i5)*Dij1(i5,i6)*eig2(i6);
                                facsy = facsy + eig1(i5)*Dij2(i5,i6)*eig2(i6);
                                facsz = facsz + eig1(i5)*Dij3(i5,i6)*eig2(i6);
                            end
                        end
                    end
                end
                con2 = (hbar2)*(wi+wj)/(4*V*sqrt(wi*wj));
                facsx = facsx*con2;
                facsy = facsy*con2;
                facsz = facsz*con2;
            end
            sijx = sijx + (facsx*facsx)*lor;
            sijy = sijy + (facsy*facsy)*lor;
            sijz = sijz + (facsz*facsz)*lor;
            sij = sij + (sijx + sijy + sijz);
        end
        con1 = (pi*V*V)/(3*hbar2*hbar2*wi*wi);
        diffx(i1) = con1*sijx; 
        diffy(i1) = con1*sijy;
        diffz(i1) = con1*sijz; 
        diff(i1) = (diffx(i1) + diffy(i1) + diffz(i1))/3.0;
    end
    
    
    