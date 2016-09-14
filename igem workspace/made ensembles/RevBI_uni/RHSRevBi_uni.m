function ret=RHSRevBi_uni(t, y, kv)

 % set up ret in correct form (i.e. a column vector)
 ret(6,1) = 0;
 % store all your kv's in variables so nicer 
 % note km2s1 signifies second substrate in first step.
 kcatf1 = kv(1);
 km1s1 = kv(2);
 keq1 = kv(3);
 km1p1 = kv(4);
 kcatf2 = kv(5);
 km1s2 = kv(6);
 km2s2 = kv(7);
 keq2 = kv(8);
 km1p2 = kv(9);
 
 % extract current values of paramaters
 A = y(1);
 Eaox = y(2);
 H2O2 = y(3);
 Ehrp = y(4);
 Abts = y(5);
 AbtsStar = y(6);
 % calculate all notation quantities
 % note alpha2_1 signifies alpha2 of first step 
 Vf1 = kcatf1 * Eaox; 
 alpha1_1 = A/km1s1 ;
 tau1 = H2O2/A  ;
 phro1 = tau1/keq1 ;
 pi1_1 = H2O2/km1p1 ;
 Vf2 = kcatf2 * Ehrp ; 
 alpha1_2 = H2O2/km1s2 ; 
 alpha2_2 = Abts/km2s2 ; 
 tau2 = AbtsStar/(H2O2*Abts) ;
 phro2 = tau2/keq2 ;
 pi1_2 = AbtsStar/km1p2 ; 
 % evaluate each step
 step1 = (Vf1*alpha1_1*(1-phro1))/(1+alpha1_1+pi1_1);
 step2 = (Vf2*alpha1_2*alpha2_2*(1-phro2))/(1+alpha1_2+alpha2_2+(alpha1_2*alpha2_2)+pi1_2);
 % return updates
 ret(1) = -step1 ;
 ret(2) = 0 ;
 ret(3) = step1 - step2 ;
 ret(4) = 0 ;
 ret(5) = -step2 ;
 ret(6) = step2 ; 
 
end