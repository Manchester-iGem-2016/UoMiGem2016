clear
clc

%code to find beers law taking into acount the other things 
%in solution and then optimizing for the best straightline fit
%to take into account that the abts is allready part oxidised.
%i.e shift to zero after removing effects from all the other reagents

% step 1 - read in data ov....
filename = 'samples.xlsx' ;

S714 = xlsread(filename) ; 
[r1,c1] = size(S714);
% put in a test to find decay point and stuff
texp = S714(1,4:c1);
% steady state absorbances

    S0 = S714(2:r1,c1);
    S1 = S714(2:r1,c1-1);
    S2 = S714(2:r1,c1-2);
    S3 = S714(2:r1,c1-3);
    S4 = S714(2:r1,c1-4);
    S5 = S714(2:r1,c1-5);
    S6 = S714(2:r1,c1-6);
    
    %get there mean to reduce error note steady state flucs so mean is good 
    ABSO = (S0 + S1 + S2 + S3 + S4 + S5 + S6)/7 ;


    concABTSOX = S714(2:r1,1); % in ug/ml
    % but whats important is amount of particles for consistency with codes.
    % therefore must divide by mr abts
    concABTSOX = concABTSOX/548.7; % now in mM
    
    % to do 
    % take into account decay
    % take into account non zero
    % take into account varying concentrations
    
    scatter(concABTSOX,ABSO,'r');
    P1 = polyfit(concABTSOX,ABSO,1);
    absofit = P1(1)*concABTSOX+P1(2);
    hold on;
    plot(concABTSOX,absofit,'r-.');
    
    updated = (S714 - P1(2))./P1(1);
    
    save('experimental.mat','texp','updated')
    
    
    
    
    
    
    
