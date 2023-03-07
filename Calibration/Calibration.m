(*=======*)
(*  Run  *)
(*=======*)

(*============*)
(*  Preamble  *)
(*============*)

Print@"First we import some formatting...";

Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","VimFormat.m"};

Comment@"...okay, that's better, from now on any commentary written inside this Calibration.m wrapper will present as blue text (i.e. this text is not part of PSALTer, it is just a use-case). Next we load the PSALTer package:";

<<xAct`PSALTer`;

Comment@"Now we set up the general Lagrangian:";

Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","LagrangianKarananasCouplings.m"};
(*Get@FileNameJoin@{Directory[],"LagrangianHayashiShirafujiCouplings.m"};*)

Print@NonlinearLagrangian;

Comment@"We also knock up some simple tools to linearise the Lagrangian:";

Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","Linearise.m"};
Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","CriticalCases.m"};
Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","Unitarity.m"};

(*==========================*)
(*  Einstein-Cartan theory  *)
(*==========================*)

Comment@"Now we would like to check the basic Einstein-Cartan theory. Here is the full nonlinear Lagrangian:";

Off[Solve::svars];
CaseRules=(First/@(Solve[#,{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda}]&/@BasicCriticalCases))[[1]];
On[Solve::svars];

Print@CollectTensors@ToCanonical[NonlinearLagrangian/.CaseRules];

Comment@"To use PSALTer, you have to first linearise this Lagrangian to second order around the desired vacuum:";

LinearisedLagrangian=LineariseLagrangian[NonlinearLagrangian/.CaseRules];
Print@CollectTensors@LinearisedLagrangian;

Comment@"Now we pass this theory into the PSALTer package, which computes the particle spectrum:";

ParticleSpectrum[
	"PGT",
	"EinsteinCartanTheory",
	LinearisedLagrangian,
	TensorFields->{F,A},
	CouplingConstants->{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda},
	ExportTheory->True
];

Comment@"Okay, so that is the end of the PSALTer output for Einstein-Cartan gravity. What we find are no propagating massive modes, but instead two degrees of freedom in the massive sector. The no-ghost conditions on these massless d.o.f restrict the sign in front of the Einstein-Hilbert term to be negative (which is what we expect for our conventions).";

(*======================*)
(*  General relativity  *)
(*======================*)

Comment@"Using Karananas' coefficients, it is particularly easy to also look at GR, instead of Einstein-Cartan theory. The difference here is that the quadratic torsion coefficients are manually removed. Here is the nonlinear Lagrangian:";

Off[Solve::svars];
CaseRules=(First/@(Solve[#,{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda}]&/@BasicCriticalCases))[[2]];
On[Solve::svars];

Print@CollectTensors@ToCanonical[NonlinearLagrangian/.CaseRules];

Comment@"Here is the linearised theory:";

LinearisedLagrangian=LineariseLagrangian[NonlinearLagrangian/.CaseRules];
Print@CollectTensors@LinearisedLagrangian;

Comment@"Now we pass this theory into the PSALTer package, which computes the particle spectrum:";

ParticleSpectrum[
	"PGT",
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

Off[Solve::svars];
CriticalCasesSolutions=First/@(Solve[#,{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda}]&/@CriticalCases);
On[Solve::svars];

Comment@"We are now ready to check that PSALTer is getting the physics right by running it on the 58 theories in arXiv:1910.14197.";

Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","CalibrateCase.m"};

Title@"Performing the survey";

CalibrationTimingData=MapThread[
		AbsoluteTiming@CalibrateCase[#1,#2,#3]&,
		{
			Table[i,{i,1,2}],
			CriticalCasesSolutions[[1;;2]],(*formerly 1--58*)
			Unitarity[[1;;2]]
		}];

Title@"How long did this take?";

Comment@"Okay, that's all the cases. You can see from the timing below (in seconds) that each theory takes about a minute to process:";

Print@CalibrationTimingData;

DumpSave[FileNameJoin@{NotebookDirectory[],"CalibrationTimingData.mx"},{CalibrationTimingData}];

Quit[];
