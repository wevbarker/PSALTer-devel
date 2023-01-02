(*=======*)
(*  Run  *)
(*=======*)

Print@"First we import some formatting...";

Get@FileNameJoin@{NotebookDirectory[],"VimFormat.m"};

Comment@"...okay, that's better, from now on any commentary written inside this Calibration.m wrapper will present as blue text (i.e. this text is not part of PSALTer, it is just a use-case). Next we load the PSALTer package:";

<<xAct`PSALTer`;

Comment@"Now we set up the general Lagrangian:";

Get@FileNameJoin@{NotebookDirectory[],"LagrangianKarananasCouplings.m"};
(*Get@FileNameJoin@{Directory[],"LagrangianHayashiShirafujiCouplings.m"};*)

Print@NonlinearLagrangian;

Comment@"We also knock up some simple tools to linearise the Lagrangian:";

Get@FileNameJoin@{NotebookDirectory[],"Linearise.m"};

Get@FileNameJoin@{NotebookDirectory[],"CriticalCases.m"};
Get@FileNameJoin@{NotebookDirectory[],"Unitarity.m"};

Off[Solve::svars];
CriticalCasesSolutions=First/@(Solve[#,{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda}]&/@CriticalCases);
On[Solve::svars];

Comment@"We are now ready to check that PSALTer is getting the physics right by running it on the 58 theories in arXiv:1910.14197.";

(*
ParticleSpectrum[
	"Case8",
	LineariseLagrangian[NonlinearLagrangian/.CriticalCasesSolutions[[8]]],
	TensorFields->{F,A},
	CouplingConstants->{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda},
	ExportTheory->True
];
*)

Get@FileNameJoin@{NotebookDirectory[],"CalibrateCase.m"};

(**)
CalibrationTimingData=MapThread[
		AbsoluteTiming@CalibrateCase[#1,#2,#3]&,
		{
			Table[i,{i,1,1}],
			CriticalCasesSolutions[[1;;1]],
			Unitarity[[1;;1]]
		}];

Comment@"Okay, that's all the cases. You can see from the timing below (in seconds) that each theory takes about a minute to process:";

Print@CalibrationTimingData;

DumpSave[FileNameJoin@{NotebookDirectory[],"CalibrationTimingData.mx"},{CalibrationTimingData}];
		(**)
Quit[];
