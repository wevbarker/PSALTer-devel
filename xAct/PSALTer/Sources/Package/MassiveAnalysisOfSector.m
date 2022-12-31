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

MassiveAnalysisOfSectorList[RawSector_List,Couplings_]:=Module[{
	PrintVariable,
	Sector=Total@RawSector,
	CouplingAssumptions,
	Poles,
	Singularities,
	SquareMassesValues},

	PrintVariable={};
	PrintVariable=PrintVariable~Append~PrintTemporary@" ** MassiveAnalysisOfSector...";

	Sector//=Together;


	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	CouplingAssumptions~AppendTo~(xAct`PSALTer`Def~Element~Reals);
	CouplingAssumptions~AppendTo~(xAct`PSALTer`Mo~Element~Reals);
	Poles=Assuming[CouplingAssumptions,Sector~FunctionPoles~xAct`PSALTer`En];
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

SquareMassesValues];

MassiveAnalysisOfSector[RawSector,Couplings_]:=Module[{
	PrintVariable,
	Sector=RawSector,
	CouplingAssumptions,
	Poles,
	Singularities,
	SquareMassesValues},

	PrintVariable={};
	PrintVariable=PrintVariable~Append~PrintTemporary@" ** MassiveAnalysisOfSector...";

	Sector//=Together;


	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	CouplingAssumptions~AppendTo~(xAct`PSALTer`Def~Element~Reals);
	CouplingAssumptions~AppendTo~(xAct`PSALTer`Mo~Element~Reals);
	Poles=Assuming[CouplingAssumptions,Sector~FunctionPoles~xAct`PSALTer`En];
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

SquareMassesValues];
