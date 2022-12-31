(*===========================*)
(*  MassiveAnalysisOfSector  *)
(*===========================*)

NewPoleToSquareMass[Pole_List]:=Module[{Position=First@Pole,Order=Pole[[2]]},
	{Simplify@(Position^2),Order}];

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

MassiveAnalysisOfSector[RawSector_,Couplings_]:=Module[{
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
	Poles=Sector~FunctionPoles~xAct`PSALTer`Def;
	(*Singularities=Assuming[CouplingAssumptions,Sector~FunctionSingularities~xAct`PSALTer`En];*)

	SquareMassesValues=(
		First/@(
				(NewPoleToSquareMass/@Poles)~Cases~
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

MassiveGhost[InverseBMatrix_,SquareMassesValues_]:=Module[{
	InverseBMatrixTrace,
	SquareDef,
	TraceResidue},

	If[!(Length@SquareMassesValues===0),
		InverseBMatrixTrace=Tr@InverseBMatrix;
		InverseBMatrixTrace//=Simplify;
		InverseBMatrixTrace=InverseBMatrixTrace/.{Def->Sqrt@SquareDef};
		InverseBMatrixTrace//=Simplify;
		TraceResidue=InverseBMatrixTrace~Residue~{SquareDef,First@SquareMassesValues};
		TraceResidue//=Simplify;
		TraceResidue//=List;,
		TraceResidue={};
	];
TraceResidue];
