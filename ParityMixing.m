(*=======*)
(*  Run  *)
(*=======*)

Print@"First we import some formatting...";

Get@FileNameJoin@{NotebookDirectory[],"Calibration","VimFormat.m"};

Comment@"...okay, that's better, from now on any commentary written inside this Calibration.m wrapper will present as blue text (i.e. this text is not part of PSALTer, it is just a use-case). Next we load the PSALTer package:";

<<xAct`PSALTer`;

Get@FileNameJoin@{NotebookDirectory[],"Calibration","LagrangianKarananasCouplings.m"};

Print@NonlinearLagrangian;

Comment@"We also knock up some simple tools to linearise the Lagrangian:";

Get@FileNameJoin@{NotebookDirectory[],"Calibration","Linearise.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","CriticalCases.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","Unitarity.m"};

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

Catch@ParticleSpectrum[
	"PGT",
	"EinsteinCartanTheory",
	LinearisedLagrangian,
	TensorFields->{F,A},
	CouplingConstants->{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda},
	ExportTheory->True
];

Comment@"Okay, so that is the end of the PSALTer output for Einstein-Cartan gravity. What we find are no propagating massive modes, but instead two degrees of freedom in the massive sector. The no-ghost conditions on these massless d.o.f restrict the sign in front of the Einstein-Hilbert term to be negative (which is what we expect for our conventions).";

Throw["ReachedEnd"];
