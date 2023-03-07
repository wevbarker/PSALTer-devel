(*======================*)
(*  ExpressInLightcone  *)
(*======================*)

ExpressInLightcone[ClassName_?StringQ,RawSector_,SourceComponentsToFreeSourceVariables_List]:=Module[{
	Class,
	PrintVariable,
	Sector=RawSector},

	Class=Evaluate@Symbol@ClassName;

	PrintVariable={};
	PrintVariable=PrintVariable~Append~PrintTemporary@" ** MassiveAnalysisOfSector...";

	Sector//=Class@FirstSpeciousFunction;
(*
	Sector//=xAct`xCoba`SeparateBasis[AIndex];
	Sector=Sector/.ToP;

	Sector//=Class@SecondSpeciousFunction;
*)

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

	PrintVariable=PrintVariable~Append~PrintTemporary[" ** SeparateMetric..."];
	Sector=SeparateMetric[G][Evaluate@Sector];

	PrintVariable=PrintVariable~Append~PrintTemporary[" ** SeparateBasis..."];
	Sector//=xAct`xCoba`SeparateBasis[cartesian];

	PrintVariable=PrintVariable~Append~PrintTemporary[" ** ContractBasis..."];
	Sector//=xAct`xCoba`ContractBasis;

	PrintVariable=PrintVariable~Append~PrintTemporary[" ** TraceBasisDummy..."];
	Sector//=xAct`xCoba`TraceBasisDummy;

	PrintVariable=PrintVariable~Append~PrintTemporary[" ** TensorValues..."];
	Sector=Sector/.xAct`xCoba`TensorValues[P];
	Sector=Sector/.xAct`xCoba`TensorValues[G];

	(Sector=Sector/.xAct`xCoba`TensorValues[#])&/@(Class@Sources);
	(Sector=Sector/.xAct`xCoba`TensorValues[#])&/@(Dagger/@(Class@Sources));

	Sector=Sector/.{Def->Sqrt[En^2-Mo^2]};
	Sector//=Together;

	PrintVariable=PrintVariable~Append~PrintTemporary[" ** Imposing conserved sources..."];
	Sector=Sector/.SourceComponentsToFreeSourceVariables;
	Sector//=Together;

	NotebookDelete@PrintVariable;

Sector];
