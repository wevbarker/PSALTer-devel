(*=====================*)
(*  GeneralRelativity  *)
(*=====================*)

Section@"General relativity (GR)";

Comment@"Using Karananas' coefficients, it is particularly easy to also look at GR, instead of Einstein-Cartan theory. The difference here is that the quadratic torsion coefficients are manually removed. Here is the nonlinear Lagrangian:";

Off[Solve::svars];
CaseRules=(First/@(Solve[#,{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda}]&/@BasicCriticalCases))[[2]];
On[Solve::svars];

DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangian/.CaseRules];

LinearisedLagrangian=LineariseLagrangian[NonlinearLagrangian/.CaseRules];

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"GeneralRelativity",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Comment@"Thus, the conclusions are the same, as expected.";
