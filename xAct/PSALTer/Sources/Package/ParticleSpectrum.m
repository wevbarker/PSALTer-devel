(*====================*)
(*  ParticleSpectrum  *)
(*====================*)

BuildPackage@"ParticleSpectrum/UpdateTheoryAssociation.m";
BuildPackage@"ParticleSpectrum/FourierLagrangian.m";
BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator.m";
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

Options@ParticleSpectrum={
	TensorFields->{},
	CouplingConstants->{},
	ExportTheory->False};

ParticleSpectrum[ClassName_?StringQ,TheoryName_?StringQ,Expr_,OptionsPattern[]]:=Module[{
	Tensors=OptionValue@TensorFields,
	Couplings=OptionValue@CouplingConstants,
	PrintVariable,
	DecomposeFieldsdLagrangian,
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

	DecomposeFieldsdLagrangian=FourierLagrangian[ClassName,Expr,Tensors];
	Diagnostic@DecomposeFieldsdLagrangian;

	UpdateTheoryAssociation[TheoryName,MomentumSpaceLagrangian,DecomposeFieldsdLagrangian,ExportTheory->OptionValue@ExportTheory];

	(*========================*)
	(*  Saturated propagator  *)
	(*========================*)

	SaturatedPropagator=ConstructSaturatedPropagator[ClassName,DecomposeFieldsdLagrangian,Couplings];
	UpdateTheoryAssociation[TheoryName,BMatrices,SaturatedPropagator[[3]],ExportTheory->OptionValue@ExportTheory];
	UpdateTheoryAssociation[TheoryName,InverseBMatrices,SaturatedPropagator[[4]],ExportTheory->OptionValue@ExportTheory];
	UpdateTheoryAssociation[TheoryName,SourceConstraints,SaturatedPropagator[[1]],ExportTheory->OptionValue@ExportTheory];

	Print@"The (possibly singular) \[ScriptA]-matrices associated with the Lagrangian, as defined below Eq. (18) of arXiv:1812.02675:";
	(*Print@(MatrixForm/@(SaturatedPropagator[[3]]));*)
	(
		Print@("Matrix for spin-"<>ToString@First@First@((((Plus@@#)&/@Partition[SaturatedPropagator[[3]],2])~Position~#)-1)<>" sector:");
		Print@MatrixForm@#
	)&/@((Plus@@#)&/@Partition[SaturatedPropagator[[3]],2]);

	Print@"Gauge constraints on source currents:";
	Print/@(((Simplify@(#==0))&)/@(SaturatedPropagator[[1]]));

	(*Throw@"hold my sillary";*)

	Print@"The Drazin (Moore-Penrose) inverses of these \[ScriptA]-matrices, which are functionally analogous to the inverse \[ScriptB]-matrices described below Eq. (21) of arXiv:1812.02675:";
	(*Print@(MatrixForm/@(SaturatedPropagator[[4]]));*)
	(
		Print@("Matrix for spin-"<>ToString@First@First@((((Plus@@#)&/@Partition[SaturatedPropagator[[4]],2])~Position~#)-1)<>" sector:");
		Print@MatrixForm@#
	)&/@((Plus@@#)&/@Partition[SaturatedPropagator[[4]],2]);

	(*======================*)
	(*  Source constraints  *)
	(*======================*)

	ConstraintComponentList=MakeConstraintComponentList[ClassName,SaturatedPropagator[[1]]];
	Diagnostic@ConstraintComponentList;
	ConstraintComponentList=xAct`xCoba`SeparateBasis[AIndex][#]&/@ConstraintComponentList;
	Diagnostic@ConstraintComponentList;

	(*ConstraintComponentList=((ConstraintComponentToLightcone[ClassName,#]))&/@ConstraintComponentList;*)
(**)
	ConstraintComponentList=(xAct`PSALTer`Private`PSALTerParallelSubmit@(ConstraintComponentToLightcone[ClassName,#]))&/@ConstraintComponentList;
	PrintVariable=PrintTemporary@ConstraintComponentList;
	ConstraintComponentList=WaitAll@ConstraintComponentList;
	(**)
	NotebookDelete@PrintVariable;
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
		{(SaturatedPropagator[[2]]),
		Couplings~ConstantArray~(Length@(SaturatedPropagator[[2]]))}];
	PrintVariable=PrintTemporary@MassiveAnalysis;
	MassiveAnalysis=WaitAll@MassiveAnalysis;
	NotebookDelete@PrintVariable;

	Print@"Square masses:";
	Print@MassiveAnalysis;

	SignedInverseBMatrices=Times~MapThread~{(SaturatedPropagator[[4]]),(SaturatedPropagator[[5]])};

	MassiveGhostAnalysis=MapThread[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(MassiveGhost[#1,#2]))&,
		{SignedInverseBMatrices,
		MassiveAnalysis}];
	PrintVariable=PrintTemporary@MassiveGhostAnalysis;
	MassiveGhostAnalysis=WaitAll@MassiveGhostAnalysis;
	NotebookDelete@PrintVariable;

	Print@"Massive pole residues:";
	Print@MassiveGhostAnalysis;

	(*PrintMassiveSpectrum[MassiveAnalysis,MassiveGhostAnalysis];*)

	UpdateTheoryAssociation[TheoryName,SquareMasses,MassiveAnalysis,ExportTheory->OptionValue@ExportTheory];

	(*=============*)
	(*  Lightcone  *)
	(*=============*)

	SaturatedPropagatorArray=(If[Head@#===Plus,List@@#,List@#])&/@(SaturatedPropagator[[2]]);
	Diagnostic@SaturatedPropagatorArray;

	SaturatedPropagatorArray//=(#~PadRight~{Length@#,First@((Length/@#)~TakeLargest~1)})&;
	Diagnostic@SaturatedPropagatorArray;

	LightconePropagator=MapThread[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(ExpressInLightcone[ClassName,#1,#2]))&,
		{SaturatedPropagatorArray,
		Map[((SourceComponentsToFreeSourceVariables)&),SaturatedPropagatorArray,{2}]},2];
	PrintVariable=PrintTemporary@LightconePropagator;
	LightconePropagator=WaitAll@LightconePropagator;
	NotebookDelete@PrintVariable;
	Diagnostic@LightconePropagator;

	(*=====================*)
	(*  Massless analysis  *)
	(*=====================*)

	MasslessPropagatorResidue=Map[(xAct`PSALTer`Private`PSALTerParallelSubmit@(NullResidue@#))&,LightconePropagator,{2}];
	PrintVariable=PrintTemporary@MasslessPropagatorResidue;
	MasslessPropagatorResidue=WaitAll@MasslessPropagatorResidue;
	NotebookDelete@PrintVariable;
	Diagnostic@MasslessPropagatorResidue;

	MasslessAnalysis=MasslessAnalysisOfTotal[MasslessPropagatorResidue,UnscaledNullSpace];
	Diagnostic@MasslessAnalysis;
	MasslessAnalysisValue=MasslessAnalysis[[2]];

	UpdateTheoryAssociation[TheoryName,MasslessEigenvalues,MasslessAnalysisValue,ExportTheory->OptionValue@ExportTheory];

	Print@"Massless eigenvalues:";
	Print@MasslessAnalysisValue;

	(*PrintMasslessSpectrum[MasslessAnalysisValue];*)

	(*================================*)
	(*  Summary of particle spectrum  *)
	(*================================*)

	Print@"Overall particle spectrum:";
	PrintSpectrum[MassiveAnalysis,MassiveGhostAnalysis,MasslessAnalysisValue];

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
