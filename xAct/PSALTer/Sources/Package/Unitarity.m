(*=============*)
(*  Unitarity  *)
(*=============*)

Unitarity[MassiveAnalysis_,MassiveGhostAnalysis_,MasslessAnalysisValue_,Couplings_]:=Module[{
	PositiveSystem=Join[MassiveAnalysis,MassiveGhostAnalysis,MasslessAnalysisValue]
	},

	PositiveSystem//=Flatten;
	PositiveSystem=(#>0)&/@PositiveSystem;
	PositiveSystem~AppendTo~(xAct`PSALTer`Mo>0);
	Print@PositiveSystem;
	PositiveSystem=Reduce[#,Couplings]&;
	Print@PositiveSystem;
PositiveSystem];
