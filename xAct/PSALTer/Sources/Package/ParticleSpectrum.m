(*====================*)
(*  ParticleSpectrum  *)
(*====================*)

BuildPackage@"ParticleSpectrum/UpdateTheoryAssociation.m";
BuildPackage@"ParticleSpectrum/WignerGrid.m";
BuildPackage@"ParticleSpectrum/RaggedBlock.m";
BuildPackage@"ParticleSpectrum/SummariseResults.m";
BuildPackage@"ParticleSpectrum/MakeConstraintComponentList.m";
BuildPackage@"ParticleSpectrum/ConstraintComponentToLightcone.m";
BuildPackage@"ParticleSpectrum/AllIndependentComponents.m";
BuildPackage@"ParticleSpectrum/RescaleNullVector.m";
BuildPackage@"ParticleSpectrum/MakeFreeSourceVariables.m";
BuildPackage@"ParticleSpectrum/MassiveAnalysisOfSector.m";
BuildPackage@"ParticleSpectrum/MassiveGhost.m";
BuildPackage@"ParticleSpectrum/ExpressInLightcone.m";
BuildPackage@"ParticleSpectrum/NullResidue.m";
BuildPackage@"ParticleSpectrum/MasslessAnalysisOfTotal.m";
BuildPackage@"ParticleSpectrum/ParticleSpectrumSummary.m";
BuildPackage@"ParticleSpectrum/Unitarity.m";
BuildPackage@"ParticleSpectrum/PSALTerParallelSubmit.m";
BuildPackage@"ParticleSpectrum/PrintSpectrum.m";

BuildPackage@"ParticleSpectrum/ConstructLinearAction.m";
BuildPackage@"ParticleSpectrum/ConstructWaveOperator.m";
BuildPackage@"ParticleSpectrum/ConstructSourceConstraints.m";
BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator.m";

Options@ParticleSpectrum={
	TensorFields->{},
	CouplingConstants->{},
	ExportTheory->False,
	Method->"Careful"};

