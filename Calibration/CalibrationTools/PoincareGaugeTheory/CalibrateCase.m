(*=================*)
(*  CalibrateCase  *)
(*=================*)

CalibrateCase[CaseNumber_,CaseRules_List,CaseConditions_List]:=Module[{
	LinearisedLagrangian,
	Couplings={kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda},
	CouplingAssumptions},

	Subsection@("Case "<>ToString@CaseNumber);	

	Comment@("Now for a new theory. Here is the full nonlinear Lagrangian for Case "<>ToString@CaseNumber<>" as defined by the second column of TABLE V. in arXiv:1910.14197:");	

	DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangian/.CaseRules];

	LinearisedLagrangian=LineariseLagrangian[NonlinearLagrangian/.CaseRules];

	ParticleSpectrum[
		LinearisedLagrangian,
		ClassName->"PoincareGaugeTheory",
		TheoryName->("Case"<>ToString@CaseNumber),
		Method->"Careless",
		MaxLaurentDepth->3
	];

	Comment@"So, that's the end of the PSALTer output for this theory. You can check the particle content against TABLE IV. in arXiv:1910.14197. If you take the overall unitarity conditions from the final column in TABLE V., and decompose them using Mathematica's Reduce function, you get the following (to be compared with the PSALTer conditions above):";
	
	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	DisplayExpression@Quiet@Assuming[CouplingAssumptions,Reduce[CaseConditions,Couplings]];

	Comment@"Okay, that concludes the analysis of this theory.";
	
	];
