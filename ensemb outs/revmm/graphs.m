%clear
%clc
load('14-9-2016_MM_(2310).mat')
load('experimental208_simple.mat')
load('experimental.mat')
A = MM.Concentrations;
Texp2 = MM.Time;
temp = size(A);
test = size(MM.Concentrations);
for i = 1:MM.Iterations/100
plot(Texp2,A(:,test(2),i),'g')
hold on
end
temp2 = size(updated);
%b = length(Texp)/temp(2) ;
%for 
%Texp2 = Texp(b);
%end
for j = 1:temp2(1)
plot(Texp,updated(j,:),'r')
hold on
end
title('concentration vs time rev mm');
xlabel('time (s)'); 
ylabel(' concentration (mM) ');