ParticleSpectrum[ClassName_?StringQ,TheoryName_?StringQ,Expr_,OptionsPattern[]]:=Module[{
	SummariseResultsOngoing,
	TheTensors=OptionValue@TensorFields,
	Couplings=OptionValue@CouplingConstants,
	SaturatedPropagatorArray,
	ConstraintComponentList,
	SourceComponents,
	UnscaledNullSpace,
	LightconePropagator,
	MassiveAnalysis,
	SignedInverseBMatrices,
	MassiveGhostAnalysis,
	MasslessPropagatorResidue,
	RescaledNullSpace,
	SourceComponentsToFreeSourceVariables,
	MasslessAnalysis,
	MasslessEigenvaluesValues,
	MasslessAnalysisValue,
	PositiveSystem,
	PositiveSystemValue,
	Class
},

	LocalWaveOperator=Null;
	LocalPropagator=Null;
	LocalSourceConstraints=Null;
	LocalSpectrum=Null;
	LocalOverallUnitarity=Null;
	LocalSummaryOfTheory=Null;

	SummariseResultsOngoing=PrintTemporary@Dynamic[Refresh[SummariseResults[
			LocalWaveOperator,
			LocalPropagator,
			LocalSourceConstraints,
			LocalSpectrum,
			LocalOverallUnitarity,
			LocalSummaryOfTheory],
		TrackedSymbols->{
			LocalWaveOperator,
			LocalPropagator,
			LocalSourceConstraints,
			LocalSpectrum,
			LocalOverallUnitarity,
			LocalSummaryOfTheory}]];

	ConstructLinearAction[
				ClassName,
				Expr];
	ConstructWaveOperator[
				ClassName,
				Expr,
				Couplings];
	UpdateTheoryAssociation[
				TheoryName,
				BMatrices,
				ValuesAllMatrices,
				ExportTheory->OptionValue@ExportTheory];
	UpdateTheoryAssociation[
				TheoryName,
				MomentumSpaceLagrangian,
				DecomposeFieldsdLagrangian,
				ExportTheory->OptionValue@ExportTheory];
	ConstructSourceConstraints[
				ClassName,
				CouplingAssumptions,
				Rescalings,
				RaisedIndexSources,
				MatrixLagrangian,
				Method->OptionValue@Method];
	UpdateTheoryAssociation[
				TheoryName,
				SourceConstraints,
				ValuesOfSourceConstraints,
				ExportTheory->OptionValue@ExportTheory];
	ConstructSaturatedPropagator[
				ClassName,
				MatrixLagrangian,
				CouplingAssumptions,
				BMatricesValues,
				RaisedIndexSources,
				LoweredIndexSources,
				FieldSpinParityTensorHeadsValue,
				FieldsLeft,
				FieldsTop,
				SourcesLeft,
				SourcesTop,
				Couplings,
				Method->OptionValue@Method];
	(*ConstructParticleSpectrum[];*)
	(*ConstructUnitarityConditions[];*)

	UpdateTheoryAssociation[TheoryName,InverseBMatrices,ValuesInverseBMatricesValues,ExportTheory->OptionValue@ExportTheory];

	LocalWaveOperator=WignerGrid[((Plus@@#)&/@Partition[ValuesAllMatrices,2]),SaturatedPropagator[[6]],SaturatedPropagator[[7]],SaturatedPropagator[[8]],SaturatedPropagator[[9]]];
	LocalSourceConstraints=RaggedBlock[(((Simplify@(#==0))&)/@(ValuesOfSourceConstraints)),2];
	LocalPropagator=WignerGrid[((Plus@@#)&/@Partition[ValuesInverseBMatricesValues,2]),SaturatedPropagator[[6]],SaturatedPropagator[[7]],SaturatedPropagator[[10]],SaturatedPropagator[[11]]];

	(*======================*)
	(*  Source constraints  *)
	(*======================*)

	ConstraintComponentList=MakeConstraintComponentList[ClassName,ValuesOfSourceConstraints];
	Diagnostic@ConstraintComponentList;
	ConstraintComponentList=xAct`xCoba`SeparateBasis[AIndex][#]&/@ConstraintComponentList;
	Diagnostic@ConstraintComponentList;

	ConstraintComponentList=(xAct`PSALTer`Private`PSALTerParallelSubmit@(ConstraintComponentToLightcone[ClassName,#]))&/@ConstraintComponentList;
	ConstraintComponentList=WaitAll@ConstraintComponentList;
	Diagnostic@ConstraintComponentList;

	ConstraintComponentList=DeleteCases[ConstraintComponentList,True];
	Diagnostic@ConstraintComponentList;
	UpdateTheoryAssociation[TheoryName,SourceConstraintComponents,ConstraintComponentList,ExportTheory->OptionValue@ExportTheory];

	SourceComponents=AllIndependentComponents[ClassName];
	Diagnostic@SourceComponents;

	If[ConstraintComponentList==={},	
		UnscaledNullSpace=IdentityMatrix@Length@SourceComponents,
		UnscaledNullSpace=NullSpace@Last@(ConstraintComponentList~CoefficientArrays~SourceComponents);
	];
	Diagnostic@UnscaledNullSpace;

	RescaledNullSpace=RescaleNullVector[ClassName,SourceComponents,#]&/@UnscaledNullSpace;
	Diagnostic@RescaledNullSpace;

	SourceComponentsToFreeSourceVariables=MakeFreeSourceVariables[RescaledNullSpace,SourceComponents];
	Diagnostic@SourceComponentsToFreeSourceVariables;

	(*====================*)
	(*  Massive analysis  *)
	(*====================*)

	MassiveAnalysis=MapThread[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(MassiveAnalysisOfSector[#1,#2]))&,
		{(ValuesSaturatedPropagator),
		Couplings~ConstantArray~(Length@(ValuesSaturatedPropagator))}];
	MassiveAnalysis=WaitAll@MassiveAnalysis;

	SignedInverseBMatrices=Times~MapThread~{(ValuesInverseBMatricesValues),(SaturatedPropagator[[5]])};

	MassiveGhostAnalysis=MapThread[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(MassiveGhost[#1,#2]))&,
		{SignedInverseBMatrices,
		MassiveAnalysis}];
	MassiveGhostAnalysis=WaitAll@MassiveGhostAnalysis;

	UpdateTheoryAssociation[TheoryName,SquareMasses,MassiveAnalysis,ExportTheory->OptionValue@ExportTheory];

	(*=============*)
	(*  Lightcone  *)
	(*=============*)

	SaturatedPropagatorArray=(If[Head@#===Plus,List@@#,List@#])&/@(ValuesSaturatedPropagator);
	Diagnostic@SaturatedPropagatorArray;

	SaturatedPropagatorArray//=(#~PadRight~{Length@#,First@((Length/@#)~TakeLargest~1)})&;
	Diagnostic@SaturatedPropagatorArray;

	LightconePropagator=MapThread[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(ExpressInLightcone[ClassName,#1,#2]))&,
		{SaturatedPropagatorArray,
		Map[((SourceComponentsToFreeSourceVariables)&),SaturatedPropagatorArray,{2}]},2];
	LightconePropagator=WaitAll@LightconePropagator;
	Diagnostic@LightconePropagator;

	(*=====================*)
	(*  Massless analysis  *)
	(*=====================*)

	MasslessPropagatorResidue=Map[(xAct`PSALTer`Private`PSALTerParallelSubmit@(NullResidue@#))&,LightconePropagator,{2}];
	MasslessPropagatorResidue=WaitAll@MasslessPropagatorResidue;
	Diagnostic@MasslessPropagatorResidue;

	MasslessAnalysis=MasslessAnalysisOfTotal[MasslessPropagatorResidue,UnscaledNullSpace];
	Diagnostic@MasslessAnalysis;
	MasslessAnalysisValue=MasslessAnalysis[[2]];

	UpdateTheoryAssociation[TheoryName,MasslessEigenvalues,MasslessAnalysisValue,ExportTheory->OptionValue@ExportTheory];

	(*================================*)
	(*  Summary of particle spectrum  *)
	(*================================*)

	LocalSpectrum=PrintSpectrum[MassiveAnalysis,MassiveGhostAnalysis,MasslessAnalysisValue];

	(*=============*)
	(*  Unitarity  *)
	(*=============*)

	LocalOverallUnitarity=Unitarity[
		MassiveAnalysis,MassiveGhostAnalysis,MasslessAnalysisValue,Couplings];

	UpdateTheoryAssociation[TheoryName,PositiveSystem,PositiveSystemValue,ExportTheory->OptionValue@ExportTheory];

	FinishDynamic[];
	NotebookDelete@SummariseResultsOngoing;
	Print@SummariseResults[
		LocalWaveOperator,
		LocalPropagator,
		LocalSourceConstraints,
		LocalSpectrum,
		LocalOverallUnitarity,
		LocalSummaryOfTheory];
];
