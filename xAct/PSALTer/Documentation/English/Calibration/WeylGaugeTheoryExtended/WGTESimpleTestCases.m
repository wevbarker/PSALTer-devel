(* ::Package:: *)

(*======================*)
(*  WGTESimpleTestCases *)
(*======================*)

(*============================*)
(*  Test case 1: E--H action  *)
(*============================*)
Section@"Test case 1: E--H action.";
Comment@"We test the case of the modified Einstein-Hilbert action, and the code will give only 2 propagating graviton modes.";

TestCase={lR1==lR2==lR3==lR4==lR5==lC1==lXi==lNu==(lT1+lLambda)==(lT2-lLambda)==(lT3-lLambda)==0};
Off[Solve::svars];
TestCaseRules=First/@(Solve[#,{lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}]&/@TestCase);
On[Solve::svars];
DisplayExpression@CollectTensors@ToCanonical[First@((NonlinearLagrangianWGTE)/.TestCaseRules)];
LinearisedLagrangianWGTE=LineariseLagrangianWGTE[First@((NonlinearLagrangianWGTE)/.TestCaseRules)];

Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedLagrangianWGTE];

ParticleSpectrum[
	LinearisedLagrangianWGTE,
	ClassName->"WeylGaugeTheory",
	TheoryName->"TestWGTEwithEH",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Supercomment@"This marks the completion of the particle spectrum analysis for the modified E--H action.";

(*=========================================================*)
(*  Test case 2: E--H action with propagating compensator  *)
(*=========================================================*)
Section@"Test case 2: E--H action with propagating compensator.";
Comment@"We test the case of the modified Einstein-Hilbert action, with propagating compensator.";

TestCase2={lR1==lR2==lR3==lR4==lR5==lC1==lXi==(lT1+lLambda)==(lT2-lLambda)==(lT3-lLambda)==0};
Off[Solve::svars];
TestCase2Rules=First/@(Solve[#,{lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}]&/@TestCase2);
On[Solve::svars];

DisplayExpression@CollectTensors@ToCanonical[First@((NonlinearLagrangianWGTE)/.TestCase2Rules)];
LinearisedLagrangianWGTE=LineariseLagrangianWGTE[First@((NonlinearLagrangianWGTE)/.TestCase2Rules)];
Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedLagrangianWGTE];

ParticleSpectrum[
	LinearisedLagrangianWGTE,
	ClassName->"WeylGaugeTheory",
	TheoryName->"TestWGTEwithEHwithPropagator",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Supercomment@"This marks the completion of the particle spectrum analysis for the modified E--H action with propagating compensator.";

(*=====================================================================*)
(*  Test case 3: E--H action with propagating compensator and vector.  *)
(*=====================================================================*)
Section@"Test case 3: E--H action with propagating compensator and vector.";
Comment@"We test the case of the modified Einstein-Hilbert action, with propagating compensator and vector B.";

TestCase3={lR1==lR2==lR3==lR4==lR5==(lT1+lLambda)==(lT2-lLambda)==(lT3-lLambda)==0};
Off[Solve::svars];
TestCase3Rules=First/@(Solve[#,{lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}]&/@TestCase3);
On[Solve::svars];

DisplayExpression@CollectTensors@ToCanonical[First@((NonlinearLagrangianWGTE)/.TestCase3Rules)];
LinearisedLagrangianWGTE=LineariseLagrangianWGTE[First@((NonlinearLagrangianWGTE)/.TestCase3Rules)];
Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedLagrangianWGTE];

ParticleSpectrum[
	LinearisedLagrangianWGTE,
	ClassName->"WeylGaugeTheory",
	TheoryName->"TestWGTEwithEHwithPropagatorVector",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Supercomment@"This marks the completion of the particle spectrum analysis for the modified E--H action with propagating compensator and vector.";

(*=========================================================*)
(*  Test case 4: Only propagating compensator and vector  *)
(*=========================================================*)
Section@"Test case 4: Only propagating compensator and vector.";
Comment@"We test the case of preserving only the propagating compensator and vector B.";

TestCase4={lLambda==lR1==lR2==lR3==lR4==lR5==lC1==lT1==lT2==lT3==0};
Off[Solve::svars];
TestCase4Rules=First/@(Solve[#,{lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}]&/@TestCase4);
On[Solve::svars];

DisplayExpression@CollectTensors@ToCanonical[First@((NonlinearLagrangianWGTE)/.TestCase4Rules)];
LinearisedLagrangianWGTE=LineariseLagrangianWGTE[First@((NonlinearLagrangianWGTE)/.TestCase4Rules)];
Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedLagrangianWGTE];

ParticleSpectrum[
	LinearisedLagrangianWGTE,
	ClassName->"WeylGaugeTheory",
	TheoryName->"TestWGTEwithOnlyPropagatorVector",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Supercomment@"This marks the completion of the particle spectrum analysis for action with only propagating compensator and vector.";
