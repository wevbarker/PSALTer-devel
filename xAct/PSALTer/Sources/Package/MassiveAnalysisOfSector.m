(*===========================*)
(*  MassiveAnalysisOfSector  *)
(*===========================*)

PoleToSquareMass[Pole_List]:=Module[{Position=First@Pole,Order=Pole[[2]]},
	{Simplify@(Position^2-Mo^2),Order}];

ExpressInLightcone[RawSector_,SourceComponentsToFreeSourceVariables_List]:=Module[{
	PrintVariable,
	Sector=RawSector},

	PrintVariable={};
	PrintVariable=PrintVariable~Append~PrintTemporary@" ** MassiveAnalysisOfSector...";

	Sector//=NoScalar;
	Sector=Sector/.SourcePO3Activate;
	Sector//=NoScalar;
	Sector//=ToNewCanonical;
	Sector=Sector/.SourcePerpO3Activate;
	Sector//=NoScalar;
	Sector//=ToNewCanonical;
	Sector=Sector/.PADMPiActivate;
	Sector//=NoScalar;
	Sector//=ToNewCanonical;
	Sector=Sector/.PO3PiActivate;
	Sector//=NoScalar;
	Sector//=ToNewCanonical;
	Sector=Sector/.PADMActivate;
	Sector//=NoScalar;
	Sector//=ToNewCanonical;
	Sector=Sector/.SourceCompose;
	Sector//=xAct`xCoba`SeparateBasis[AIndex];
	Sector=Sector/.ToP;
	Sector=Sector/.SourceCompose;
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
	Sector=Sector/.xAct`xCoba`TensorValues[Tau];
	Sector=Sector/.xAct`xCoba`TensorValues[Sigma];
	Sector=Sector/.xAct`xCoba`TensorValues[Dagger@Tau];
	Sector=Sector/.xAct`xCoba`TensorValues[Dagger@Sigma];
	Sector=Sector/.{Def->Sqrt[En^2-Mo^2]};
	Sector//=Together;

	PrintVariable=PrintVariable~Append~PrintTemporary[" ** Imposing conserved sources..."];
	Sector=Sector/.SourceComponentsToFreeSourceVariables;
	Sector//=Together;

	NotebookDelete@PrintVariable;

Sector];

MassiveAnalysisOfSectorList[RawSector_List]:=Module[{
	PrintVariable,
	Sector=Total@RawSector,
	Poles,
	SquareMassesValues},

	PrintVariable={};
	PrintVariable=PrintVariable~Append~PrintTemporary@" ** MassiveAnalysisOfSector...";

	Sector//=Together;

	Poles=Sector~FunctionPoles~En;

	SquareMassesValues=(
		First/@(
				(PoleToSquareMass/@Poles)~Cases~
				(
					Except@(_?((Variables@First@#~MemberQ~Mo)&))
				)
			)
		);

	SquareMassesValues//=DeleteDuplicates;
	SquareMassesValues//=DeleteCases[#,0,Infinity]&;

SquareMassesValues];

MassiveAnalysisOfSector[RawSector_,SourceComponentsToFreeSourceVariables_List]:=Module[{
	PrintVariable,
	Sector=RawSector,
	Poles,
	SquareMassesValues},

	PrintVariable={};
	PrintVariable=PrintVariable~Append~PrintTemporary@" ** MassiveAnalysisOfSector...";

	Sector//=NoScalar;
	Sector=Sector/.SourcePO3Activate;
	Sector//=NoScalar;
	Sector//=ToNewCanonical;
	Sector=Sector/.SourcePerpO3Activate;
	Sector//=NoScalar;
	Sector//=ToNewCanonical;
	Sector=Sector/.PADMPiActivate;
	Sector//=NoScalar;
	Sector//=ToNewCanonical;
	Sector=Sector/.PO3PiActivate;
	Sector//=NoScalar;
	Sector//=ToNewCanonical;
	Sector=Sector/.PADMActivate;
	Sector//=NoScalar;
	Sector//=ToNewCanonical;
	Sector=Sector/.SourceCompose;
	Sector//=xAct`xCoba`SeparateBasis[AIndex];
	Sector=Sector/.ToP;
	Sector=Sector/.SourceCompose;
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
	Sector=Sector/.xAct`xCoba`TensorValues[Tau];
	Sector=Sector/.xAct`xCoba`TensorValues[Sigma];
	Sector=Sector/.xAct`xCoba`TensorValues[Dagger@Tau];
	Sector=Sector/.xAct`xCoba`TensorValues[Dagger@Sigma];
	Sector=Sector/.{Def->Sqrt[En^2-Mo^2]};
	Sector//=Together;

	PrintVariable=PrintVariable~Append~PrintTemporary[" ** Imposing conserved sources..."];
	Sector=Sector/.SourceComponentsToFreeSourceVariables;
	Sector//=Together;

	NotebookDelete@PrintVariable;

	Poles=Sector~FunctionPoles~En;

	SquareMassesValues=(
		First/@(
				(PoleToSquareMass/@Poles)~Cases~
				(
					Except@(_?((Variables@First@#~MemberQ~Mo)&))
				)
			)
		);

	SquareMassesValues//=DeleteDuplicates;
	SquareMassesValues//=DeleteCases[#,0,Infinity]&;

{Sector,SquareMassesValues}];
