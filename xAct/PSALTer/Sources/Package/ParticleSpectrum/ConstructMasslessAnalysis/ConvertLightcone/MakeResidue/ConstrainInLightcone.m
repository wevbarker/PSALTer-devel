(*========================*)
(*  ConstrainInLightcone  *)
(*========================*)

ConstrainInLightcone[ClassName_?StringQ,RawSector_,SourceComponentsToFreeSourceVariables_List]:=Module[{
	Class,
	Sector=RawSector},

	LocalMasslessSpectrum=" ** Imposing conserved sources...";
	Sector//=GradualExpand[CouplingAssumptions,#,SourceComponentsToFreeSourceVariables]&;
	Sector//=Expand;
Sector];
