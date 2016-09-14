function [ Kconstraints ] = randlogconstraint_fn( BinNumber , Iterations , K )
% Generates a high and low value for the constraints
% works like a normal randlog apart from two values, see randlog for detail.
%Generating an input function (density curve)
%K = [1,2,3,4,5,6,7,8,9,10];
%Iterations = 10000;
%BinNumber = 2000;
U = mean(log(K));       
O = std(log(K));
xmax = 1.5*max(K) ;
binsize = xmax/BinNumber;
x = binsize:binsize:xmax + binsize ;
%y = x - x + 5;
y = (1./(x.*O.*((2.*pi()).^0.5))).*exp((-(log(x)-U).^2)./(2.*(O.^2)));
yi = cumtrapz(y);
%normalise both axis to 1
yi = yi./max(yi);
%plot(x,yi);

bin_areas = zeros(1,(ceil((max(x))/binsize))); 
istorevector  = zeros(1,Iterations) ;
        for i = 1:BinNumber
        bin_areas(i) = yi(i+1) - yi(i);     
        end
        
for j = 1:Iterations 
    r = rand();
    i = 1;
    semisum  = bin_areas(i);
    offon = 0;
    while offon == 0
 
    if semisum > r
    istore = i;
    offon = 1;
    else
    i = i + 1;
    semisum = semisum + bin_areas(i);
    end

    end
    istorevector(j) = istore;

    
end

tempK  = istorevector .* binsize ;

Ovector = ones(1,length(tempK)).*O;
Kconstraints = zeros(2,length(tempK));
Kconstraints(1,:) = tempK + 0.5*Ovector;
Kconstraints(2,:) = tempK - 0.5*Ovector;













