function [ Kfinal ] = ConstraintFilter_fn(Km1, Kcat1, Km2, Kcat2, Kconstraints, Iterations, BinNumber)
%Function to generate and filter K values based on constraints
%   Takes an input of raw K values and the constraints and returns a number
%   of K's which pass the constraints
FractionSample = 0.5;
Kfinal = [];
while length(Kfinal) < Iterations % so while less than required number of iterations look for more
km(1,:) = randlog_fn(BinNumber,round(FractionSample*Iterations),Km1);
km(2,:) = randlog_fn(BinNumber,round(FractionSample*Iterations),Kcat1);
km(3,:) = randlog_fn(BinNumber,round(FractionSample*Iterations),Km2);
km(4,:) = randlog_fn(BinNumber,round(FractionSample*Iterations),Kcat2);
constraint = randlogconstraint_fn(BinNumber, round(FractionSample*Iterations), Kconstraints);
% created lognormal distributions for all perameters and constraints (constraint returns 2 points per constraint soo high and too low.
%test if km within constraint and if so save it
    for i = 1:length(km)
       if  km(2,i)/km(1,i) <= constraint(1,i) && km(2,i)/km(1,i) >= constraint(2,i)
           Kfinal = [Kfinal, km(:,i)];
           %disp(length(Kfinal));
       end
    end
end
if length(Kfinal) > Iterations
    Kfinal(:,Iterations+1:length(Kfinal)) = [];
end
