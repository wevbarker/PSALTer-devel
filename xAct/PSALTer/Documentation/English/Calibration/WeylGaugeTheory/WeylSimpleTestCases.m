(* ::Package:: *)

(*======================*)
(*  WeylSimpleTestCases *)
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
DisplayExpression@CollectTensors@ToCanonical[First@((NonlinearLagrangianLinWeyl)/.TestCaseRules)];
LinearisedLagrangianLinWeyl=LineariseLagrangianLinWeyl[First@((NonlinearLagrangianLinWeyl)/.TestCaseRules)];

Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedLagrangianLinWeyl];

ParticleSpectrum[
	LinearisedLagrangianLinWeyl,
	ClassName->"WeylGaugeTheory",
	TheoryName->"TestWGTwithEH",	
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

DisplayExpression@CollectTensors@ToCanonical[First@((NonlinearLagrangianLinWeyl)/.TestCase2Rules)];
LinearisedLagrangianLinWeyl=LineariseLagrangianLinWeyl[First@((NonlinearLagrangianLinWeyl)/.TestCase2Rules)];
Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedLagrangianLinWeyl];

ParticleSpectrum[
	LinearisedLagrangianLinWeyl,
	ClassName->"WeylGaugeTheory",
	TheoryName->"TestWGTwithEHwithPropagator",	
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

DisplayExpression@CollectTensors@ToCanonical[First@((NonlinearLagrangianLinWeyl)/.TestCase3Rules)];
LinearisedLagrangianLinWeyl=LineariseLagrangianLinWeyl[First@((NonlinearLagrangianLinWeyl)/.TestCase3Rules)];
Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedLagrangianLinWeyl];

ParticleSpectrum[
	LinearisedLagrangianLinWeyl,
	ClassName->"WeylGaugeTheory",
	TheoryName->"TestWGTwithEHwithPropagatorVector",	
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

DisplayExpression@CollectTensors@ToCanonical[First@((NonlinearLagrangianLinWeyl)/.TestCase4Rules)];
LinearisedLagrangianLinWeyl=LineariseLagrangianLinWeyl[First@((NonlinearLagrangianLinWeyl)/.TestCase4Rules)];
Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedLagrangianLinWeyl];

ParticleSpectrum[
	LinearisedLagrangianLinWeyl,
	ClassName->"WeylGaugeTheory",
	TheoryName->"TestWGTwithOnlyPropagatorVector",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Supercomment@"This marks the completion of the particle spectrum analysis for action with only propagating compensator and vector.";

(*===========================================*)
(*  Test case 5: Test case for gauge fixing  *)
(*===========================================*)
Section@"Test case 5: Test case of vector field with Lorenz Gauge multiplier.";
Comment@"As an aside, we test vector field B with Lorenz gauge multiplier to better understand gauge fixing.";

TestLorenzLagrangian = (-lR1/4)*WeylH[a,b]*WeylH[-a,-b]+lXi*((Compensator[]/lPhi0) - Scalar[1])*(CD[-i][WeylVector[i]]);
Comment@{"Here is the standard QED Lagrangian with Lorenz gauge mulitplier."};
DisplayExpression@CollectTensors@ToCanonical[TestLorenzLagrangian];

(*To expand out H tensor*)
TestLorenzLagrangian=TestLorenzLagrangian/.xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylQuantitiesExpand;
TestLorenzLagrangian//=xAct`PSALTer`Private`ToNewCanonical;

LinearisedTestLorenzLagrangian=LineariseLagrangianLinWeyl[TestLorenzLagrangian];
Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedTestLorenzLagrangian];

ParticleSpectrum[
	LinearisedTestLorenzLagrangian,
	ClassName->"WeylGaugeTheory",
	TheoryName->"TestLorenzLagrangian",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Comment@{"Now we look at specific case where the couplings are set to fufil the Lorenz gauge fixing."}

TestCase5={lLambda==(lR1-lXi)==lR2==lR3==lR4==lR5==lC1==lNu==lT1==lT2==lT3==0};
Off[Solve::svars];
TestCase5Rules=First/@(Solve[#,{lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}]&/@TestCase5);
On[Solve::svars];

LinearisedTestLorenzLagrangian=First@((LinearisedTestLorenzLagrangian)/.TestCase5Rules);
LinearisedTestLorenzLagrangian+=(lR1/2)*Compensator[]*Compensator[]
Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedTestLorenzLagrangian];

(*Diagnostic line*)
Print@"Hi there, I'm sitting between Zhiyuan's code and Will's code! I use method -> easy mode.";

ParticleSpectrum[
	LinearisedTestLorenzLagrangian,
	ClassName->"WeylGaugeTheory",
	TheoryName->"TestLorenzLagrangianCriticalCase",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Supercomment@"This marks the completion of the particle spectrum analysis for QED with Lorenz gauge fixing.";
