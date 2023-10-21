(*===============*)
(*  MakeResidue  *)
(*===============*)

BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/MakeResidue/ConstrainInLightcone.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/MakeResidue/NullResidue.m";

MakeResidue[RawSector_,SourceComponentsToFreeSourceVariables_List]:=Module[{
	Sector=RawSector},

	Sector//=ConstrainInLightcone[#,SourceComponentsToFreeSourceVariables]&;
	Sector//=NullResidue[#,1]&;
	Sector//=Expand;
Sector];
