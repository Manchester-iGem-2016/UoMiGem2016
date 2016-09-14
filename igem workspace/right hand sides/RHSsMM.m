function ret=RHSsMM(t, y, kv)

 % set up ret in correct form (i.e. a column vector)
 ret(5,1) = 0;

 % extract current values of paramaters
 A = y(1);
 Eaox = y(2);
 H2O2 = y(3);
 Ehrp = y(4);
 Abts = y(5);
 % return updates
 ret(1) = - ((kv(2)*Eaox*A)/(kv(1)+A));
 ret(2) = 0;
 ret(3) = (kv(2)*Eaox*A)/(kv(1)+A) - (kv(4)*Ehrp*H2O2)/(kv(3)+H2O2);
 ret(4) = 0;
 ret(5) = (kv(4)*Ehrp*H2O2)/(kv(3)+H2O2);
 
end