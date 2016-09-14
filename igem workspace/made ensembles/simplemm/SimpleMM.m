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
Km1 = load('Kmgox');                    Km1 = Km1.Kfinal ;
Kcat1 = load('kcat(GOX)');              Kcat1 = Kcat1.Kfinal ;
Km2 = load('Km(HRP)');                  Km2 = Km2.Kfinal ;
Kcat2 = load('Kcatf(hrp)');             Kcat2 = Kcat2.Kfinal;
Kconstraints = load('kcatKm(GOX)');     Kconstraints = Kconstraints.Kfinal;

% generating random sample k's and putting them in a matrix km
%km = zeros(4,Iterations);

%{
km(1,:) = randlog_fn(BinNumber,Iterations,Km1);
km(2,:) = randlog_fn(BinNumber,Iterations,Kcat1);
km(3,:) = randlog_fn(BinNumber,Iterations,Km2);
km(4,:) = randlog_fn(BinNumber,Iterations,Kcat2);
%}

km = ConstraintFilter_fn(Km1, Kcat1, Km2, Kcat2, Kconstraints,Iterations, BinNumber);


%part 1.2 input data for experimental concentration graphs
%Texp = [0,2.5,5.81,7.146,10,13,16,17.5,20.5,25,28,31,34,37,40,44.5,49,52,55,60]; 
%Yexp = [0.0001,0.11,0.21,0.24,0.29,0.32,0.34,0.34,0.331,0.30,0.28,0.25,0.22,0.19,0.16,0.12,0.09,0.07,0.06,0.04];

tRange = [1:578]; % set up range for t
yZero = [0,0,83.3333,83.3333,0]; % and an initial condition
yZero(3) = (yZero(3)/34.0147);
yZero(4) = (yZero(4)/44000);
store = zeros(length(tRange), 5, Iterations);
for i = 1:Iterations  
% solve Odes fo given k set
kv = km(:,i);
[myT, myY] = ode45(@(t,Y)RHSsMM(t,Y,kv), tRange, yZero);
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