%Define Boltzmann's constant
%kb = 8.6170e-005; %in eV/K
kb = 1.380e-23;  %in J/K
ps=10^-12;
%evToj=1.6022*10^(-19);
%psTos=10^(-12);
%angTom=10^(-10);
mass_Ar=6.63*10^(-26); eps_Ar=1.67*10^(-21); sigma_Ar=3.4*10^(-10); tau_Ar=2.1423*10^(-12);
%Calculate cut-off frequency for filtering
step_size = 0.002; sample_rate = 10;
dt = step_size*tau_Ar;
%sample freq: this should be 2 Thz
%f = 1/dt;
%calculate filter mask: use 0.2 THz as a guess for now
%fNorm = 0.1 / (f/2);
%[b,a] = butter(10, fNorm, 'low');

%Calcaulte scale factor for J
scaleJ = (eps_Ar)/((sigma_Ar^2)*tau_Ar);

%4_1
%Tset = [2.5,5,10];
%volset = [238.7981562*(sigma_Ar^3),241.0972632*(sigma_Ar^3),244.3238251*(sigma_Ar^3)];

%4_1
%Tset = [0.020667665*(eps_Ar/kb),0.062002994*(eps_Ar/kb),0.165341317*(eps_Ar/kb),0.578694611*(eps_Ar/kb)];
%Tset = [2.5,5,10,40];
%volset = [238.8799504*(sigma_Ar^3),239.5845821*(sigma_Ar^3),244.2849211*(sigma_Ar^3),266.5284171*(sigma_Ar^3)];

%6_9
%volset = [808.4036758*(sigma_Ar^3),813.4714082*(sigma_Ar^3),825.7505925*(sigma_Ar^3)];

%8
Tset = [2.5,5,10];
%0.01 
%volset = [1910.707205*(sigma_Ar^3),1916.696293*(sigma_Ar^3),1928.700487*(sigma_Ar^3)];%,1957.018904*(sigma_Ar^3)];
%0.05
%volset = [1910.602102*(sigma_Ar^3),1916.411468*(sigma_Ar^3),1929.640203*(sigma_Ar^3)];%,1957.018904*(sigma_Ar^3)];
%0.1
%volset = [1910.615336*(sigma_Ar^3),1916.502625*(sigma_Ar^3),1929.495341*(sigma_Ar^3)];%,1957.018904*(sigma_Ar^3)];
%0.5
%volset = [1910.640368*(sigma_Ar^3),1916.378615*(sigma_Ar^3),1928.662301*(sigma_Ar^3)];%,1957.018904*(sigma_Ar^3)];
%0.9
volset = [1910.698183*(sigma_Ar^3),1916.353575*(sigma_Ar^3),1929.565379*(sigma_Ar^3)];%,1957.018904*(sigma_Ar^3)];


%12
%Tset = [2.5,5,10];
%volset = [6448.62065*(sigma_Ar^3),6468.064043*(sigma_Ar^3),6509.734834*(sigma_Ar^3)];%,1957.018904*(sigma_Ar^3)];



num_run=1;
num_runs=10;
runs=[1,2,3,4,5,6,7,8,9,10];
t_limit=20000;

for i2=1:length(Tset)
                T = Tset(i2);
                volume = volset(i2);
            for i1=1:num_runs
                str_main=strcat('E:\CMU\work\Phonons\LJArgon\Solid\crystal\alloy\m3\0.95\');
                   str=strcat(str_main,'J0Jt_',int2str(i1),'_',int2str(i2),'_grep.dat');
                   A=dlmread(str);
                   if i1==1
                   JJ(1:length(A)-1,1:2)=0;
                   end
                   JJ(:,1) = A(2:length(A),2)*dt;
                   JJ(:,2) = JJ(:,2) + (A(2:length(A),4)+A(2:length(A),5)+A(2:length(A),6))/3;  %Jx
            end
            JJ(:,2) = JJ(:,2)/num_runs;
            JJ(:,2) = JJ(:,2)*(scaleJ^2);

            %JJ2(:,1) = JJ(1:100:t_limit,1);
            %JJ2(:,2) = JJ(1:100:t_limit,2);
            
            start = input('Enter time limit: ');
            
            cnt=1;
            for i3=2:100:t_limit;
            Z(cnt,2) = trapz(JJ(1:i3,1),JJ(1:i3,2));
            Z(cnt,1) = JJ(i3,1);
            cnt=cnt+1;
            end
            
%            pause

            k(:,2) = Z(:,2)*(volume/(kb*(T^2)));
            JJ(:,1) = JJ(:,1)/ps;
            k(:,1) = Z(:,1)/ps;

            num_to_plot=t_limit;
            
%            pause

            %subplot(2,1,1), plot(JJ(1:t_limit,1),JJ(1:t_limit,2)/JJ(1,2));
            %plot(JJ(1:t_limit,1),JJ(1:t_limit,2)/JJ(1,2));
            %axis([0 max(JJ(1:1000,1)) min((JJ(1:1000,2)/JJ(1,2))) 1]);
             %   title(strcat('T = 10K'),'FontSize',24);
             %   xlabel('t (ps)','FontSize',24); 
             %   ylabel('\langle S(t)S(0) \rangle/\langle S(0)S(0) \rangle' ,'FontSize',24);
            %[I,J,V] = find(k~=0); k2(:,1) = k(I,1); k2(:,2) = k(I,2);
            %subplot(2,1,2), plot(1:length(k2),k2);
            plot(1:length(k),k(:,2),'.');
            %axis([0 max(JJ(1:1000,1)) 0 max(k)+0.5]);
                xlabel('t (ps)','FontSize',24); 
                ylabel('\kappa (W/m-K)' ,'FontSize',24);
                length(k)
                start = input('start ');
                stop = input('stop ');
               

            kappa(i2,1) = Tset(i2);

            kappa(i2,2) = mean(k(start:stop,2));
            
            kappa(i2,3) = std(k(start:stop,2));

            str=strcat(str_main,'JJ_',int2str(i2),'.dat');
            dlmwrite(str,JJ);
            str=strcat(str_main,'kappa_',int2str(i2),'.dat');
            dlmwrite(str,k);
            
            clear JJ JJ2 A Z k

end

            str=strcat(str_main,'kappa(T).dat');
            dlmwrite(str,kappa);
            
            errorbar(kappa(:,1),kappa(:,2),kappa(:,3))
