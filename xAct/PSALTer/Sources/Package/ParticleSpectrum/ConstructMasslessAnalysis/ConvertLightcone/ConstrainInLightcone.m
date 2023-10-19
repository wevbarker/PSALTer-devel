(*========================*)
(*  ConstrainInLightcone  *)
(*========================*)

ConstrainInLightcone[ClassName_?StringQ,RawSector_,SourceComponentsToFreeSourceVariables_List]:=Module[{
	Class,
	Sector=RawSector},

	LocalMasslessSpectrum=" ** Imposing conserved sources...";
	(*Sector=Sector/.SourceComponentsToFreeSourceVariables;*)
	Sector=GradualExpand[CouplingAssumptions,Sector,SourceComponentsToFreeSourceVariables];
	(*Sector//=Together;*)
	Sector//=Expand;

Sector];
