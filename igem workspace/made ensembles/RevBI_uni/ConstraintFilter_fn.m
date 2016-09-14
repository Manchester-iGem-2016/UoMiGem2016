function [ Kfinal ] = ConstraintFilter_fn(Kstruct ,Kconstraints, Iterations, BinNumber)
%Function to generate and filter K values based on constraints
%   Takes an input of raw K values and the constraints and returns a number
%   of K's which pass the constraints

FractionSample = 0.5;
Kfinal = [];
while length(Kfinal) < Iterations
K(1,:) = randlog_fn(BinNumber,round(FractionSample*Iterations),Kstruct.kcatf1);
K(2,:) = randlog_fn(BinNumber,round(FractionSample*Iterations),Kstruct.km1s1);
K(3,:) = randlog_fn(BinNumber,round(FractionSample*Iterations),Kstruct.keq1);
K(4,:) = randlog_fn(BinNumber,round(FractionSample*Iterations),Kstruct.km1p1);
K(5,:) = randlog_fn(BinNumber,round(FractionSample*Iterations),Kstruct.kcatf2);
K(6,:) = randlog_fn(BinNumber,round(FractionSample*Iterations),Kstruct.km1s2);
K(7,:) = randlog_fn(BinNumber,round(FractionSample*Iterations),Kstruct.km2s2);
K(8,:) = randlog_fn(BinNumber,round(FractionSample*Iterations),Kstruct.keq2);
K(9,:) = randlog_fn(BinNumber,round(FractionSample*Iterations),Kstruct.km1p2);

%constraint = randlogconstraint_fn(BinNumber, round(FractionSample*Iterations), Kconstraints);
% created lognormal distributions for all perameters and constraints (constraint returns 2 points per constraint soo high and too low.
% all left in for future reference

%Kcatf1 = K(7,:);
%Kcatb2 = K(8,:);
%Kms2 = K(5,:);
%Kmp2 = K(6,:);
%HaldaneEq = (Kcatf1./Kcatb2).*(Kmp2./Kms2);     %Haldane relationship
    for i = 1:length(K)
  %     if  HaldaneEq(i) <= constraint(1,i) && HaldaneEq(i) >= constraint(2,i)
           Kfinal = [Kfinal, K(:,i)];
    %       disp(length(Kfinal));
     %  end
    end
end
if length(Kfinal) > Iterations
    Kfinal(:,Iterations+1:length(Kfinal)) = [];
end
