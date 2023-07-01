(*=============*)
(*  Unitarity  *)
(*=============*)

Unitarity[MassiveAnalysis_,MassiveGhostAnalysis_,MasslessAnalysisValue_,Couplings_]:=Module[{
	PositiveSystem=Join[MassiveAnalysis,MassiveGhostAnalysis,MasslessAnalysisValue],
	CouplingAssumptions
	},
	
	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	Diagnostic@CouplingAssumptions;
	CouplingAssumptions~AppendTo~(xAct`PSALTer`Mo>0);
	Diagnostic@CouplingAssumptions;

	PositiveSystem//=Flatten;
	Diagnostic@PositiveSystem;
	PositiveSystem=(#>0)&/@PositiveSystem;
	Diagnostic@PositiveSystem;
	PositiveSystem=PositiveSystem/.{Mo->1,En->1,Def->1};
	(*Quiet wrapper used since there are some PrintAs warnings*)
	PositiveSystem//=Quiet@Assuming[CouplingAssumptions,Reduce[#,Couplings]]&;
	Diagnostic@PositiveSystem;
PositiveSystem];
