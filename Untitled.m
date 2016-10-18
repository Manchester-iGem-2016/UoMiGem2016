filename = 'expgraphsorig.xlsx';

S714 = xlsread(filename) ;
a = S714(2,8:26);
b = S714(1,8:26);
for i = 1:10
    a = S714(i+1,8:26);
plot(b,a);
hold on
end
lgd = legend('0.3','0.3','1.6','1.6','3.3','3.3','6.6','6.6','16.6','16.6');
title(lgd,'Concentration of abts initial(ug/ml)')
title('raw experimental data for half mechanism experiment');
xlabel('time (s)'); 
ylabel(' absorbance od ');