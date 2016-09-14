%Main script.
% solves our system using simple michealis mentsen for both steps
% see the wiki for what this corresponds to logically
% clean slate protocol
clc
clear
%
%Part 1.1 - Initialise K values
tic % tic toc measures run time
Iterations = 1000; % number of k values created.
BinNumber = 200;
%input data from brenda and create array of random k's sampled from a log
%normal distribution

%inputing raw k's
Km1 = load('Kmgox');                    Km1 = Km1.Kfinal ;
Kcat1 = load('kcat(GOX)');              Kcat1 = Kcat1.Kfinal ;
Km2 = load('Km(HRP)');                  Km2 = Km2.Kfinal ;
Kcat2 = load('Kcatf(hrp)');             Kcat2 = Kcat2.Kfinal;
Kconstraints = load('kcatKm(GOX)');     Kconstraints = Kconstraints.Kfinal;

km = ConstraintFilter_fn(Km1, Kcat1, Km2, Kcat2, Kconstraints,Iterations, BinNumber);
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
[myT, myY] = ode45(@(t,Y)RHSsMM(t,Y,kv), tRange, yZero); 
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
