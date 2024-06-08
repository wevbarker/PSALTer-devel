(*=================*)
(*  CalibrateCase  *)
(*=================*)

CalibrateCase[CaseNumber_,CaseRules_List,CaseConditions_List]:=Module[{
	LinearLagrangian,
	Couplings={kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda},
	CouplingAssumptions},

	Subsection@("Lin-Hobson-Lasenby theory Case "<>ToString@CaseNumber);	

	Comment@{"Here is the full nonlinear Lagrangian for Case "<>ToString@CaseNumber<>" as defined by the second column of TABLE V. in arXiv:1910.14197, using the general formulation in",Cref@"CleanKarananas","."};
	DisplayExpression@CollectTensors@ToCanonical[KNonlinearLagrangian/.CaseRules];
	LinearLagrangian=LineariseLagrangian[KNonlinearLagrangian/.CaseRules];
	(*If[CaseNumber===18,$ReadOnly=False];*)
	Code[LinearLagrangian,
		ParticleSpectrum[
			LinearLagrangian,
			TheoryName->("Case"<>ToString@CaseNumber),
			Method->"Easy",
			MaxLaurentDepth->3
		];
	];
	(*If[CaseNumber===18,$ReadOnly=True];*)
	Comment@"The particle content can be checked against TABLE IV. in arXiv:1910.14197. If the overall unitarity conditions are taken from the final column in TABLE V., and decomposed using Mathematica's Reduce function, the following conditions are produced (to be compared with the predictions above).";
	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	DisplayExpression@Quiet@Assuming[CouplingAssumptions,Reduce[CaseConditions,Couplings]];
];
