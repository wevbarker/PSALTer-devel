(*====================*)
(*  ParticleSpectrum  *)
(*====================*)

BuildPackage@"ParticleSpectrum/UpdateTheoryAssociation.m";
BuildPackage@"ParticleSpectrum/WignerGrid.m";
BuildPackage@"ParticleSpectrum/RaggedBlock.m";
BuildPackage@"ParticleSpectrum/SummariseResults.m";
BuildPackage@"ParticleSpectrum/ParticleSpectrumSummary.m";
BuildPackage@"ParticleSpectrum/PSALTerParallelSubmit.m";
BuildPackage@"ParticleSpectrum/PrintSpectrum.m";

BuildPackage@"ParticleSpectrum/ConstructLinearAction.m";
BuildPackage@"ParticleSpectrum/ConstructWaveOperator.m";
BuildPackage@"ParticleSpectrum/ConstructSourceConstraints.m";
BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator.m";
BuildPackage@"ParticleSpectrum/ConstructMassiveAnalysis.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis.m";
BuildPackage@"ParticleSpectrum/ConstructUnitarityConditions.m";

Options@ParticleSpectrum={
	TensorFields->{},
	CouplingConstants->{},
	ExportTheory->False,
	Method->"Careful"};

ParticleSpectrum[ClassName_?StringQ,TheoryName_?StringQ,Expr_,OptionsPattern[]]:=Module[{
	SummariseResultsOngoing,
	Couplings=OptionValue@CouplingConstants,
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
				Couplings,
				Method->OptionValue@Method];
	UpdateTheoryAssociation[
				TheoryName,
				InverseBMatrices,
				ValuesInverseBMatricesValues,
				ExportTheory->OptionValue@ExportTheory];


	ConstructMassiveAnalysis[
				Couplings,
				ValuesSaturatedPropagator,
				ValuesInverseBMatricesValues,
				BlockMassSigns];
	UpdateTheoryAssociation[
				TheoryName,
				SquareMasses,
				MassiveAnalysis,
				ExportTheory->OptionValue@ExportTheory];


	ConstructMasslessAnalysis[
				ClassName,
				ValuesOfSourceConstraints,
				ValuesSaturatedPropagator];
	UpdateTheoryAssociation[
				TheoryName,
				MasslessEigenvalues,
				MasslessAnalysisValue,
				ExportTheory->OptionValue@ExportTheory];
	UpdateTheoryAssociation[
				TheoryName,
				SourceConstraintComponents,
				ConstraintComponentList,
				ExportTheory->OptionValue@ExportTheory];


	ConstructUnitarityConditions[
				MassiveAnalysis,
				MassiveGhostAnalysis,
				MasslessAnalysisValue,
				Couplings];
	UpdateTheoryAssociation[
				TheoryName,
				PositiveSystem,
				PositiveSystemValue,
				ExportTheory->OptionValue@ExportTheory];


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
