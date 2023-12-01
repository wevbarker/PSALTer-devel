(* ::Package:: *)

(*====================================*)
(*  CalibrateCaseLinWeylZeroTorsion  *)
(*====================================*)

CalibrateCaseLinWeylZeroTorsion[CaseNumber_,CaseRules_List]:=Module[{
	LinearisedLagrangianLinWeyl,
	Couplings={lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}},
	
	(*To fit with notation in CriticalCasesLinWeyl*)
	CaseNumberAdded=CaseNumber+13;

	Subsection@("Case "<>ToString@CaseNumberAdded);	

	Comment@("Now for a new theory. Here is the full nonlinear Lagrangian for Case "<>ToString@CaseNumberAdded<>". Cases 14-29 as defined by FIG. 1 in Lin, PHYS. REV. D 104, 024034 (2021). Cases 30-52 as in TABLE III:");	
	
	(*Here we perform the zero-torsion restriction*)
	Comment@("For cases 14-52, we need to set the WGT torsion T* to 0.");
	NonlinearLagrangianLinWeylZeroTorsion=WeylTestExpandRotationalGaugeToVectorAndTetradBHFunction[NonlinearLagrangianLinWeyl];

	DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangianLinWeylZeroTorsion/.CaseRules];

	LinearisedLagrangianLinWeyl=LineariseLagrangianLinWeyl[NonlinearLagrangianLinWeylZeroTorsion/.CaseRules];
	
	(*Diagnostic line follows*)
	Print@"Hi there, I'm sitting between Zhiyuan's code and Will's code!";
	
	ParticleSpectrum[
		LinearisedLagrangianLinWeyl,
		ClassName->"WeylGaugeTheory",
		TheoryName->("WeylCase"<>ToString@CaseNumberAdded),
		Method->"Easy",
		MaxLaurentDepth->3
	];

	Comment@"So, that's the end of the PSALTer output for this theory. N.B. No unitary conditions in the paper for these cases.";
	Comment@"Okay, that concludes the analysis of this theory.";
	];
