clear
clc
load('13-9-2016_MM_(1554).mat')
load('experimental208_simple.mat')
A = MM.Concentrations;
Texp2 = MM.Time;
temp = size(A);

for i = 1:MM.Iterations/10
plot(Texp2,A(:,6,i),'g')
hold on
end
temp2 = size(Yexpvec);
%b = length(Texp)/temp(2) ;
%for 
%Texp2 = Texp(b);
%end
for j = 1:temp2(1)
plot(Texp,Yexpvec(j,:),'r')
hold on
end
title('Concentration vs time for different k sets');
xlabel('time (s)'); 
ylabel(' concentration (mM) ');
