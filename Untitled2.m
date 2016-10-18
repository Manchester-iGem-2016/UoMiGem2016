filename = 'RESULTS.xlsx';

S714 = xlsread(filename) ;
S714x = final;
%a = S714(2,3:150);
b = S714(1,3:150);
for i = 1:18
    a = S714(i+1,3:150);
plot(b,a);
hold on
end
lgd = legend('0.5','0.5','0.5','1','1','1','1.25','1.25','1.25','1.5','1.5','1.5','1.75','1.75','1.75','2','2','2','location','BestOutside');
title(lgd,'glucose(ug/ml)')
title('raw data for full mechanism experiment');
xlabel('time (s)'); 
ylabel(' absorbance od ');