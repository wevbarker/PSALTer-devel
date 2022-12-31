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
	MasslessPropagatorResidue,
	RescaledNullSpace,
	SourceComponentsToFreeSourceVariables,
	MasslessAnalysis,
	MasslessEigenvaluesValues},

	PrintVariable={};
	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ParticleSpectrum...";

	FourierDecomposedLagrangian=FourierLagrangian[Expr,Tensors];
	UpdateTheoryAssociation[TheoryName,MomentumSpaceLagrangian,FourierDecomposedLagrangian,ExportTheory->OptionValue@ExportTheory];

	SaturatedPropagator=SaturateMe[FourierDecomposedLagrangian,Couplings];
	UpdateTheoryAssociation[TheoryName,BMatrices,SaturatedPropagator[[3]],ExportTheory->OptionValue@ExportTheory];
	UpdateTheoryAssociation[TheoryName,InverseBMatrices,SaturatedPropagator[[4]],ExportTheory->OptionValue@ExportTheory];

	ConstraintComponentList=MakeConstraintComponentList[SaturatedPropagator[[1]]];
	ConstraintComponentList=xAct`xCoba`SeparateBasis[AIndex][#]&/@ConstraintComponentList;

	(*---------------------------*)
	(*  ConstraintComponentList  *)
	(*---------------------------*)

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

(**)
	MassiveAnalysis=MapThread[
		(xAct`HiGGS`Private`HiGGSParallelSubmit@(MassiveAnalysisOfSector[#1,#2]))&,
		{(SaturatedPropagator[[2]]),
		Couplings~ConstantArray~(Length@(SaturatedPropagator[[2]]))}];
	PrintVariable=PrintTemporary@MassiveAnalysis;
	MassiveAnalysis=WaitAll@MassiveAnalysis;
	NotebookDelete@PrintVariable;

	UpdateTheoryAssociation[TheoryName,SquareMasses,MassiveAnalysis,ExportTheory->OptionValue@ExportTheory];
(**)
	Print/@MassiveAnalysis;

	(*-----------------------*)
	(*  LightconePropagator  *)
	(*-----------------------*)
	
	SaturatedPropagatorArray=(If[Head@#===Plus,List@@#,List@#])&/@(SaturatedPropagator[[2]]);

	SaturatedPropagatorArray//=(#~PadRight~{Length@#,First@((Length/@#)~TakeLargest~1)})&;

	LightconePropagator=MapThread[
		(xAct`HiGGS`Private`HiGGSParallelSubmit@(ExpressInLightcone[#1,#2]))&,
		{SaturatedPropagatorArray,
		Map[((SourceComponentsToFreeSourceVariables)&),SaturatedPropagatorArray,{2}]},2];
	PrintVariable=PrintTemporary@LightconePropagator;
	LightconePropagator=WaitAll@LightconePropagator;
	NotebookDelete@PrintVariable;

	Print/@LightconePropagator;
(*
	MassiveAnalysis=MapThread[
		(xAct`HiGGS`Private`HiGGSParallelSubmit@(MassiveAnalysisOfSector[#1,#2]))&,
		{LightconePropagator,
		Map[((Couplings)&),LightconePropagator,{2}]},2];
	PrintVariable=PrintTemporary@MassiveAnalysis;
	MassiveAnalysis=WaitAll@MassiveAnalysis;
	NotebookDelete@PrintVariable;
*)

	(*=======================*)
	(*  Massless propagator  *)
	(*=======================*)

	MasslessPropagatorResidue=Map[(xAct`HiGGS`Private`HiGGSParallelSubmit@(NullResidue@#))&,LightconePropagator,{2}];
	PrintVariable=PrintTemporary@MasslessPropagatorResidue;
	MasslessPropagatorResidue=WaitAll@MasslessPropagatorResidue;
	NotebookDelete@PrintVariable;

	MasslessAnalysis=MasslessAnalysisOfTotalList[MasslessPropagatorResidue,UnscaledNullSpace];

	UpdateTheoryAssociation[TheoryName,MasslessEigenvalues,MasslessAnalysis[[2]],ExportTheory->OptionValue@ExportTheory];

	NotebookDelete@PrintVariable;
];
