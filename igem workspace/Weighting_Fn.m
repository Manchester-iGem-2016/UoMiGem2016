%Takes the K values from literature, their error and weighting and returns
%K values to produce a probability density.
%   Takes the K values given in literature, their recored error and the
%   weighting based on how similar the data is to the system being
%   modelled. Returns a vector with the K values used to create a
%   probability density curve.
%       Inputs are a [1 x n] vector K, [1 x n] vector Error and [4 x n] Matrix Weighting

% clean slate protocol
clear 
clc


filenameI = input('what is the name of the spreadsheet holding your literature values?','s') ;
filenameO = input('what do you want the outputted K values to be called?','s');

A = xlsread(filenameI); 

K = A(2:max(size(A)),2).';
K(isnan(K)) = [] ; 

Error =  A(2:max(size(A)),3).'; 
Error(isnan(Error)) = [] ;


%Add error values as additional samples
Kplus = K + Error;
Kminus = K - Error;

%Find the total weighting

Wtotal  = A(2:max(size(A)),min(size(A))).';
Wtotal(isnan(Wtotal)) = [] ;
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





