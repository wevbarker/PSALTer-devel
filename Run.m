(*=======*)
(*  Run  *)
(*=======*)

Print@"First we load the PSALTer package:";

<<xAct`PSALTer`;

Print@"Now we set up the general Lagrangian:";

Get@FileNameJoin@{Directory[],"LagrangianKarananasCouplings.m"};
(*Get@FileNameJoin@{Directory[],"LagrangianHayashiShirafujiCouplings.m"};*)

Print@NonlinearLagrangian;

Print@"We also knock up some simple tools to linearise the Lagrangian:";

Get@FileNameJoin@{Directory[],"Linearise.m"};

Print@"Next we write down all the cases which define the theories in
arXiv:1910.14197:";

Get@FileNameJoin@{Directory[],"CriticalCases.m"};

Print/@CriticalCases;

Print@"Now we wish to solve for these:";

Off[Solve::svars];
CriticalCasesSolutions=First/@(Solve[#,{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda}]&/@CriticalCases);
On[Solve::svars];
Print/@CriticalCasesSolutions;

Print@"Now to perform the calibration";

MapThread[
		ParticleSpectroom[
			"Case"<>ToString@#1,
			LineariseLagrangian[NonlinearLagrangian/.#2],
			F,
			A,
			ExportTheory->True
		]&,
		{
			Table[i,{i,1,8}],
			CriticalCasesSolutions[[1;;8]]
		}];
Quit[];
