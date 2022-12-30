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
	ConstraintComponentList,
	SourceComponents,
	UnscaledNullSpace,
	LightconePropagator,
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

	Print@" ** ParticleSpectrum: null eigenvectors of the Lagrangian imply
the following constraints on the source currents (stress-energy and spin
tensors) expressed in the lightcone components where
\[ScriptK]=(\!\(\*SubscriptBox[\(\[ScriptK]\),
\(0\)]\),\!\(\*SubscriptBox[\(\[ScriptK]\),
\(1\)]\),\!\(\*SubscriptBox[\(\[ScriptK]\),
\(2\)]\),\!\(\*SubscriptBox[\(\[ScriptK]\),
\(3\)]\))=(\[ScriptCapitalE],0,0,\[ScriptP]):";

	ConstraintComponentList=MakeConstraintComponentList[SaturatedPropagator[[1]]];
	ConstraintComponentList=xAct`xCoba`SeparateBasis[AIndex][#]&/@ConstraintComponentList;

	(*---------------------------*)
	(*  ConstraintComponentList  *)
	(*---------------------------*)

	ConstraintComponentList=(xAct`HiGGS`Private`HiGGSParallelSubmit@(ConstraintComponentToLightcone@#))&/@ConstraintComponentList;
	PrintVariable=PrintTemporary@ConstraintComponentList;
	ConstraintComponentList=WaitAll@ConstraintComponentList;
	NotebookDelete@PrintVariable;
	Print/@ConstraintComponentList;

	ConstraintComponentList=DeleteCases[ConstraintComponentList,True];
	UpdateTheoryAssociation[TheoryName,SourceConstraintComponents,ConstraintComponentList,ExportTheory->OptionValue@ExportTheory];

	SourceComponents=IndependentComponents[Sigma[-a,-b,-c],Tau[-a,-b]];

	UnscaledNullSpace=NullSpace@Last@(ConstraintComponentList~CoefficientArrays~SourceComponents);
	RescaledNullSpace=RescaleNullVector/@UnscaledNullSpace;

	SourceComponentsToFreeSourceVariables=MakeFreeSourceVariables[RescaledNullSpace,SourceComponents];

	(*-----------------------*)
	(*  LightconePropagator  *)
	(*-----------------------*)

	LightconePropagator=MapThread[
		(xAct`HiGGS`Private`HiGGSParallelSubmit@(MassiveAnalysisOfSector[#1,#2]))&,
		{SaturatedPropagator[[2]],
		SourceComponentsToFreeSourceVariables~Table~({i,Length@(SaturatedPropagator[[2]])})}
	];
	PrintVariable=PrintTemporary@LightconePropagator;
	LightconePropagator=WaitAll@LightconePropagator;
	NotebookDelete@PrintVariable;
	Print/@(#[[2]]&)/@LightconePropagator;

	UpdateTheoryAssociation[TheoryName,SquareMasses,(#[[2]]&)/@LightconePropagator,ExportTheory->OptionValue@ExportTheory];

	MasslessAnalysis=MasslessAnalysisOfTotal[First/@LightconePropagator,UnscaledNullSpace];

	UpdateTheoryAssociation[TheoryName,MasslessEigenvalues,MasslessAnalysis[[2]],ExportTheory->OptionValue@ExportTheory];

	NotebookDelete@PrintVariable;

	If[OptionValue@ExportTheory,
		Print[" ** DefTheory: Exporting the binary at "<>TheoryName<>".thr.mx"];
		DumpSave[FileNameJoin@{$WorkingDirectory,TheoryName<>".thr.mx"},{TheoryName}];
	];
];
