(*========================*)
(*  EinsteinCartanTheory  *)
(*========================*)

Section@"Einstein-Cartan theory (ECT)";

Comment@"Now we would like to check the basic Einstein-Cartan theory. Here is the full nonlinear Lagrangian:";

Off[Solve::svars];
CaseRules=(First/@(Solve[#,{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda}]&/@BasicCriticalCases))[[1]];
On[Solve::svars];

DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangian/.CaseRules];

LinearisedLagrangian=LineariseLagrangian[NonlinearLagrangian/.CaseRules];

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"EinsteinCartanTheory",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Comment@"Okay, so that is the end of the PSALTer output for Einstein-Cartan gravity. What we find are no propagating massive modes, but instead two degrees of freedom in the massive sector. The no-ghost conditions on these massless d.o.f restrict the sign in front of the Einstein-Hilbert term to be negative (which is what we expect for our conventions).";
