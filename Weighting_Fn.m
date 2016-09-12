function [Kfinal] = Weighting_Fn(K, Error, Weighting)
%--------------------------------------------------------------------------
%Generates a weighted, discreet set of parameter values from an input of
%parameters from other sources.
%
%---------------------------------Inputs-----------------------------------
%K = List of parameters's to be weighted. In the form of a vector with N
%    values
%Error = Error in the parameters to be weighted (can be all zeros). In the
%        form of a with N values corresponding to the equivilent position
%        in K
%Weighting = Weighting matrix. Each column is a different conditional test.
%            In the form of an NxM matrix
%---------------------------------Outputs----------------------------------
%Kfinal = Vector containing a weighted list of parameters based on the
%         intial input parameters. Weighting is accounted for via
%         duplication of more relevant points.
%------------------------------Dependancies--------------------------------
%No dependancies
%--------------Written by Matthew Davies & Toby Summerill------------------
%-----------------University of Manchester iGEM 2016-----------------------
%--------------------------------------------------------------------------

%Error checking on inputs
%An error will be thrown and the code will stop running if:
%       K contains no values
%       K, Error or Weighting do not have the same dimension
if isempty(K) == 1
    error('Weighting_Fn: parameter to be weighted must contain values');
end
if length(Weighting) ~= length(K) || length(Error) ~= length(K)
    error('Weighting_Fn: The error vector and Weighting matrix need to be the same size as the parameter vector');
end

%Add error values as additional samples
Kplus = K + Error;
Kminus = K - Error;

%Find the total weighting
Wtotal = prod(Weighting);

%Merge the K, Kplus and Kminus and attach the weightings.
K = [cat(1 , K, Wtotal), cat(1, Kplus, Wtotal), cat(1, Kminus, Wtotal)];

%Remove physical impossiblites
K(1,(K(1,:) < 0)) = 0;          %Remove any negative K's and set them to 0

Knew = [];
for i = 1:length(K)
    for j = 1:K(2,i)
        Knew = [Knew, K(1,i)];
    end
end

%Removes top and bottom 2.5% of data points to set 95% confidence interval
Confidence = 0.05;
n = ceil(length(Knew)*Confidence/2);
Kfinal = Knew(n:length(Knew)-n);
end

