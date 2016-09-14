function [ istorevectortv ] = kern_fn( BinNumber , Iterations , K )


xmax = 1.2*max(K) ;
binsize = xmax/BinNumber;
x = binsize:binsize:xmax + binsize ;
h = 5*range(K); % scaling parameter
xi = K; % K inputs
evec = zeros(length(xi),length(x));

for i = 1:length(xi)
    
evec(i,:) = (35/32)*(1-(((x-xi(i)))/h).^2).^3 ;
%fx(i)  = 1/((length(xi))*h) * sum(evec) ;

end
evec(evec<0) = 0;
fx  = 1/((length(xi))*h) * (sum(evec)); 

yi = cumtrapz(fx);
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
istorevectortv  = istorevector .* binsize ;
end

