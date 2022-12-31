(*=============*)
(*  Unitarity  *)
(*=============*)

Unitarity[MassiveAnalysis_,MassiveGhostAnalysis_,MasslessAnalysisValue_,Couplings_]:=Module[{
	PositiveSystem=Join[MassiveAnalysis,MassiveGhostAnalysis,MasslessAnalysisValue],
	CouplingAssumptions
	},

	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	CouplingAssumptions~AppendTo~(xAct`PSALTer`Mo>0);

	PositiveSystem//=Flatten;
	PositiveSystem=(#>0)&/@PositiveSystem;
	dfd=PositiveSystem;
	Print@Assuming[CouplingAssumptions,FullSimplify[dfd]];
	Print@PositiveSystem;
	PositiveSystem//=Assuming[CouplingAssumptions,Reduce[#,Couplings]]&;
	Print@PositiveSystem;
PositiveSystem];
