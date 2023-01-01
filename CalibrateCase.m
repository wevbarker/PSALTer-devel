(*=================*)
(*  CalibrateCase  *)
(*=================*)

CalibrateCase[CaseNumber_,CaseRules_List,CaseConditions_List]:=Module[{
	LinearisedLagrangian,
	Couplings={kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda},
	CouplingAssumptions},

	Comment@("Now for a new theory. Here is the full nonlinear Lagrangian for Case "<>ToString@CaseNumber<>" as defined by the second column of TABLE V. in arXiv:1910.14197:");	

	Print@CollectTensors@ToCanonical[NonlinearLagrangian/.CaseRules];

	Comment@"To use PSALTer, you have to first linearise this Lagrangian to second order around the desired vacuum:";

	LinearisedLagrangian=LineariseLagrangian[NonlinearLagrangian/.CaseRules];
	Print@LinearisedLagrangian;

	Comment@"Now we pass this theory into the PSALTer package, which computes the particle spectrum:";

	ParticleSpectrum[
		"Case"<>ToString@CaseNumber,
		LinearisedLagrangian,
		TensorFields->{F,A},
		CouplingConstants->Couplings,
		ExportTheory->True
	];

	Comment@"So, that's the end of the PSALTer output for this theory. You can check the particle content against TABLE IV. in arXiv:1910.14197. If you take the overall unitarity conditions from the final column in TABLE V., and decompose them using Mathematica's Reduce function, you get the following (to be compared with the PSALTer conditions above):";
	
	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	Print@Assuming[CouplingAssumptions,Reduce[CaseConditions,Couplings]];

	Comment@"Okay, that concludes the analysis of this theory.";
	
	];
