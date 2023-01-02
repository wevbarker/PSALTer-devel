(*====================*)
(*  ParticleSpectrum  *)
(*====================*)

Options@ParticleSpectrum={
	TensorFields->{},
	CouplingConstants->{},
	ExportTheory->False};

ParticleSpectrum[TheoryName_?StringQ,Expr_,OptionsPattern[]]:=Module[{
	Tensors=OptionValue@TensorFields,
	Couplings=OptionValue@CouplingConstants,
	PrintVariable,
	FourierDecomposedLagrangian,
	SaturatedPropagator,
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
	PositiveSystemValue},

	PrintVariable={};
	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ParticleSpectrum...";

	(*=========================*)
	(*  Fourier decomposition  *)
	(*=========================*)

	FourierDecomposedLagrangian=FourierLagrangian[Expr,Tensors];
	UpdateTheoryAssociation[TheoryName,MomentumSpaceLagrangian,FourierDecomposedLagrangian,ExportTheory->OptionValue@ExportTheory];

	(*========================*)
	(*  Saturated propagator  *)
	(*========================*)

	SaturatedPropagator=ConstructSaturatedPropagator[FourierDecomposedLagrangian,Couplings];
	UpdateTheoryAssociation[TheoryName,BMatrices,SaturatedPropagator[[3]],ExportTheory->OptionValue@ExportTheory];
	UpdateTheoryAssociation[TheoryName,InverseBMatrices,SaturatedPropagator[[4]],ExportTheory->OptionValue@ExportTheory];

	Print@"The (possibly singular) \[ScriptA]-matrices associated with the Lagrangian, as defined below Eq. (18) of arXiv:1812.02675:";
	Print@(MatrixForm/@(SaturatedPropagator[[3]]));

	Print@"Gauge constraints on source currents:";
	Print@(((Simplify@(#==0))&)/@(SaturatedPropagator[[1]]));

	Print@"The Drazin (Moore-Penrose) inverses of these \[ScriptA]-matrices, which are functionally analogous to the inverse \[ScriptB]-matrices described below Eq. (21) of arXiv:1812.02675:";
	Print@(MatrixForm/@(SaturatedPropagator[[4]]));

	(*======================*)
	(*  Source constraints  *)
	(*======================*)

	ConstraintComponentList=MakeConstraintComponentList[SaturatedPropagator[[1]]];
	ConstraintComponentList=xAct`xCoba`SeparateBasis[AIndex][#]&/@ConstraintComponentList;

	ConstraintComponentList=(xAct`HiGGS`Private`HiGGSParallelSubmit@(ConstraintComponentToLightcone@#))&/@ConstraintComponentList;
	PrintVariable=PrintTemporary@ConstraintComponentList;
	ConstraintComponentList=WaitAll@ConstraintComponentList;
	NotebookDelete@PrintVariable;

	ConstraintComponentList=DeleteCases[ConstraintComponentList,True];
	UpdateTheoryAssociation[TheoryName,SourceConstraintComponents,ConstraintComponentList,ExportTheory->OptionValue@ExportTheory];

	SourceComponents=IndependentComponents[Sigma[-a,-b,-c],Tau[-a,-b]];

	UnscaledNullSpace=NullSpace@Last@(ConstraintComponentList~CoefficientArrays~SourceComponents);
	RescaledNullSpace=RescaleNullVector/@UnscaledNullSpace;

	SourceComponentsToFreeSourceVariables=MakeFreeSourceVariables[RescaledNullSpace,SourceComponents];

	(*====================*)
	(*  Massive analysis  *)
	(*====================*)

	MassiveAnalysis=MapThread[
		(xAct`HiGGS`Private`HiGGSParallelSubmit@(MassiveAnalysisOfSector[#1,#2]))&,
		{(SaturatedPropagator[[2]]),
		Couplings~ConstantArray~(Length@(SaturatedPropagator[[2]]))}];
	PrintVariable=PrintTemporary@MassiveAnalysis;
	MassiveAnalysis=WaitAll@MassiveAnalysis;
	NotebookDelete@PrintVariable;

	Print@"Square masses:";
	Print@MassiveAnalysis;

	SignedInverseBMatrices=Times~MapThread~{(SaturatedPropagator[[4]]),{1,-1,1,-1,1,-1}};

	MassiveGhostAnalysis=MapThread[
		(xAct`HiGGS`Private`HiGGSParallelSubmit@(MassiveGhost[#1,#2]))&,
		{SignedInverseBMatrices,
		MassiveAnalysis}];
	PrintVariable=PrintTemporary@MassiveGhostAnalysis;
	MassiveGhostAnalysis=WaitAll@MassiveGhostAnalysis;
	NotebookDelete@PrintVariable;

	Print@"Massive pole residues:";
	Print@MassiveGhostAnalysis;

	UpdateTheoryAssociation[TheoryName,SquareMasses,MassiveAnalysis,ExportTheory->OptionValue@ExportTheory];

	(*=============*)
	(*  Lightcone  *)
	(*=============*)
	
	SaturatedPropagatorArray=(If[Head@#===Plus,List@@#,List@#])&/@(SaturatedPropagator[[2]]);

	SaturatedPropagatorArray//=(#~PadRight~{Length@#,First@((Length/@#)~TakeLargest~1)})&;

	LightconePropagator=MapThread[
		(xAct`HiGGS`Private`HiGGSParallelSubmit@(ExpressInLightcone[#1,#2]))&,
		{SaturatedPropagatorArray,
		Map[((SourceComponentsToFreeSourceVariables)&),SaturatedPropagatorArray,{2}]},2];
	PrintVariable=PrintTemporary@LightconePropagator;
	LightconePropagator=WaitAll@LightconePropagator;
	NotebookDelete@PrintVariable;

	(*=====================*)
	(*  Massless analysis  *)
	(*=====================*)

	MasslessPropagatorResidue=Map[(xAct`HiGGS`Private`HiGGSParallelSubmit@(NullResidue@#))&,LightconePropagator,{2}];
	PrintVariable=PrintTemporary@MasslessPropagatorResidue;
	MasslessPropagatorResidue=WaitAll@MasslessPropagatorResidue;
	NotebookDelete@PrintVariable;

	MasslessAnalysis=MasslessAnalysisOfTotalList[MasslessPropagatorResidue,UnscaledNullSpace];
	MasslessAnalysisValue=MasslessAnalysis[[2]];

	UpdateTheoryAssociation[TheoryName,MasslessEigenvalues,MasslessAnalysisValue,ExportTheory->OptionValue@ExportTheory];

	Print@"Massless eigenvalues:";
	Print@MasslessAnalysisValue;

	(*================================*)
	(*  Summary of particle spectrum  *)
	(*================================*)

	CillianArgument=ParticleSpectrumSummary[MassiveAnalysis,MassiveGhostAnalysis,MasslessAnalysisValue];	

	Print@"FeynArts representation of particle spectrum:";
	Print@CillianArgument;

	(*=============*)
	(*  Unitarity  *)
	(*=============*)

	PositiveSystemValue=Unitarity[
		MassiveAnalysis,MassiveGhostAnalysis,MasslessAnalysisValue,Couplings];

	Print@"Overall unitarity conditions:";
	Print@PositiveSystemValue;

	UpdateTheoryAssociation[TheoryName,PositiveSystem,PositiveSystemValue,ExportTheory->OptionValue@ExportTheory];

	NotebookDelete@PrintVariable;
];
