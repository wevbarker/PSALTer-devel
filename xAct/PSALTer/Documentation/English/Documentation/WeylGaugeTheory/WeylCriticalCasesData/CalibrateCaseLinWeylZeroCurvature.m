(* ::Package:: *)

(*=====================================*)
(*  CalibrateCaseLinWeylZeroCurvature  *)
(*=====================================*)

CalibrateCaseLinWeylZeroCurvature[CaseNumber_,CaseRules_List]:=Module[{
	LinearisedLagrangianLinWeyl,
	Couplings={lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}},
	
	(*To fit with notation in CriticalCasesLinWeyl*)
	CaseNumberAdded=CaseNumber+52;

	Subsection@("Case "<>ToString@CaseNumberAdded<>" i.e. zero-curvature case "<>ToString@UnitarityInfoLinWeylZeroCurvature[[CaseNumber,1]]);	
	Comment@("Now for a new theory. Here is the full nonlinear Lagrangian for Case "<>ToString@CaseNumberAdded<>". Cases 53-65 as defined by FIG. 2 in Lin, PHYS. REV. D 104, 024034 (2021). Cases 66-71 as in TABLE IV:");	
	
	(*Diagnostic*)
	Comment@("Here are the expected details of this case:");
	UnitarityInfoLinWeylZeroCurvaturePrint[CaseNumber];

	LinearisedLagrangianLinWeyl=LineariseLagrangianLinWeyl[NonlinearLagrangianLinWeyl/.CaseRules];
	(*Here we perform the zero-curvature restriction*)
	LinearisedLagrangianLinWeyl=LinearisedLagrangianLinWeyl/.WeylRotationalGaugeField->Zero;
	
	Comment@("For cases 53-71, we need to set A to 0. Here is the resultant linearised Lagrangian.");	
	DisplayExpression@CollectTensors@ToCanonical[LinearisedLagrangianLinWeyl];
	
	(*Diagnostic line follows*)
	Print@"Hi there, I'm sitting between Zhiyuan's code and Will's code!";
	
	ParticleSpectrum[
		LinearisedLagrangianLinWeyl,
		ClassName->"WeylGaugeTheory",
		TheoryName->("WeylCase"<>ToString@CaseNumberAdded),
		Method->"Easy",
		MaxLaurentDepth->3
	];

	Comment@"So, that's the end of the PSALTer output for this theory. N.B. No unitary bounds in the paper for these cases; here is the unitary information from the paper:";
	UnitarityInfoLinWeylZeroCurvaturePrint[CaseNumber];
	Comment@"Okay, that concludes the analysis of this theory.";
	];
