(*================================*)
(*  LagrangianKarananasCouplings  *)
(*================================*)

Comment@{"We can also use a different set of coupling coefficients to those in",Cref@"CleanHayashiShirafuji",", as developed by Karananas and used in e.g. arXiv:1910.14197."};
Code[
	DefConstantSymbol[kLambda,PrintAs->"\[Lambda]"];
	DefConstantSymbol[kR1,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptR]\), \(1\)]\)"];
	DefConstantSymbol[kR2,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptR]\), \(2\)]\)"];
	DefConstantSymbol[kR3,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptR]\), \(3\)]\)"];
	DefConstantSymbol[kR4,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptR]\), \(4\)]\)"];
	DefConstantSymbol[kR5,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptR]\), \(5\)]\)"];
	DefConstantSymbol[kR6,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptR]\), \(6\)]\)"];
	DefConstantSymbol[kT1,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptT]\), \(1\)]\)"];
	DefConstantSymbol[kT2,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptT]\), \(2\)]\)"];
	DefConstantSymbol[kT3,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptT]\), \(3\)]\)"];
];
NonlinearLagrangian=(
	-kLambda*R[i,j,-i,-j]
	(*+(kR6)*R[i,k,-i,-k]*R[j,l,-j,-l]*)
	+(kR4+kR5)*R[i,k,j,-k]*R[-i,l,-j,-l]
	+(kR4-kR5)*R[i,k,j,-k]*R[-j,l,-i,-l]
	+(kR1/3+kR2/6)*R[i,j,k,l]*R[-i,-j,-k,-l]
	+(2*kR1/3-2*kR2/3)*R[i,j,k,l]*R[-i,-k,-j,-l]
	+(kR1/3+kR2/6-kR3)*R[i,j,k,l]*R[-k,-l,-i,-j]
	+(kLambda/4+kT1/3+kT2/12)*T[i,j,k]*T[-i,-j,-k]
	+(-kLambda/2-kT1/3+kT2/6)*T[i,j,k]*T[-j,-k,-i]
	+(-kLambda-kT1/3+2*kT3/3)*T[-i,j,i]*T[-k,-j,k]
);
DisplayExpression[NonlinearLagrangian,EqnLabel->"CleanKarananas"];
KNonlinearLagrangian=NonlinearLagrangian;
