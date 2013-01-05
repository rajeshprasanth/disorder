function [Diff,S] = therm_diff_2(D,eigV,W,Rij,V,hbar,epsilon_Ar,tau_Ar,a2,x,x_ucell,m,kappa)
%FUNCTION: find forces acting on all atoms in system.

%For force constant matrix
   A=size(x);
   N=A(1,1);
   I=sqrt(-1);
   i=sqrt(-1);
   Phi(1:3,1:3)=0;
   D( 1:3*N, 1:3*N ) = 0;
   cnt=0;
%For thermal diffusivity    
    S(1:length(W),1:length(W))=0;
    vij(1:length(W),1:length(W),1:3)=0;

    
    for i1=1:length(W)
        for i2=1:length(W)
            wi = W(i1,i1);
            wj = W(i2,i2);
            %Sum over k and k'
            sizeR=size(Rij);
            for i3=1:N
                for i4=1:N
                    eig1 = eigV(1+(i3-1):i3+2,i1);          %kth atom, wi's frequency
                    eig2 = eigV(1+(i4-1):i4+2,i2);          %k'th atom, wj's frequency
                    clear rij Dij
                    
                    for i5=1:Rij(i3,i4,1,1)
                        
                        rij(1,1:3) = Rij(i3,i4,i5+1,1:3);
                        %Dij = PHI(1+(i3-1)*3:3*i3, 1+(i4-1)*3:3*i4,  i5);  
                        r2 = rij(1,1)^2 + rij(1,2)^2 + rij(1,3)^2;
                        [Dij] = make_force_matrix_2(r2,rij,rij);
                        
                        for i5=1:3
                            for i6=1:3
                                vij(i1,i2,1) = vij(i1,i2,1) + eig1(i5)*Dij(i5,i6)*rij(1,1)*eig2(i6);
                                vij(i1,i2,2) = vij(i1,i2,2) + eig1(i5)*Dij(i5,i6)*rij(1,2)*eig2(i6);
                                vij(i1,i2,3) = vij(i1,i2,3) + eig1(i5)*Dij(i5,i6)*rij(1,3)*eig2(i6);
                            end
                        end
                    end
                end
            end
            vij(i1,i2,1:3) = vij(i1,i2,1:3)*(i/(2*sqrt(wi*wj)));
            S(i1,i2,1:3) = ((hbar*tau_Ar/epsilon_Ar)/(2*V))*vij(i1,i2,1:3)*(wi+wj);
        end
    end
    
    
    
 
   
%Measure average frequency separation    
    
    for i1=2:length(W)
        dw(i1) = W(i1,i1) - W(i1-1,i1-1);
    end
    gamma = mean(dw);           %set full-width half max equal to average frequency separation
    
%Measure mode diffusivity

Diff(1:length(W),1:2) = 0;
    for i1=1:length(W)
        wi = W(i1,i1);
        for i2=1:length(W)
            wj = W(i2,i2);
            lor(i2) = (1/pi)*(gamma/( (wj-wi)^2 + gamma^2));        %Lorentzian
            Diff(i1,2) = Diff(i1,2) + (sqrt(S(i1,i2,1)^2+S(i1,i2,2)^2+S(i1,i2,3)^2)^2)*lor(i2);
        end
        Diff(i1,1) = wi;
        Diff(i1,2) = Diff(i1,2)*((pi*V^2)/(3* ((hbar*tau_Ar/epsilon_Ar)^2)*wi^2));
    end
            
        
        
    
    
    