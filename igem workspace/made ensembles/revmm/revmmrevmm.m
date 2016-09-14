%Main script.
% solves our system using reversible michealis mentsen for both steps
% see the wiki for what this corresponds to logically
% clean slate protocol
clc
clear
 
%Part 1.1 - Initialise K values
tic
Iterations = 100; % number of k values created.
BinNumber = 200;
%input data from brenda and create array of random k's sampled from a log
%normal distribution

%inputing raw k's
Temprange = 292:304; % temperature range to use for variation in Keq represenatative of global fluctuations.
R = 1.987; %cal/mole K

Km1s1 = load('Kmgox');                    Km1s1 = Km1s1.Kfinal ;
Km1p1 = Km1s1; % kmp was missing so assumed equal like alliah recommended
Kcatf1 = load('kcat(GOX)');              Kcatf1 = Kcatf1.Kfinal ;
Keq1 = exp(33.660004./(R.*Temprange)) ;       %-140833.456736 joules mole
Km1s2 = load('Km(HRP)');                  Km1s2 = Km1s2.Kfinal ;
Km1p2 = load('Kmp(HRP)');                 Km1p2 = Km1p2.Kfinal ; 
Kcatf2 = load('Kcatf(hrp)');             Kcatf2 = Kcatf2.Kfinal;
%Kcatb2 = load('Kcatb(HRP)');             Kcat2b = Kcat2b.Kfinal; %-60.831757 kcal/mol
Keq2 = exp(60.831757./(R.*Temprange)) ; %Keq2 = Keq2.Kfinal; 
Kconstraints = exp(60.831757e3./(R.*Temprange)); % left in for adding constarints in future


Kstruct = struct('Km1s1',Km1s1,'Km1p1',Km1p1,'Kcatf1',Kcatf1,'Keq1',Keq1,'Km1s2',Km1s2,'Km1p2',Km1p2,'Kcatf2',Kcatf2,'Keq2',Keq2);
% using a struct to write out variables fo neatness in following function
km = ConstraintFilter_fn(Kstruct, Kconstraints ,Iterations, BinNumber);
% This function creates our log normal distributions for our parameters using only values that are consistent with constraints
tRange = [1:578]; % set up range for t in seconds
yZero = [0.00001,0.00001,83.3333,83.3333,0.00001]; % and an initial condition units ug/ml % the 0.00001's are to stop division by 0
% these correspond to alcohol,AOX,H2O2,HRP,ABTS(oxidised)
%the units where in ug/ml, but what matters is the number of particles per volume
% so want e.g. mol/ml. 
% Mr's glucose set  g/mol  
Mr = [180,150000,34,44000,514] ; 
% Mr's alcohol set  g/mol
%Mr = [46,450000,34,44000,514] ; 
% so divide ic's by mr's and get umol/ml = mmol/litre = mM
for i = 1:length(Mr)
yZero(i) = (yZero(i)/Mr(i)); 
end
store = zeros(length(tRange), length(yZero), Iterations); % matrix to store concentrations over time from ode solve
for i = 1:Iterations  
% solve Odes fo given k set
kv = km(:,i); % extract a k set
[myT, myY] = ode45(@(t,Y)RHSrMM(t,Y,kv), tRange, yZero);
store(:,:,i) = myY(:,:); % store concentrations and time for each iteration
end
MM = struct('Time', myT, 'Concentrations', store, 'InitialConcentrations', yZero, 'Iterations', Iterations, 'Ks', km);
% save all important variables in a struct for use elsewhere
c = clock;
year = num2str(c(1));
month = num2str(c(2));
day = num2str(c(3));
hour = num2str(c(4));
minute = num2str(c(5));

title = [day,'-',month,'-',year,'_','MM','_','(',hour, minute,')']; 
save(title,'MM')
% save with file name title = date and time for ease. 
toc
