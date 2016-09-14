%Main script.
%Calls other functions etc

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
Temprange = 292:304;
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
Kconstraints = exp(60.831757e3./(R.*Temprange));


% generating random sample k's and putting them in a matrix km
% km = zeros(4,Iterations);


Kstruct = struct('Km1s1',Km1s1,'Km1p1',Km1p1,'Kcatf1',Kcatf1,'Keq1',Keq1,'Km1s2',Km1s2,'Km1p2',Km1p2,'Kcatf2',Kcatf2,'Keq2',Keq2);

km = ConstraintFilter_fn(Kstruct, Kconstraints ,Iterations, BinNumber);


%part 1.2 input data for experimental concentration graphs
Texp = [0,2.5,5.81,7.146,10,13,16,17.5,20.5,25,28,31,34,37,40,44.5,49,52,55,60]; 
Yexp = [0.0001,0.11,0.21,0.24,0.29,0.32,0.34,0.34,0.331,0.30,0.28,0.25,0.22,0.19,0.16,0.12,0.09,0.07,0.06,0.04];

tRange = [1:57800]; % set up range for t
yZero = [0.00001,0.000001,83.333,83.333,0.00001]; % and an initial condition
yZero(3) = (yZero(3)/34.0147);
yZero(4) = (yZero(4)/44000);
store = zeros(length(tRange), 5, Iterations);
for i = 1:Iterations  
% solve Odes fo given k set
kv = km(:,i);
[myT, myY] = ode45(@(t,Y)RHSrMM(t,Y,kv), tRange, yZero);
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