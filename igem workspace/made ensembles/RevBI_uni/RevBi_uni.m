%Main script.
%Calls other functions etc

% clean slate protocol
clc
clear

%Part 1.1 - Initialise K values
tic
Iterations = 1000; % number of k values created.
BinNumber = 200;
%input data from brenda and create array of random k's sampled from a log
%normal distribution

%inputing raw k's
Temprange = 292:304;
R = 1.987; %cal/mole K
kcatf1 = load('kcat(GOX)');              kcatf1 = kcatf1.Kfinal ;
km1s1 = load('Kmgox');                    km1s1 = km1s1.Kfinal ;
keq1 = exp(33.660004./(R.*Temprange)) ;       %-140833.456736 joules mole
km1p1 = km1s1; % kmp was missing so assumed equal like alliah recommended
kcatf2 = load('Kcatf(hrp)');             kcatf2 = kcatf2.Kfinal;
km1s2 = load('Km(HRP)');                  km1s2 = km1s2.Kfinal ;
km2s2 = km1s2; 
keq2 = exp(60.831757./(R.*Temprange)) ; %Keq2 = Keq2.Kfinal; 
km1p2 = load('Kmp(HRP)');                 km1p2 = km1p2.Kfinal ; 
%Kcatb2 = load('Kcatb(HRP)');             Kcat2b = Kcat2b.Kfinal; %-60.831757 kcal/mol
Kconstraints = exp(60.831757e3./(R.*Temprange));


% generating random sample k's and putting them in a matrix km
% km = zeros(4,Iterations);


Kstruct = struct('kcatf1',kcatf1,'km1s1',km1s1,'keq1',keq1,'km1p1',km1p1,'kcatf2',kcatf2,'km1s2',km1s2,'km2s2',km2s2,'keq2',keq2,'km1p2',km1p2);

km = ConstraintFilter_fn(Kstruct, Kconstraints ,Iterations, BinNumber);


%part 1.2 input data for experimental concentration graphs
Texp = [0,2.5,5.81,7.146,10,13,16,17.5,20.5,25,28,31,34,37,40,44.5,49,52,55,60]; 
Yexp = [0.0001,0.11,0.21,0.24,0.29,0.32,0.34,0.34,0.331,0.30,0.28,0.25,0.22,0.19,0.16,0.12,0.09,0.07,0.06,0.04];

tRange = [1:578]; % set up range for t
yZero = [0.00001,0.000001,83.333,83.333,10,0.00001]; % and an initial condition
yZero(3) = (yZero(3)/34.0147);
yZero(4) = (yZero(4)/44000);
yZero(5) = (yZero(5)/548.7) ;
store = zeros(length(tRange), 6, Iterations);
for i = 1:Iterations  
% solve Odes fo given k set
kv = km(:,i);
[myT, myY] = ode45(@(t,Y)RHSRevBi_uni(t,Y,kv), tRange, yZero);
store(:,:,i) = myY(:,:);
end
MM = struct('Time', myT, 'Concentrations', store, 'InitialConcentrations', yZero, 'Iterations', Iterations, 'Ks', km);

c = clock;
year = num2str(c(1));
month = num2str(c(2));
day = num2str(c(3));
hour = num2str(c(4));
minute = num2str(c(5));

title = [day,'-',month,'-',year,'_','MM','_','(',hour, minute,')']; 
save(title,'MM')
toc