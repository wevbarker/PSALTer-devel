(*===========================*)
(*  MassiveAnalysisOfSector  *)
(*===========================*)

BuildPackage@"ParticleSpectrum/ConstructMassiveAnalysis/PoleToSquareMass.m";
BuildPackage@"ParticleSpectrum/ConstructMassiveAnalysis/MassiveAnalysisOfSector/IsolatePoles.m";

Options@MassiveAnalysisOfSector={
	Method->"Careful"};
MassiveAnalysisOfSector[SpinParitySectorFileName_,Couplings_,OptionsPattern[]]:=Module[{
	Sector,
	InputDenominator,
	CouplingAssumptions,
	Poles,
	Singularities,
	SquareMassesValues},

	LocalSpectrum=" ** MassiveAnalysisOfSector...";

	Get@SpinParitySectorFileName;
	Sector=ToExpression@"xAct`PSALTer`Private`SpinParitySector";
	Sector//=Together;

	InputDenominator=Denominator@Sector;
	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	SquareMassesValues=IsolatePoles[InputDenominator,CouplingAssumptions];

	Switch[OptionValue@Method,
		"Careful",
		(
		Sector=(1/InputDenominator);
		Poles=Sector~FunctionPoles~xAct`PSALTer`Def;
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
		),
		"Careless",
		(
		Null;
		)
	];
SquareMassesValues];
