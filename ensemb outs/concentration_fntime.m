% concentration for a given time
clear
clc
load('24-8-2016_MM_(955).mat')
A = MM.Concentrations;
Texp = MM.Time;
temp = size(A);    
forhist = [] ; 
timeiteration = ceil(length(Texp)/6) ;
T = Texp(timeiteration); 
% for length of iterations do this
for i = 1:temp(3)
    
stored = A(timeiteration,5,i);
forhist = [forhist, stored];

end

histogram(forhist)
title('Histogram of cocentration of abts after 100s simple michelis mentsen data set 02/08');
xlabel('concentration(mM)'); 
ylabel('number of k sets in bin');
