(*======================*)
(*  ExpressInLightcone  *)
(*======================*)

ExpressInLightcone[ClassName_?StringQ,RawSector_,SourceComponentsToFreeSourceVariables_List]:=Module[{
	Class,
	Sector=RawSector},

	Class=Evaluate@Symbol@ClassName;

	LocalSpectrum=" ** MassiveAnalysisOfSector...";

	Sector//=Class@ExpandSources;

	Sector//=xAct`xCoba`SeparateBasis[AIndex];
	Sector=Sector/.ToP;
	Sector//=NoScalar;
	Sector//=ToNewCanonical;
	Sector=Sector/.ToV;
	Sector//=ToNewCanonical;
	Sector=Sector/.ToP;
	Sector//=xAct`xCoba`SeparateBasis[AIndex];
	Sector//=NoScalar;
	Sector=Sector/.ToP;
	Sector//=ToNewCanonical;
	Sector//=NoScalar;

	LocalSpectrum=" ** SeparateMetric...";
	Sector=SeparateMetric[G][Evaluate@Sector];

	LocalSpectrum=" ** SeparateBasis...";
	Sector//=xAct`xCoba`SeparateBasis[cartesian];

	LocalSpectrum=" ** ContractBasis...";
	Sector//=xAct`xCoba`ContractBasis;

	LocalSpectrum=" ** TraceBasisDummy...";
	Sector//=xAct`xCoba`TraceBasisDummy;

	LocalSpectrum=" ** TensorValues...";
	Sector=Sector/.xAct`xCoba`TensorValues[P];
	Sector=Sector/.xAct`xCoba`TensorValues[G];

	(Sector=Sector/.xAct`xCoba`TensorValues[#])&/@(Class@Sources);
	(Sector=Sector/.xAct`xCoba`TensorValues[#])&/@(Dagger/@(Class@Sources));

	Sector=Sector/.{Def->Sqrt[En^2-Mo^2]};
	Sector//=Together;

	LocalSpectrum=" ** Imposing conserved sources...";
	Sector=Sector/.SourceComponentsToFreeSourceVariables;
	Sector//=Together;

Sector];
