clear
clc
load('14-9-2016_MM_(2345).mat')
A = MM.Concentrations;
Texp = MM.Time;
temp = size(A);    
forhist = [] ; 
for i = 1:temp(3)
z = A(:,5,i);

offon = 1;
    for j = 1:floor(0.9*length(z))   
    value = z(j);
    value2 = sum(z(j:(j+ceil(0.01*length(z)))))/(1+ceil(0.01*length(z)));
    value3 = sum(z(j:(j+ceil(0.05*length(z)))))/(1+ceil(0.05*length(z)));
    value4 = sum(z(j:(j+ceil(0.1*length(z)))))/(1+ceil(0.1*length(z)));
        if offon == 1
            if abs(value - value2) < 0.05*value && abs(value - value3) < 0.05*value && abs(value - value4) < 0.05*value  
                forhist = [forhist,round(j)];
                offon = 0 ;
            end    
        end 
    end
end

histogram(forhist);

title('time to reach steady state for uni bi bi uni');
xlabel('time taken to reach steady state (s)'); 
ylabel('number of k sets in bin');






