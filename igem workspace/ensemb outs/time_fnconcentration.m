% time for a given concentratiom
clear
clc
load('24-8-2016_MM_(955).mat')
A = MM.Concentrations;
Texp = MM.Time;
iterations = MM.Iterations;
temp = size(A);    
forhist = [] ; 
stored = zeros(iterations,1);
for i = 1:iterations
concentration = 1;
temp2 = A(:,5,i);
temp3 = length(temp2);
passes = temp2(temp2>concentration);
temp4 = length(passes);
stored(i) = Texp(temp3-temp4);
end

histogram(stored)
title('Histogram of cocentration of 1mM abts after 100s simple michelis mentsen data set 02/08');
xlabel('time(s)'); 
ylabel('number of k sets in bin');





