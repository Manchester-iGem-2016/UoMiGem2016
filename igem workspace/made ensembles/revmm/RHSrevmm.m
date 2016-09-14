function ret=RHSrevmm(t, y, kv)

 % set up ret in correct form (i.e. a column vector)
 ret(5,1) = 0;

 % extract current values of paramaters
 A = y(1);
 Eaox = y(2);
 H2O2 = y(3);
 Ehrp = y(4);
 Abts = y(5);
 % return updates

 
 ret(1) = -kv(3)*A*Eaox/kv(1)*(1-((H2O2/A)/kv(4)))/(1 + (A/kv(1))+(H2O2/kv(2)));
 ret(2) = 0;
 ret(3) = kv(3)*A*Eaox/kv(1)*(1-((H2O2/A)/kv(4)))/(1 + (A/kv(1))+(H2O2/kv(2))) - ((kv(7)*Ehrp*H2O2/kv(5))-(kv(8)*Ehrp*Abts/kv(6)))/(1+(H2O2/kv(5))+(Abts/kv(6)));
 ret(4) = 0;
 ret(5) = ((kv(7)*Ehrp*H2O2/kv(5))-(kv(8)*Ehrp*Abts/kv(6)))/(1+(H2O2/kv(5))+(Abts/kv(6)));
 
 
end