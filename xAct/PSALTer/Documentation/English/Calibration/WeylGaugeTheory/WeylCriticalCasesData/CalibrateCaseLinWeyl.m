(* ::Package:: *)

(*========================*)
(*  CalibrateCaseLinWeyl  *)
(*========================*)

CalibrateCaseLinWeyl[CaseNumber_,CaseRules_List,CaseConditions_List]:=Module[{
	LinearisedLagrangianLinWeyl,
	Couplings={lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0},
	CouplingAssumptions},

	Subsection@("Case "<>ToString@CaseNumber);	

	Comment@("Now for a new theory. Here is the full nonlinear Lagrangian for Case "<>ToString@CaseNumber<>". Cases 1-13 as defined by the second column of TABLE I. in Lin, PHYS. REV. D 104, 024034 (2021):");	

	DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangianLinWeyl/.CaseRules];

	LinearisedLagrangianLinWeyl=LineariseLagrangianLinWeyl[NonlinearLagrangianLinWeyl/.CaseRules];
	
	(*Diagnostic line follows*)
	Print@"Hi there, I'm sitting between Zhiyuan's code and Will's code!";
	
	ParticleSpectrum[
		LinearisedLagrangianLinWeyl,
		ClassName->"WeylGaugeTheory",
		TheoryName->("WeylCase"<>ToString@CaseNumber),
		Method->"Easy",
		MaxLaurentDepth->3
	];

	Comment@"So, that's the end of the PSALTer output for this theory. You can check the particle content against TABLE II. in Lin, PHYS. REV. D 104, 024034 (2021). If you take the overall unitarity conditions from the final column in TABLE I., and decompose them using Mathematica's Reduce function, you get the following (to be compared with the PSALTer conditions above):";
	
	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	DisplayExpression@Quiet@Assuming[CouplingAssumptions,Reduce[CaseConditions,Couplings]];

	Comment@"Okay, that concludes the analysis of this theory.";
	];
