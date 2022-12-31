(*=============*)
(*  Unitarity  *)
(*=============*)

Unitarity[MassiveAnalysis_,MassiveGhostAnalysis_,MasslessAnalysisValue_,Couplings_]:=Module[{
	PositiveSystem=Join[MassiveAnalysis,MassiveGhostAnalysis,MasslessAnalysisValue],
	CouplingAssumptions
	},

	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	CouplingAssumptions~AppendTo~(xAct`PSALTer`Mo~Element~Reals);

	PositiveSystem//=Flatten;
	PositiveSystem=(#>0)&/@PositiveSystem;
	PositiveSystem~AppendTo~(xAct`PSALTer`Mo>0);
	dfd=PositiveSystem;
	Print@Assuming[CouplingAssumptions,Solve[dfd,Couplings]];
	Print@Assuming[CouplingAssumptions,FullSimplify[dfd]];
	Print@PositiveSystem;
	PositiveSystem//=Assuming[CouplingAssumptions,Reduce[#,Couplings]]&;
	Print@PositiveSystem;
PositiveSystem];
