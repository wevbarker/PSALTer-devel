(*===========================*)
(*  ConsolidateFinalElement  *)
(*===========================*)

ConsolidateFinalElement[FinalElement_]:=Module[{
	CouplingAssumptions,
	FullElement},

	{CouplingAssumptions,FullElement}=FinalElement;
	TimeConstrained[
	(
		Assuming[CouplingAssumptions,FullElement//=FullSimplify];	
	)
	,
	500,
	(
		TimeConstrained[
		(
			Assuming[CouplingAssumptions,FullElement//=Simplify];	
		),500];
	)
	];
FullElement];
