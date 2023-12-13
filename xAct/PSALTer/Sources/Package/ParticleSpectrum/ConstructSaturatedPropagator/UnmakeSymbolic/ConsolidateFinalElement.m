(*===========================*)
(*  ConsolidateFinalElement  *)
(*===========================*)

ConsolidateFinalElement[FinalElement_]:=Module[{
	CouplingAssumptions,
	FullElement},

	{CouplingAssumptions,FullElement}=FinalElement;
	Assuming[CouplingAssumptions,FullElement//=FullSimplify];	
FullElement];
