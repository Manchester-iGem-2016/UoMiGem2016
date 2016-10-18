clear
clc
load('16-10-2016_MM_(2052).mat')
load('experimental208_simple.mat')
load('final.mat')
A = MM.Concentrations;
Texp2 = MM.Time;
temp = size(A);

for i = 1:MM.Iterations/100
plot(Texp2,A(:,7,i),'g')
hold on
end
temp2 = size(Yexpvec);
temp3 = size(final);
%b = length(Texp)/temp(2) ;
%for 
%Texp2 = Texp(b);
%end
final = final(:,4:temp3(2));
Texp2 = zeros(1,length(final));
%{
for m = 1:length(Texp2)
    Texp2(m) = 2*m;
end    
for j = 12:18
plot(Texp2,final(j,:),'r')
hold on
end
%}
title('Concentration vs time for different k sets plotted against experimental data');
xlabel('time (s)'); 
ylabel(' concentration (mM) ');
%annotation('glucose used in model was 1.6 ug/ml, glucose experimentally is 1.75 and 1.5 ug/ml',[x y w h])
