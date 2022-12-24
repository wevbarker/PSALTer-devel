(*====================*)
(*  ParticleSpectrum  *)
(*====================*)

(*--------------------------------------------------------*)
(*  Speculative code written on the bus from the airport  *)
(*--------------------------------------------------------*)

SpinParityTensorHeads=<|
		A-><|
			0-><|Even->{AP0p},Odd->{AP0m}|>,
			1-><|Even->{AP1p,APerp1p},Odd->{AP1m,APerp1m}|>,
			2-><|Even->{AP2p},Odd->{AP2m}|>
		|>,
		F-><|
			0-><|Even->{FP0p,FPerp0p},Odd->{}|>,
			1-><|Even->{FP1p},Odd->{FP1m,FPerp1m}|>,
			2-><|Even->{FP2p},Odd->{}|>
		|>
|>;


ExecuteRules[]:=(
AutomaticRules[AP2m,MakeRule[{Evaluate[AP2m[-a,-c,-b]Dagger@AP2m[a,b,c]],Evaluate[(1/2)AP2m[-a,-b,-c]Dagger@AP2m[a,b,c]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[Evaluate[Dagger@AP2m],MakeRule[{Evaluate[Dagger@AP2m[-a,-c,-b]AP2m[a,b,c]],Evaluate[(1/2)Dagger@AP2m[-a,-b,-c]AP2m[a,b,c]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[Evaluate[Dagger@AP2m],MakeRule[{Evaluate[Dagger@AP2m[-a,-b,-c]Eps[d,b,c]],Evaluate[-(1/2)Dagger@AP2m[-b,-c,-a]Eps[d,b,c]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[AP2m,MakeRule[{Evaluate[AP2m[-a,-b,-c]Eps[d,b,c]],Evaluate[-(1/2)AP2m[-b,-c,-a]Eps[d,b,c]]},MetricOn->All,ContractMetrics->True]];
);


QuadraticAnsatz[Tensors__]:=If[Evaluate@Total@((Length@SlotsOfTensor@#)&/@(List@Tensors))>0,
	AllContractions@IndexFree@Times@Tensors,
	Times@@((#[])&/@(List@Tensors))
];

SuadraticAnsatz[Tensors__]:=If[Evaluate@Total@((Length@SlotsOfTensor@#)&/@(List@Tensors))>0,
	AllContractions@IndexFree@((Times@Tensors)~Times~Eps),
	Times@@((#[])&/@(List@Tensors))
];

GenerateAnsatz[Tensors__]:=Catch@Module[{},
	(*
	Print@MatrixForm@(Outer[QuadraticAnsatz,#,(Dagger/@#)]&@(Join@@(SpinParityTensorHeads[Tensor][Spin][Even]~Table~{Tensor,List@Tensors})))
	~Table~{Spin,0,2};
*)
	Print@MatrixForm@(Outer[QuadraticAnsatz,#,(Dagger/@#)]&@(Join@@(SpinParityTensorHeads[Tensor][Spin][Odd]~Table~{Tensor,List@Tensors})))
	~Table~{Spin,0,2};
	Print@MatrixForm@(Outer[SuadraticAnsatz,#[[1]],(Dagger@#)&/@#[[2]]]&@{
	Join@@(SpinParityTensorHeads[Tensor][Spin][Even]~Table~{Tensor,List@Tensors}),
	Join@@(SpinParityTensorHeads[Tensor][Spin][Odd]~Table~{Tensor,List@Tensors})
	})
	~Table~{Spin,0,2};
];

(*~Times~Eps*)

(*
Tensors1=(#@@(ToExpression/@Alphabet[][[1;;(Length@SlotsOfTensor@#)]]))&/@(List@Tensors);
*)



(*-------------------*)
(*  End of bus code  *)
(*-------------------*)

ParticleSpectrum[Expr_,Tensors__]:=Module[{
	PrintVariable,
	FourierDecomposedLagrangian,
	SaturatedPropagator,
	ConstraintComponentList,
	SourceComponents,
	UnscaledNullSpace,
	LightconePropagator,
	RescaledNullSpace,
	SourceComponentsToFreeSourceVariables},

	PrintVariable={};
	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ParticleSpectrum...";

	FourierDecomposedLagrangian=FourierLagrangian[Expr,Tensors];
	SaturatedPropagator=SaturateMe[FourierDecomposedLagrangian];


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

	(*ConstraintComponentList=ConstraintComponentToLightcone/@ConstraintComponentList;*)
	ConstraintComponentList=(xAct`HiGGS`Private`HiGGSParallelSubmit@(ConstraintComponentToLightcone@#))&/@ConstraintComponentList;
	PrintVariable=PrintTemporary@ConstraintComponentList;
	ConstraintComponentList=WaitAll@ConstraintComponentList;
	NotebookDelete@PrintVariable;

	Print/@ConstraintComponentList;

	ConstraintComponentList=DeleteCases[ConstraintComponentList,True];

	SourceComponents=IndependentComponents[Sigma[-a,-b,-c],Tau[-a,-b]];

	UnscaledNullSpace=NullSpace@Last@(ConstraintComponentList~CoefficientArrays~SourceComponents);
	RescaledNullSpace=RescaleNullVector/@UnscaledNullSpace;

	SourceComponentsToFreeSourceVariables=MakeFreeSourceVariables[RescaledNullSpace,SourceComponents];
	LightconePropagator=MassiveAnalysisOfSector[#,SourceComponentsToFreeSourceVariables]&/@SaturatedPropagator[[2]];
	MasslessAnalysisOfTotal[LightconePropagator,UnscaledNullSpace];

	NotebookDelete@PrintVariable;
];
