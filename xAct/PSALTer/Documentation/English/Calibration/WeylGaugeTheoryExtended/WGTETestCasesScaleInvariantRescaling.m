(* ::Package:: *)

(*=======================================*)
(*  WGTETestCasesScaleInvariantRescaling *)
(*=======================================*)

(*=====================================================================*)
(*  Test case 3: E--H action with propagating compensator and vector.  *)
(*=====================================================================*)
Section@"Test case 3: E--H action with propagating compensator and vector.";
Comment@"We test the case of the modified Einstein-Hilbert action, with propagating compensator and vector B. Here we use the scale-invariant variables, keeping B.";

TestCase3ScaleInv={lR1==lR2==lR3==lR4==lR5==(lT1+lLambda)==(lT2-lLambda)==(lT3-lLambda)==0};
Off[Solve::svars];
TestCase3ScaleInvRules=First/@(Solve[#,{lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}]&/@TestCase3ScaleInv);
On[Solve::svars];

DisplayExpression@CollectTensors@ToCanonical[First@((NonlinearLagrangianWGTEOriginal)/.TestCase3ScaleInvRules)];
LinearisedLagrangianWGTE=LineariseLagrangianWGTEScaleInvariantRescaling[First@((NonlinearLagrangianWGTEScaleInvariantRescaling)/.TestCase3ScaleInvRules)];
Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedLagrangianWGTE];

ParticleSpectrum[
	LinearisedLagrangianWGTE,
	ClassName->"WeylGaugeTheory",
	TheoryName->"TestCase3ScaleInvWithB",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Supercomment@"This marks the completion of the particle spectrum analysis for the modified E--H action with propagating compensator and vector.";

(*=========================================================*)
(*  Test case 4: Only propagating compensator and vector  *)
(*=========================================================*)
Section@"Test case 4: Only propagating compensator and vector.";
Comment@"We test the case of preserving only the propagating compensator and vector B. Here we use the scale-invariant variables, and removing B as an independent variable.";

TestCase4ScaleInv={lLambda==lR1==lR2==lR3==lR4==lR5==lC1==lT1==lT2==lT3==0};
Off[Solve::svars];
TestCase4ScaleInvRules=First/@(Solve[#,{lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}]&/@TestCase4ScaleInv);
On[Solve::svars];

DisplayExpression@CollectTensors@ToCanonical[First@((NonlinearLagrangianWGTEOriginal)/.TestCase4ScaleInvRules)];
LinearisedLagrangianWGTE=LineariseLagrangianWGTEScaleInvariantRescaling[First@((NonlinearLagrangianWGTEScaleInvariantRescalingPGT)/.TestCase4ScaleInvRules)];
Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedLagrangianWGTE];

ParticleSpectrum[
	LinearisedLagrangianWGTE,
	ClassName->"WeylGaugeTheory",
	TheoryName->"TestCase4ScaleInvWithoutB",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Supercomment@"This marks the completion of the particle spectrum analysis for action with only propagating compensator and vector.";
