(*===========================*)
(*  MassiveAnalysisOfSector  *)
(*===========================*)

BuildPackage@"ParticleSpectrum/MassiveAnalysisOfSector/PoleToSquareMass.m";

MassiveAnalysisOfSector[RawSector_,Couplings_]:=Module[{
	Sector=RawSector,
	CouplingAssumptions,
	Poles,
	Singularities,
	SquareMassesValues},

	LocalSpectrum=" ** MassiveAnalysisOfSector...";

	Sector//=Together;

	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	Poles=Sector~FunctionPoles~xAct`PSALTer`Def;
	(*Singularities=Assuming[CouplingAssumptions,Sector~FunctionSingularities~xAct`PSALTer`En];*)

	SquareMassesValues=(
		First/@(
				(PoleToSquareMass/@Poles)~Cases~
				(
					Except@(_?((Variables@First@#~MemberQ~xAct`PSALTer`Mo)&))
				)
			)
		);

	SquareMassesValues//=DeleteDuplicates;
	SquareMassesValues//=DeleteCases[#,0,Infinity]&;
	SquareMassesValues//=DeleteCases[#,_?NumberQ]&;
	SquareMassesValues=FullSimplify/@SquareMassesValues;

SquareMassesValues];
