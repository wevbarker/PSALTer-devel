(*===============*)
(*  MakeResidue  *)
(*===============*)

BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/MakeResidue/ConstrainInLightcone.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/MakeResidue/NullResidue.m";

MakeResidue[ClassName_?StringQ,RawSector_,SourceComponentsToFreeSourceVariables_List]:=Module[{
	Class,
	Sector=RawSector},

	Sector//=ConstrainInLightcone[ClassName,#,SourceComponentsToFreeSourceVariables]&;
	Sector//=NullResidue[#,1]&;
	Sector//=Expand;
Sector];
