(*=======================*)
(*  PoincareGaugeTheory  *)
(*=======================*)

Title@"Poincaré gauge theory (PGT)";

Supercomment@"We will test the PoincareGaugeTheory module.";

Comment@"Now we set up the general Lagrangian:";

Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","PoincareGaugeTheory","LagrangianKarananasCouplings.m"};
(*Get@FileNameJoin@{Directory[],"LagrangianHayashiShirafujiCouplings.m"};*)

DisplayExpression@NonlinearLagrangian;
(*
Comment@"We also knock up some simple tools to linearise the Lagrangian:";
*)
Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","PoincareGaugeTheory","Linearise.m"};
Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","PoincareGaugeTheory","CriticalCases.m"};
Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","PoincareGaugeTheory","Unitarity.m"};

(*==========================*)
(*  Einstein-Cartan theory  *)
(*==========================*)

Section@"Einstein-Cartan theory (ECT)";

Comment@"Now we would like to check the basic Einstein-Cartan theory. Here is the full nonlinear Lagrangian:";

Off[Solve::svars];
CaseRules=(First/@(Solve[#,{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda}]&/@BasicCriticalCases))[[1]];
On[Solve::svars];

DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangian/.CaseRules];

Comment@"To use PSALTer, you have to first linearise this Lagrangian to second order around the desired vacuum:";

LinearisedLagrangian=LineariseLagrangian[NonlinearLagrangian/.CaseRules];
DisplayExpression@CollectTensors@LinearisedLagrangian;

Comment@"Now we pass this theory into the PSALTer package, which computes the particle spectrum:";

ParticleSpectrum[
	"PoincareGaugeTheory",
	"EinsteinCartanTheory",
	LinearisedLagrangian,
	TensorFields->{F,A},
	CouplingConstants->{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda},
	ExportTheory->True
];

Comment@"Okay, so that is the end of the PSALTer output for Einstein-Cartan gravity. What we find are no propagating massive modes, but instead two degrees of freedom in the massive sector. The no-ghost conditions on these massless d.o.f restrict the sign in front of the Einstein-Hilbert term to be negative (which is what we expect for our conventions).";

(*Throw@"Hold more of my beer!";*)

(*======================*)
(*  General relativity  *)
(*======================*)

Section@"General relativity (GR)";

Comment@"Using Karananas' coefficients, it is particularly easy to also look at GR, instead of Einstein-Cartan theory. The difference here is that the quadratic torsion coefficients are manually removed. Here is the nonlinear Lagrangian:";

Off[Solve::svars];
CaseRules=(First/@(Solve[#,{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda}]&/@BasicCriticalCases))[[2]];
On[Solve::svars];

DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangian/.CaseRules];

Comment@"Here is the linearised theory:";

LinearisedLagrangian=LineariseLagrangian[NonlinearLagrangian/.CaseRules];
DisplayExpression@CollectTensors@LinearisedLagrangian;

Comment@"Now we pass this theory into the PSALTer package, which computes the particle spectrum:";

ParticleSpectrum[
	"PoincareGaugeTheory",
	"GeneralRelativity",
	LinearisedLagrangian,
	TensorFields->{F,A},
	CouplingConstants->{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda},
	ExportTheory->True
];

Comment@"Thus, the conclusions are the same, as expected.";

(*=============================*)
(*  Yun Cherng Lin's 58 cases  *)
(*=============================*)

Section@"Performing the grand PGT survey";

Off[Solve::svars];
CriticalCasesSolutions=First/@(Solve[#,{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda}]&/@CriticalCases);
On[Solve::svars];

Comment@"We are now ready to check that PSALTer is getting the physics right by running it on the 58 theories in arXiv:1910.14197.";

Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","PoincareGaugeTheory","CalibrateCase.m"};

CalibrationTimingData=MapThread[
		AbsoluteTiming@CalibrateCase[#1,#2,#3]&,
		{
			Table[i,{i,1,58}],
			CriticalCasesSolutions[[1;;58]],(*formerly 1--58*)
			Unitarity[[1;;58]]
		}];

Section@"How long did this take?";

Comment@"Okay, that's all the cases. You can see from the timing below (in seconds) that each theory takes about a minute to process:";

DisplayExpression@CalibrationTimingData;

DumpSave[FileNameJoin@{NotebookDirectory[],"CalibrationTimingData.mx"},{CalibrationTimingData}];
