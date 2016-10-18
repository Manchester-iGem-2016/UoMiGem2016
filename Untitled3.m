filename = 'expgraphsorig.xlsx';


for i = 1:10    
plot(Texp(:),Yexpvec(i,:));
hold on
end
lgd = legend('0.3','0.3','1.6','1.6','3.3','3.3','6.6','6.6','16.6','16.6');
title(lgd,'abts initial(ug/ml)')
title('converted data for half mechanism experiment');
xlabel('time (s)'); 
ylabel(' absorbance od ');